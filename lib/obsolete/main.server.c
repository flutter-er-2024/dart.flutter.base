#include "convert.h"
#include "data-structures/byte-array.h"
#include "server/serve.h"

typedef int (*RequestProcessor)(ByteArray *, ByteArray **);

/**
	array of functions, to handle top-level-destinations,
		others(nested destinations) are handled without functions,
			for performance, and efficiency; reasons; also to reduce complications
*/
RequestProcessor *requestProcessors;

int processRequests (ByteArrayCollection *rawRequest,
					 ByteArray **response)
{
	ByteArray *request;

	collectAndFreeByArrColl(&rawRequest, &request);

	FREE_MEM(request);

	{
		puts("\nprinting request:\n");

		u64 i = 0;
		while (i < (*request).byteCount) {
			char c = *((*request).bytes + i++);

			printf ("\n%c\t%hu\t%c", c, c,
					((c == '\r') ? 'R' : ((c == '\n') ? 'N' : ' ')));
		}

		puts("\n:request printed");
	}

	printf("\n%d(requestProcessor())", (/* * */*(requestProcessors + *(*request).bytes))(request, response));

	CHECK_VOID_SAFE((*response = malloc(sizeOfByteArray)), "`*response=malloc()`");

	char str[] = "resolved";
	u64 strLength = strlen(str);

	CHECK_VOID_SAFE(((**response).bytes = malloc(strLength)), "`(**response).bytes=malloc()`")

	memcpy((**response).bytes,
		   str,
		   strLength);

	(**response).byteCount = strLength;

	return EXIT_SUCCESS;
}

int processRequest0 (ByteArray  *request, ByteArray **response);
int processRequest1 (ByteArray  *request, ByteArray **response);

int main(void_) {
	initBasicVars("/tmp/history.log");
	initByteArrayVars();
	initServeVars();

	/** init local variables */
	{
		CHECK_VOID_SAFE((requestProcessors = malloc ((sizeof(processRequest0)
														  + sizeof(processRequest1)))),
						"`requestProcessors=malloc()`");

		RequestProcessor *iterator = requestProcessors;

		*(iterator++) = processRequest0;
		*(iterator++) = processRequest1;
	}

	serveTCP("192.168.1.4",
			 32768,
			 processRequests);

	return EXIT_SUCCESS;
}

int processRequest0 (ByteArray  *request,
					 ByteArray **response)
{
	puts("`processRequest0` called");
	return INDICATE_FAILURE;
}

int processRequest1 (ByteArray  *request,
					 ByteArray **response)
{
	puts("`processRequest1` called");
	return INDICATE_FAILURE;
}
