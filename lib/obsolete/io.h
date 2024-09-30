#ifndef HEADER__io
#define HEADER__io

#include "basic.h"

#define MULTIPLE__BINARY (u8__LIMIT << 2)
#define io__BUFFER__SIZE (MULTIPLE__BINARY << 3) /* `BUFSIZ`; 8 kiB (8192 bytes) */

#define io__file__PATH__SEPARATOR '/'


/*
	res result: ret

	ch *file__path
*/
#define io__file__EXISTS__PATH(file__path) \
	RETURN__CONVERT__res(access((file__path), F_OK))
/*
        errno
                2: ENOENT: b__exists__not
                13: EACCES: b__accessible__not */

/*
	res result: ret
	int (*function)(`argument`, struct stat64*)
	{ ch* | int } argument
*/
#define _io__file__B__EXISTS(result, function, argument) {\
	struct stat64 st;\
	result = (function(argument, &st)\
		? false\
		: S_ISREG(st.st_mode)); }

/*
	res result: ret
	ch *file__path
*/
#define io__file__B__EXISTS__PATH__ALT(b__result, file__path) \
	_io__file__B__EXISTS(b__result, stat64, filePath)

/*
	res result: ret
	int fd
*/
#define io__file__B__EXISTS__FD(b__result, fd) \
	_io__file__B__EXISTS(b__result, fstat64, fd)

/*
	res result
	ss last_mod
		time, in seconds, of last modification, of the file, associated with the passed `fd`
	int fd
*/
#define io__file__LAST_MOD(result, last_mod, fd) {\
	struct stat64 st;\
	if (fstat64(fd, &st)) \
		result = res__FAILURE;\
	else \
		last_mod = st.st_mtime/*st.st_mtim.tv_sec*/; }

/*
	res result
	ss file__size
	ss (*function)(`argument`, struct stat64*)
	{ ch* | int } argument */
#define _io__file__SIZE(result, file__size, function, argument) {\
	struct stat64 st;\
	if (function(argument, &st))\
		result = res__FAILURE;\
	else \
		file__size = st.st_size; }

/*
	res result: ret
	ss file__size: ret
	ch *file__path */
#define io__file__SIZE__PATH(result, file__size, file__path) \
	_io__file__SIZE(result, file__size, stat64, file__path)

/*
	res result: ret
	ss file__size: ret
	int fd */
#define io__file__SIZE__FD(result, file__size, fd) \
	_io__file__SIZE(result, file__size, fstat64, fd)

/*
	res result: ret
	ch *file__path: expr
	int fd: ret
	int options: typd */
#define _io__file__OPEN(result, file__path, fd, options, permissions) \
	result = (((fd = open64(file__path, options, permissions)) < 0) \
		? res__FAILURE \
		: res__SUCCESS);

#define _io__file__OPEN__OPTIONS (O_DSYNC | O_LARGEFILE)
#define _io__file__OPEN__OPTIONS__SAFE (_io__file__OPEN__OPTIONS | O_SYNC | O_DIRECT)

#define _io__file__PERMISSIONS (S_IRUSR | S_IWUSR)

#define io__file__OPEN__READ_ONLY(result, file__path, fd) \
	_io__file__OPEN(result, file__path, fd, (_io__file__OPEN__OPTIONS | O_RDONLY), 0)

#define io__file__OPEN__READ_WRITE__CREATE(result, file__path, fd) \
	_io__file__OPEN(result, file__path, fd, (_io__file__OPEN__OPTIONS | O_CREAT | O_RDWR), _io__file__PERMISSIONS)

#define io__file__OPEN__READ_WRITE__CREATE__TRUNCATE(result, file__path, fd) \
	_io__file__OPEN(result, file__path, fd, (_io__file__OPEN__OPTIONS | O_TRUNC | O_CREAT | O_RDWR), _io__file__PERMISSIONS)

#define io__file__OPEN__WRITE_ONLY__CREATE__TRUNCATE(result, file__path, fd) \
	_io__file__OPEN(result, file__path, fd, (_io__file__OPEN__OPTIONS | O_TRUNC | O_CREAT | O_WRONLY), _io__file__PERMISSIONS)

#define io__file__OPEN__WRITE_ONLY__CREATE__APPEND(result, file__path, fd) \
	_io__file__OPEN(result, file__path, fd, (_io__file__OPEN__OPTIONS | O_APPEND | O_CREAT | O_WRONLY), _io__file__PERMISSIONS)

#define io__file__OPEN__WRITE_ONLY__CREATE__TRUNCATE__APPEND(result, file__path, fd) \
	_io__file__OPEN(result, file__path, fd, (_io__file__OPEN__OPTIONS | O_APPEND | O_TRUNC | O_CREAT | O_WRONLY), _io__file__PERMISSIONS)

#define io__file__OPEN__READ_WRITE__SAFE(result, file__path, fd) \
	_io__file__OPEN(result, file__path, fd, (_io__file__OPEN__OPTIONS__SAFE | O_RDWR), _io__file__PERMISSIONS)

/*/ *
	res result: ret
	int fd
	ss position: ret
	uu offset: typd
	int option * /
#define _io__file__POSITION(result, fd, ASSIGNMENT, offset, option) \
	result = (((ASSIGNMENT lseek64(fd, offset, option)) < 0) \
		? res__FAILURE \
		: res__SUCCESS);

/ *
	res result: ret
	int fd
	u63 size: ret * /
#define io__file__SIZE__FD__ALT(result, fd, file__size) \
	_io__file__POSITION(result, fd, file__size =, 0, SEEK_END)

/ *
	res result: ret
	int fd
	u63 position: ret * /
#define io__file__POSITION(result, fd, position) \
	_io__file__POSITION(result, fd, position =, 0, SEEK_CUR)

/ *
	res result: ret
	int fd
	u63 position * /
#define io__file__POSITION(result, fd, position) \
	_io__file__POSITION(result, fd, , position, SEEK_SET)*/

#define io__file__res__END/* end-of-file indicator; returned by `io__READ__BLOCKING` */ (1+ res__FAILURE)

#define _io__READ_WRITE__BLOCKING(result, function, fd, buffer, count, offset) {\
	uu offset__io__READ_WRITE__BLOCKING__ = 0;\
	ss count__io__READ_WRITE__BLOCKING__;\
\
	do {\
		if(attribute__expression__EXPECT__TRUE((count__io__READ_WRITE__BLOCKING__ = function(fd, (buffer + offset__io__READ_WRITE__BLOCKING__), count, (offset + offset__io__READ_WRITE__BLOCKING__))) > 0)) {\
			printf("%jd(read_write(%d(fd), buffer, %ju(count), %ju(offset)`)\n",\
				count__io__READ_WRITE__BLOCKING__, fd, count, (offset + offset__io__READ_WRITE__BLOCKING__));\
\
			offset__io__READ_WRITE__BLOCKING__ += count__io__READ_WRITE__BLOCKING__;\
			count -= count__io__READ_WRITE__BLOCKING__;\
		} else {\
			result = (attribute__expression__EXPECT__TRUE(count__io__READ_WRITE__BLOCKING__ < 0) \
				? res__FAILURE \
				: io__file__res__END);\
			break;\
		}\
	} while (count); }
/*
	res result: ret
	ssz function(
	int fd
	void *buffer
	uu count
	uu offset
	
	Why `pread`/`pwrite` combination, over `read`/`write`?
		As checked in the implementations, of all 4, in linux's source-code,
			the former combination is much more efficient, than the latter,
				which also has to get/set the position, both, before and after, the operation, and also handle the mutex locking mechanism,
					and certainly much more complexity, as I only checked till 2x depth, as conclusion was clear */

#define io__READ__BLOCKING(result, fd, buffer, count, offset) \
	puts("io__READ__BLOCKING(");\
	_io__READ_WRITE__BLOCKING(result, /*read*/pread64, fd, buffer, count, offset)
/*
	uu count: mod
		`if(result==io__file__res__END)`
			ret, but data, left to be read, not count of data, already read; as the name would suggest
	returns `io__file__res__END` in `result`, when the end, of file, is detected */

#define io__READ__BLOCKING__ISOLATED(result, fd, buffer, count, offset) \
{\
	uu count__io__READ__BLOCKING__ISOLATED = count;\
	io__READ__BLOCKING(result, fd, buffer, count, offset) }

#define _io__WRITE__BLOCKING(result, fd, buffer, count, offset) {\
	puts("io__WRITE__BLOCKING(");\
	uu count__io__WRITE__BLOCKING_ = count;\
	_io__READ_WRITE__BLOCKING(result, /*write*/pwrite64, fd, buffer, count__io__WRITE__BLOCKING_, offset)\
}

#define io__WRITE__BLOCKING(result, fd, buffer, count, offset) \
	_io__WRITE__BLOCKING(result, fd, buffer, count, offset)

#define io__WRITE__APPEND__BLOCKING(result, fd, buffer, count) \
	io__WRITE__BLOCKING(result, fd, buffer, count, 0)
/*
	fd opened with `__APPEND` routine, will ignore the `offset` arg, and append anyway
		source: "on Linux, if a file is opened with O_APPEND, pwrite() appends data to the end of the file, regardless of the value of offset."(`man 2 pwrite64`."BUGS") */

#define FILE__SYNC(result, fd) {\
	if (!(result = RETURN__CONVERT__res(fdatasync(fd)))) \
		result = fsync(fd); }
/*
	res result: ret
	int fd */

/*/ *
	int! result
	int fD
	uu newSize * /
#define FILE__reSize(fD, newSize) \
	ftruncate64(fD, newSize)

/ *
	int! result
	const char *filePath
	const char *newFilePath * /
#define FILE__reName(filePath, newFilePath) \
	rename(filePath, newFilePath)

/ *
	int! result
	const char *filePath * /
#define FILE__delete(filePath) \
	unlink(filePath)*/

#define io__CLOSE(fd) \
	RETURN__CONVERT__res(close(fd))
/*
	res result: ret

	int fd */

//#define FILE__COPY (fD) ({ do { sendfile64(); } while (); })

#define io__dir__CREATE(path) \
	RETURN__CONVERT__res(mkdir(path, S_IRWXU))
/*
	res result: ret

	ch* path */

#define io__dir__DELETE__EMPTY(path) \
	RETURN__CONVERT__res(rmdir(path))
/*
	res result: ret

	ch* path */

#define io__dir__DELETE__RECURSIVELY(path) {\
	ch command__io__dir__DELETE__RECURSIVELY[(STRING__charCount__INCLUDING_NULL(path) +7)];\
	strcpy((strcpy(command__io__dir__DELETE__RECURSIVELY, "rm -rf ") +7), path);\
	system(command__io__dir__DELETE__RECURSIVELY); }
/*
	res result: ret

	ch* path

	the real programmatic deletion, of non-empty directory,
		requires recursion, which could easily overflow the stack,
			on directories with super large number of sub-directories, like servers, 
		hence leaving this highly care requiring task, on gnu programs, which are written by experts, of c and linux */

#define io__DELETE(file__path) \
	RETURN__CONVERT__res(remove(file__path))
/*
	res result: ret

	ch *file__path
	
	calls `unlink(`2) for files, and `rmdir(`2) for directories */

/*int os_file_size(const char *file, unsigned long long *size_out)
{
	struct uml_stat buf;
	int err;

	err = os_stat_file(file, &buf);
	if (err < 0) {
		printk(UM_KERN_ERR "Couldn't stat \"%s\" : err = %d\n", file,
		       -err);
		return err;
	}

	if (S_ISBLK(buf.ust_mode)) {
		int fd;
		long blocks;

		fd = open(file, O_RDONLY, 0);
		if (fd < 0) {
			err = -errno;
			printk(UM_KERN_ERR "Couldn't open \"%s\", "
			       "errno = %d\n", file, errno);
			return err;
		}
		if (ioctl(fd, BLKGETSIZE, &blocks) < 0) {
			err = -errno;
			printk(UM_KERN_ERR "Couldn't get the block size of "
			       "\"%s\", errno = %d\n", file, errno);
			close(fd);
			return err;
		}
		*size_out = ((long long) blocks) * 512;
		close(fd);
	}
	else *size_out = buf.ust_size;

	return 0;
}

int os_file_modtime(const char *file, long long *modtime)
{
	struct uml_stat buf;
	int err;

	err = os_stat_file(file, &buf);
	if (err < 0) {
		printk(UM_KERN_ERR "Couldn't stat \"%s\" : err = %d\n", file,
		       -err);
		return err;
	}

	*modtime = buf.ust_mtime;
	return 0;
}*/ /* copied, from `linux-master/arch/um/os-Linux/file.c` */

/*int get_file_size(int fd, off_t *size) {
    struct stat st;

    if (fstat(fd, &st) < 0 )
        return -1;
    if(S_ISREG(st.st_mode)) {
        *size = st.st_size;
        return 0;
    } else if (S_ISBLK(st.st_mode)) {
        unsigned long long bytes;

        if (ioctl(fd, BLKGETSIZE64, &bytes) != 0)
            return -1;

        *size = bytes;
        return 0;
    }
    return -1;
}*/

/* forked from `FILE__open__READ_WRITE__CREATE` */
/*#define FILE_SYSTEM__OPEN(\
	result_FILE_SYSTEM__OPEN,\
	/ * const int * /fD_FILE_SYSTEM__OPEN,\
	/ * const char * * /blockDeviceId_FILE_SYSTEM__OPEN) \
{\
	if (access(filePath, (F_OK | R_OK | W_OK))) \
		result_FILE_SYSTEM__OPEN = INDICATE__FAILURE;\
	else \
		if ((fD_FILE_SYSTEM__OPEN = open(("/dev/" #blockDeviceId_FILE_SYSTEM__OPEN), (O_SYNC | / *O_DIRECT |* / O_DSYNC | O_LARGEFILE | O_RDWR))) < 0) \
			result_FILE_SYSTEM__OPEN = INDICATE__FAILURE;\
}*/

#endif
