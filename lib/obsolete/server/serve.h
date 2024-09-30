#ifndef SERVE_H
#define SERVE_H

#include <arpa/inet.h>
#include <base__netdb.h>
#include <base__netinet/in.h>
#include <base__netinet/tcp.h>
#include <sys/socket.h>
#include <unistd.h>

#include "../data-structures/byte-array.h"

extern socklen_t sizeOfSockAddrIn, sizeOfSockAddrStorage;

void initServeVars ();

void serveTCP (const char *ipv4,
			   const uint16_t port,
			   int processRequests (ByteArrayCollection *,
									ByteArray **));

#endif
