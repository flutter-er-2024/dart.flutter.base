#include "basic.h"
#include "io.h"

void test()
	TEST

int file__open(
	ch const * const file__path)
{
	res__CREAT(result)
	int fd;

	io__file__OPEN__READ_WRITE__SAFE(result, file__path, fd)

	return (result
		? -1
		: fd);
}

res file__read(
	const int fd,
	by const * const buffer,
	uu count,
	uu offset)
{
	res__CREAT(result)
	io__READ__BLOCKING(result, fd, buffer, count, offset)
	return result;
}

res file__write(
	const int fd,
	by const * const buffer,
	uu count,
	uu offset)
{
	res__CREAT(result)
	io__WRITE__BLOCKING(result, fd, buffer, count, offset)
	return result;
}

res file__sync(
	const int fd)
{
	res__CREAT(result)
	FILE__SYNC(result, fd)
	return result;
}

res file__close(
	const int fd)
{
	return io__CLOSE(fd);
}
