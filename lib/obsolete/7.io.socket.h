#include "5.io.h"

/**
	correct implementation using io_uring: `http://github.com/shuveb/loti-examples`
		more related examples: `http://github.com/shuveb?tab=repositories&q=&type=&language=c&sort=`
		source: `http://unixism.net/loti/index.html`

	epoll gives readiness events, like "fD has some data, and is ready to be read",
	while io_uring is the super solution, covering everything,
		it has a submission-queue, called "cqe", where the user puts the requests, for operations,
			and the kernel completes them, one by one, and automatically, and in non-blocking and async style,
				and puts the results into the completion-queue, called "cqe"
		clear and very good explanation: `http://www.scylladb.com/2020/05/05/how-io_uring-and-ebpf-will-revolutionize-programming-in-linux/`

	https://lwn.net/Kernel/Index/#io_uring
*/

result printRequest(BYTES__DS__Array *byteArray);

/**
	example:
		`serveTCP("127.0.0.1", 8192, printRequest);`
*/
void serveTCP(
	const char* ipv4,
	const u16 port,
	result resolveRequest(BYTES__DS__Array *));
