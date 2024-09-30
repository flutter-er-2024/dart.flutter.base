#include "serve.h"
#include <fcntl.h>

/* from dart
int isBadPort(int port) {
  if ((port < 0) || (port > 0xFFFF)) {
    return 1;
  }
}
int64_t getCurrentTimeMicros() {
  struct timeval tv;

  if (gettimeofday(&tv, NULL) < 0) {
    return 0;
  }

  return (tv.tv_sec * 1000000) + tv.tv_usec;
}
constexpr int8_t kMinInt8 = 0x80;
constexpr int8_t kMaxInt8 = 0x7F;
constexpr uint8_t kMaxUint8 = 0xFF;
constexpr int16_t kMinInt16 = 0x8000;
constexpr int16_t kMaxInt16 = 0x7FFF;
constexpr uint16_t kMaxUint16 = 0xFFFF;
constexpr int32_t kMinInt32 = 0x80000000;
constexpr int32_t kMaxInt32 = 0x7FFFFFFF;
constexpr uint32_t kMaxUint32 = 0xFFFFFFFF;
constexpr int64_t kMinInt64 = DART_INT64_C(0x8000000000000000);
constexpr int64_t kMaxInt64 = DART_INT64_C(0x7FFFFFFFFFFFFFFF);
constexpr uint64_t kMaxUint64 = DART_2PART_UINT64_C(0xFFFFFFFF, FFFFFFFF);
// Time constants.
constexpr int kMillisecondsPerSecond = 1000;
constexpr int kMicrosecondsPerMillisecond = 1000;
constexpr int kMicrosecondsPerSecond =
    (kMicrosecondsPerMillisecond * kMillisecondsPerSecond);
constexpr int kNanosecondsPerMicrosecond = 1000;
constexpr int kNanosecondsPerMillisecond =
    (kNanosecondsPerMicrosecond * kMicrosecondsPerMillisecond);
constexpr int kNanosecondsPerSecond =
    (kNanosecondsPerMicrosecond * kMicrosecondsPerSecond);

bool SocketBase::RawAddrToString(RawAddr* addr, char* str) {
  if (addr->addr.sa_family == AF_INET) {
    return inet_ntop(AF_INET, &addr->in.sin_addr, str, INET_ADDRSTRLEN) != NULL;
  } else {
    ASSERT(addr->addr.sa_family == AF_INET6);
    return inet_ntop(AF_INET6, &addr->in6.sin6_addr, str, INET6_ADDRSTRLEN) !=
           NULL;
  }
}

bool SocketBase::GetNoDelay(intptr_t fd, bool* enabled) {
  int on;
  socklen_t len = sizeof(on);
  int err = NO_RETRY_EXPECTED(getsockopt(fd, IPPROTO_TCP, TCP_NODELAY,
                                         reinterpret_cast<void*>(&on), &len));
  if (err == 0) {
    *enabled = (on == 1);
  }
  return (err == 0);
}

bool SocketBase::SetNoDelay(intptr_t fd, bool enabled) {
  int on = enabled ? 1 : 0;
  return NO_RETRY_EXPECTED(setsockopt(fd, IPPROTO_TCP, TCP_NODELAY,
                                      reinterpret_cast<char*>(&on),
                                      sizeof(on))) == 0;
}

AddressList<InterfaceSocketAddress>* SocketBase::ListInterfaces(
    int type,
    OSError** os_error) {
  struct ifaddrs* ifaddr;

  int status = NO_RETRY_EXPECTED(getifaddrs(&ifaddr));
  if (status != 0) {
    ASSERT(*os_error == NULL);
    *os_error =
        new OSError(status, gai_strerror(status), OSError::kGetAddressInfo);
    return NULL;
  }

  int lookup_family = SocketAddress::FromType(type);

  intptr_t count = 0;
  for (struct ifaddrs* ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next) {
    if (ShouldIncludeIfaAddrs(ifa, lookup_family)) {
      count++;
    }
  }

  AddressList<InterfaceSocketAddress>* addresses =
      new AddressList<InterfaceSocketAddress>(count);
  int i = 0;
  for (struct ifaddrs* ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next) {
    if (ShouldIncludeIfaAddrs(ifa, lookup_family)) {
      char* ifa_name = DartUtils::ScopedCopyCString(ifa->ifa_name);
      addresses->SetAt(
          i, new InterfaceSocketAddress(ifa->ifa_addr, ifa_name,
                                        if_nametoindex(ifa->ifa_name)));
      i++;
    }
  }
  freeifaddrs(ifaddr);
  return addresses;
}

union RawAddr {
  struct sockaddr_in in;
  struct sockaddr_in6 in6;
  struct sockaddr_un un;
  struct sockaddr_storage ss;
  struct sockaddr addr;
};

bool SocketBase::ParseAddress(int type, const char* address, RawAddr* addr) {
  int result;
  if (type == SocketAddress::TYPE_IPV4) {
    result = NO_RETRY_EXPECTED(inet_pton(AF_INET, address, &addr->in.sin_addr));
  } else {
    ASSERT(type == SocketAddress::TYPE_IPV6);
    result =
        NO_RETRY_EXPECTED(inet_pton(AF_INET6, address, &addr->in6.sin6_addr));
  }
  return (result == 1);
}

`getpeername()`/ ** for `GetRemotePeer` * /
`getsockname()`/ ** for `GetSocketName`, should be our * /

static bool IsTemporaryAcceptError(int error) {
  // On Linux a number of protocol errors should be treated as EAGAIN.
  // These are the ones for TCP/IP.
  return (error == EAGAIN) || (error == ENETDOWN) || (error == EPROTO) ||
         (error == ENOPROTOOPT) || (error == EHOSTDOWN) || (error == ENONET) ||
         (error == EHOSTUNREACH) || (error == EOPNOTSUPP) ||
         (error == ENETUNREACH);
}

intptr_t ServerSocket::CreateBindListen(const RawAddr& addr,
                                        intptr_t backlog,
                                        bool v6_only) {
  intptr_t fd;

  fd = NO_RETRY_EXPECTED(
      socket(addr.ss.ss_family, SOCK_STREAM | SOCK_CLOEXEC | SOCK_NONBLOCK, 0));
  if (fd < 0) {
    return -1;
  }

  int optval = 1;
  VOID_NO_RETRY_EXPECTED(
      setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &optval, sizeof(optval)));

  if (addr.ss.ss_family == AF_INET6) {
    optval = v6_only ? 1 : 0;
    VOID_NO_RETRY_EXPECTED(
        setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &optval, sizeof(optval)));
  }

  if (NO_RETRY_EXPECTED(
          bind(fd, &addr.addr, SocketAddress::GetAddrLength(addr))) < 0) {
    FDUtils::SaveErrorAndClose(fd);
    return -1;
  }

  // Test for invalid socket port 65535 (some browsers disallow it).
  if ((SocketAddress::GetAddrPort(addr) == 0) &&
      (SocketBase::GetPort(fd) == 65535)) {
    // Don't close the socket until we have created a new socket, ensuring
    // that we do not get the bad port number again.
    intptr_t new_fd = CreateBindListen(addr, backlog, v6_only);
    FDUtils::SaveErrorAndClose(fd);
    return new_fd;
  }

  if (NO_RETRY_EXPECTED(listen(fd, backlog > 0 ? backlog : SOMAXCONN)) != 0) {
    FDUtils::SaveErrorAndClose(fd);
    return -1;
  }

  return fd;
}

intptr_t ServerSocket::Accept(intptr_t fd) {
  intptr_t socket;
  struct sockaddr clientaddr;
  socklen_t addrlen = sizeof(clientaddr);
  socket = TEMP_FAILURE_RETRY(accept(fd, &clientaddr, &addrlen));
  if (socket == -1) {
    if (IsTemporaryAcceptError(errno)) {
      // We need to signal to the caller that this is actually not an
      // error. We got woken up from the poll on the listening socket,
      // but there is no connection ready to be accepted.
      ASSERT(kTemporaryFailure != -1);
      socket = kTemporaryFailure;
    }
  } else {
    if (!FDUtils::SetCloseOnExec(socket)) {
      FDUtils::SaveErrorAndClose(socket);
      return -1;
    }
    if (!FDUtils::SetNonBlocking(socket)) {
      FDUtils::SaveErrorAndClose(socket);
      return -1;
    }
  }
  return socket;
}

intptr_t SocketBase::Read(intptr_t fd,
                          void* buffer,
                          intptr_t num_bytes,
                          SocketOpKind sync) {
  ASSERT(fd >= 0);
  ssize_t read_bytes = TEMP_FAILURE_RETRY(read(fd, buffer, num_bytes));
  ASSERT(EAGAIN == EWOULDBLOCK);
  if ((sync == kAsync) && (read_bytes == -1) && (errno == EWOULDBLOCK)) {
    // If the read would block we need to retry and therefore return 0
    // as the number of bytes written.
    read_bytes = 0;
  }
  return read_bytes;
}

intptr_t SocketBase::Write(intptr_t fd,
                           const void* buffer,
                           intptr_t num_bytes,
                           SocketOpKind sync) {
  ASSERT(fd >= 0);
  ssize_t written_bytes = TEMP_FAILURE_RETRY(write(fd, buffer, num_bytes));
  ASSERT(EAGAIN == EWOULDBLOCK);
  if ((sync == kAsync) && (written_bytes == -1) && (errno == EWOULDBLOCK)) {
    // If the would block we need to retry and therefore return 0 as
    // the number of bytes written.
    written_bytes = 0;
  }
  return written_bytes;
}
*/

socklen_t sizeOfSockAddrIn, sizeOfSockAddrStorage;

void initServeVars()
{
  sizeOfSockAddrIn = sizeof(struct sockaddr_in),
  sizeOfSockAddrStorage = sizeof(struct sockaddr_storage);
}

void serveTCP(const char *ipv4,
              const uint16_t port,
              int processRequests(ByteArrayCollection *,
                                  ByteArray **))
{
  /** recv buffer size */
  const u64 recvBufSze = (256 * 1024) /** `man 7 tcp | grep tcp_rmem`, `cat /proc/sys/net/ipv4/tcp_rmem` */;

  /** server socket descriptor */
  const int srvrSockDesc = socket(PF_INET,
                                  (SOCK_STREAM | SOCK_NONBLOCK),
                                  IPPROTO_TCP /** `getprotobyname("tcp")->p_proto`, `cat /etc/protocols`, `cat /usr/share/iana-etc/protocol-numbers.iana` */);

  registerValue("srvrSockDesc", srvrSockDesc);

  if (srvrSockDesc == INDICATE_FAILURE)
  {
    registerError("socket(PF_INET,SOCK_STREAM,IPPROTO_TCP)", srvrSockDesc);

    exit(INDICATE_FAILURE);
  }

  {
    int
        enableOption = 1,
        setOptRes;

    setOptRes /** result */ = setsockopt(srvrSockDesc,
                                         IPPROTO_TCP /* TODO: check versus `SOL_SOCKET` */,
                                         TCP_NODELAY,
                                         &enableOption,
                                         SIZE_INT);

    if ((setOptRes != EXIT_SUCCESS) || (setOptRes == INDICATE_FAILURE))
    {
      registerError("setsockopt(srvrSockDesc,...,TCP_NODELAY,...)", setOptRes);

      exit(INDICATE_FAILURE);
    }

    enableOption = 1;
    socklen_t size = sizeof(enableOption);

    registerValue("enableOption", enableOption);

    registerValue("getsockopt(...,TCP_NODELAY,...)",
                  getsockopt(srvrSockDesc,
                             IPPROTO_TCP,
                             TCP_NODELAY /* `TCP_FASTOPEN` */,
                             &enableOption,
                             &size));

    registerValue("enableOption", enableOption);
  }

  // int fcntlResult = fcntl(srvrSockDesc, O_NONBLOCK);

  struct sockaddr_in /** ipv4 */ srvrSockAddr /** server socket address  */;

  memset(&srvrSockAddr,
         0,
         sizeOfSockAddrIn);

  srvrSockAddr.sin_family = AF_INET;
  srvrSockAddr.sin_addr.s_addr = inet_addr(ipv4);
  srvrSockAddr.sin_port = htons(port);

  int bindRes /** binding result */ = bind(srvrSockDesc,
                                           (struct sockaddr *)&srvrSockAddr,
                                           sizeOfSockAddrIn);

  registerValue("bindRes", bindRes);

  if ((bindRes != EXIT_SUCCESS) || (bindRes == INDICATE_FAILURE))
  {
    registerError("bind(srvrSockDesc,...)", bindRes);

    exit(INDICATE_FAILURE);
  }

  int listenRes /** listening result*/ = listen(srvrSockDesc,
                                                SOMAXCONN);

  registerValue("listenRes", listenRes);

  if ((listenRes != EXIT_SUCCESS) || (listenRes == INDICATE_FAILURE))
  {
    registerError("listen(srvrSockDesc,...)", listenRes);

    exit(INDICATE_FAILURE);
  }

  u64 requestCounter = 0;

  while (1)
  {
    u64 tag = requestCounter++;

    ByteArray *response;

    struct sockaddr_storage /** ipv4, as well as ipv6 */ clntSockAddr /** clientSocketAddress */;

    memset(&clntSockAddr,
           0,
           sizeOfSockAddrStorage);

    /** client socket descriptor */
    int clntSockDesc = accept(srvrSockDesc,
                              (struct sockaddr *)&clntSockAddr,
                              &sizeOfSockAddrStorage);

    if (clntSockDesc == INDICATE_FAILURE)
    {
      registerError("accept(srvrSockDesc,...)", clntSockDesc);

      CHECK_VOID_SAFE((response = malloc(sizeOfByteArray)), "`response=malloc()`");

      (*response).bytes = NULL;
      (*response).byteCount = 0;

      goto finish;
    }

    {
      char *addressString;

      if (clntSockAddr.ss_family == AF_INET6)
      {
        u8 *networkIP = (*(struct sockaddr_in6 *)&clntSockAddr).sin6_addr.s6_addr;

        for (u64 i = 0; i < 16 /** IPv6.size: 2 * 8 bytes (max address has 8 groups of 16 bit integers) */; i += 1)
        {
          printf("%hu(ip block %lu)",
                 *(networkIP + i),
                 i);
        }

        addressString = malloc((INET6_ADDRSTRLEN * SIZE_CHAR));

        if (inet_ntop(AF_INET6,
                      &(*(struct sockaddr_in6 *)&clntSockAddr).sin6_addr,
                      addressString,
                      INET6_ADDRSTRLEN) == NULL)
        {
          registerError("inet_ntop(AF_INET6,...)", INDICATE_FAILURE);

          // TODO non-fatel error encountered
        }
      }
      else
      {
        u32 base__networkIP = (*(struct sockaddr_in *)&clntSockAddr).sin_addr.s_addr;

        putchar('\n');
        printf("%u\t", base__networkIP);
        for (u64 i = 0; i < u32__size /** IPv4.size: 1 * 4 bytes */; i += 1)
        {
          printf("%u:", (255 & (networkIP >>= SIZE_BYTE)));
        }
        putchar('\b');

        addressString = malloc((INET_ADDRSTRLEN * SIZE_CHAR));

        if (inet_ntop(AF_INET,
                      &(*(struct sockaddr_in *)&clntSockAddr).sin_addr,
                      addressString,
                      INET_ADDRSTRLEN) == NULL)
        {
          registerError("inet_ntop(AF_INET,...)", INDICATE_FAILURE);

          // TODO non-fatel error encountered
        }
      }

      registerInfo("addressString", addressString);
    }

    ByteArrayCollection *collection;
    allocAndInitByArrColl(&collection);

    while (1)
    {
      u8 recvBuffer[recvBufSze];

      ssize_t recved = recv(clntSockDesc,
                            recvBuffer,
                            recvBufSze,
                            0);

      registerValue("recved", recved);

      if (recved == INDICATE_FAILURE)
      {
        registerError("recv(clntSockDesc,...)", recved);

        CHECK_VOID_SAFE((response = malloc(sizeOfByteArray)), "`response=malloc()`");

        (*response).bytes = NULL;
        (*response).byteCount = 0;

        goto finish;
      }

      if (recved == 0)
      {
        goto resolve;
      }

      ByteArray *byteArray = malloc(sizeOfByteArray);
      CHECK_VOID_SAFE(byteArray, "`byteArray=malloc()`");

      CHECK_VOID_SAFE(((*byteArray).bytes = malloc(recved)), "`(*byteArray).bytes=malloc()`");

      memcpy((*byteArray).bytes,
             recvBuffer,
             recved);

      (*byteArray).byteCount = recved;

      appendByArrToColl(byteArray, collection);
    }

  resolve:

    if (processRequests(collection, &response))
    {
      CHECK_VOID_SAFE((response = malloc(sizeOfByteArray)), "`response=malloc()`");

      (*response).bytes = NULL; // error, when `send` tries to send `NULL`
      (*response).byteCount = 0;
    }

  finish:

  {
    u64
        byteCounter = 0,
        byteCount = (*response).byteCount;

    ssize_t result;

    do
    {
      result = send(clntSockDesc,
                    ((*response).bytes + byteCounter),
                    byteCount,
                    0);

      if (result == INDICATE_FAILURE)
      {
        registerError("send(clntSockDesc,...)", result);

        break;
      }

      byteCounter += result;
      byteCount -= result;
    } while (byteCount != 0);

    FREE_MEM(response);
  }

    int closRes = close(clntSockDesc);

    if ((closRes != EXIT_SUCCESS) || (closRes == INDICATE_FAILURE))
    {
      registerError("close(clntSockDesc)", closRes);
    }

    puts("\n\n");
  }
}
cat / proc / sys / fs / file - max
