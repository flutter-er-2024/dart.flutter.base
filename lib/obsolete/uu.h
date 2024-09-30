
/*
	uu i: ret
		integer
	by *bys
		bys
	sz size
		i__size */
#define by__array__CONVERT__uu(\
	i__by__array__CONVERT__uu, \
	bys__by__array__CONVERT__uu, \
	size__by__array__CONVERT__uu) {\
	switch (size__by__array__CONVERT__uu) {\
		case u64__SIZE: i__by__array__CONVERT__uu = *((u64 *)bys__by__array__CONVERT__uu); break;\
		case u32__SIZE: i__by__array__CONVERT__uu = *((u32 *)bys__by__array__CONVERT__uu); break;\
		case u16__SIZE: i__by__array__CONVERT__uu = *((u16 *)bys__by__array__CONVERT__uu); break;\
		case  u8__SIZE: i__by__array__CONVERT__uu =  *((u8 *)bys__by__array__CONVERT__uu); break;\
		case u24__SIZE: i__by__array__CONVERT__uu = *((u32 *)bys__by__array__CONVERT__uu); break; } }
