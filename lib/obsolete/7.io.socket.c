#include "7.io.socket.h"

/*union RawAddress {
	struct sockaddr_in in;
	struct sockaddr_in6 in6;
	struct sockaddr_un un;
	struct sockaddr_storage ss;
	struct sockaddr addr;
};*/

/*int isBadPort(int port) {
	if ((port < 0) || (port > U16__MAX)) {
		return 1;
	}
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
}*/

/*socklen_t sizeOfSockAddrIn, sizeOfSockAddrStorage;

void initServeVars()
{
	sizeOfSockAddrIn = sizeof(struct sockaddr_in),
	sizeOfSockAddrStorage = sizeof(struct sockaddr_storage);
}*/

/** `cat /proc/sys/fs/file-max` for max open fDs */

result printRequest(BYTES__DS__Array *byteArray) {
	BYTES__PRINT((*byteArray).bytes, (*byteArray).count)

	return INDICATE__FAILURE;
}

#define _GET_SET__TCP_NO_DELAY(function, sockFD, len) \
	CHECK__RETURNED__INT__SUCCESS_ELSE_REPORT_AND_ABORT(\
		function(\
			sockFD,\
			IPPROTO_TCP,\
			TCP_NODELAY,\
			&bEnabled,\
			len),\
		"`" #function "(" #sockFD ", IPPROTO_TCP, TCP_NODELAY`", 0)

/**
	void
	const int sockFD
*/
#define _SET__TCP_NO_DELAY(sockFD) {\
	int bEnabled;\
	socklen_t len = sizeof(bEnabled);\
\
	_GET_SET__TCP_NO_DELAY(getsockopt, sockFD, &len)\
\
	printf("`TCP_NODELAY` is %s, on `" #sockFD "` %d\n", (bEnabled ? "enabled" : "DISABLED"), 0);\
\
	if (!bEnabled) {\
		bEnabled = 1;\
\
		_GET_SET__TCP_NO_DELAY(setsockopt, sockFD, len)\
	}\
}

void serveTCP(
	const char* ipv4,
	const u16 port,
	result resolveRequest(BYTES__DS__Array *)) {
	const int serverSocketDescriptor = socket(
		PF_INET,
		(SOCK_STREAM /*| SOCK_NONBLOCK*/),
		IPPROTO_TCP /** `getprotobyname("tcp")->p_proto`, `cat /etc/protocols`, `cat /usr/share/iana-etc/protocol-numbers.iana` */);

	CHECK__RETURNED__INT__SUCCESS_ELSE_REPORT_AND_ABORT(serverSocketDescriptor, "`socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)`", 0)

	_SET__TCP_NO_DELAY(serverSocketDescriptor)

	struct sockaddr_in/** IPv4 */ serverSocketAddress;

	memset(&serverSocketAddress, 0, sizeof(serverSocketAddress));

	serverSocketAddress.sin_family = AF_INET;
	inet_pton(AF_INET, ipv4, &serverSocketAddress.sin_addr.s_addr);
	serverSocketAddress.sin_port = htons(port);

	CHECK__RETURNED__INT__SUCCESS_ELSE_REPORT_AND_ABORT(
		bind(
			serverSocketDescriptor,
			(struct sockaddr*)&serverSocketAddress,
			sizeof(serverSocketAddress)),
		"`bind(serverSocketDescriptor,serverSocketAddress,sizeof(serverSocketAddress))`", 0)

	CHECK__RETURNED__INT__SUCCESS_ELSE_REPORT_AND_ABORT(
		listen(
			serverSocketDescriptor,
			SOMAXCONN),
		"`listen(serverSocketDescriptor, SOMAXCONN)`", 0)

	uu requestCounter = 0;
	
	const socklen_t clientSocketSize = sizeof(struct sockaddr_storage);

	label_loop_accept:
		uu tag = requestCounter++;

		BYTES__DS__Array byteArray = { ZERO__UNSIGNED_LONG };

		struct sockaddr_storage/** IPv4 + IPv6 */ clientSocketAddress;

		memset(&clientSocketAddress, 0, sizeof(clientSocketAddress));

		int clientSocketDescriptor;

		if ((clientSocketDescriptor = accept(
				serverSocketDescriptor,
				(struct sockaddr *)&clientSocketAddress,
				&clientSocketSize)) < 0) {
			PRINT_ERROR("`accept(serverSocketDescriptor,clientSocketAddress,clientSocketSize)` failed", 0)

			goto finish;
		}

		_SET__TCP_NO_DELAY(clientSocketDescriptor)

		printf("a new client has established connection" ", %lu(tag)", tag);

		{
			char *addressString;
			u16 port;

			result r;

			if(clientSocketAddress.ss_family == AF_INET6) {
				char *iNet6 = (*(struct sockaddr_in6 *)&clientSocketAddress).sin6_addr.s6_addr/*.__u6_addr8*/;

				MEM__ALLOC__ARRAY(addressString, INET6_ADDRSTRLEN)

				r = (inet_ntop(
						AF_INET6,
						&(*(struct sockaddr_in6 *)&clientSocketAddress).sin6_addr,
						addressString,
						INET6_ADDRSTRLEN) == NULL);

				port = ntohs((*(struct sockaddr_in6 *)&clientSocketAddress).sin6_port);
			} else if (clientSocketAddress.ss_family == AF_INET) {
				in_addr_t iNet = (*(struct sockaddr_in *)&clientSocketAddress).sin_addr.s_addr;

				MEM__ALLOC__ARRAY(addressString, INET_ADDRSTRLEN)

				r = (inet_ntop(
						AF_INET,
						&(*(struct sockaddr_in *)&clientSocketAddress).sin_addr,
						addressString,
						INET_ADDRSTRLEN) == NULL);

				port = ntohs((*(struct sockaddr_in *)&clientSocketAddress).sin_port);
			}

			if(r)
				goto finish;

			printf(", with %s:%hu(ip:port)\n", addressString, port);
			MEM__FREE(addressString)
		}

		BYTES__DS__Collection collection;
		BYTES__Collection__INIT(collection);

		label_loop_receive:
			by *receiveBuffer/**  */;
			MEM__ALLOC__ARRAY(receiveBuffer, SIZE__BUFFER)

			ssize_t received = recv(clientSocketDescriptor,
				receiveBuffer,
				SIZE__BUFFER/**
	the upper limit, of TCP's packet size, is `U16__MAX`, including the TCP's meta data
	maybe useful:
		`man 7 tcp | grep tcp_rmem`, `cat /proc/sys/net/ipv4/tcp_rmem` */,
				0);

			printf("`received` %lu bytes\n", received);

			if (received < 0) {
				MEM__FREE(receiveBuffer)
				PRINT_ERROR("", 0)
				goto finish; }

			if (received == 0) {
				MEM__FREE(receiveBuffer)
				goto resolve; }

			BYTES__Collection__APPEND(collection, receiveBuffer, received, SIZE__BUFFER)

			goto label_loop_receive;

	resolve:
		BYTES__Collection__COLLECT_AND_FREE(collection, byteArray.bytes, byteArray.count)
		resolveRequest(&byteArray);

	finish:
		RESULT__INIT(r)
		{
			uu _count;
			by *_buffer = ((_count = byteArray.count) ? byteArray.bytes : NULL);
			is sentCount;

			do {
				CHECK__RETURNED_ERROR__LONG(sentCount = send(clientSocketDescriptor, _buffer, _count, 0)) {
					r = INDICATE__FAILURE;
					break;
				} else {
					/*printf("%lu(sentCount)\n", sentCount); FILE__sync(STDOUT_FILENO);*/\

					_buffer += sentCount;
					_count -= sentCount;
				}
			} while (_count);
		}/** forked from `IO__WRITE__BLOCKING` */

		CHECK__RESULT__SUCCESS_ELSE_REPORT_AND_ABORT(
			r,
			"`send`, %lu bytes, to %d(sockFD, %lu(tag))", byteArray.count, clientSocketDescriptor, tag)

		CHECK__RETURNED__INT__SUCCESS_ELSE_REPORT_AND_ABORT(
			IO__close(clientSocketDescriptor),
			"`IO__close(clientSocketDescriptor)`", 0)

		goto label_loop_accept;
}

#undef _SET__TCP_NO_DELAY
#undef _GET_SET__TCP_NO_DELAY
