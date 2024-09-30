#include <stdio.h>

#define PRINT(id_) printf("%d(" #id ")\t\t%p(&" #id ")\n", id, &id_);

int main(void_)
{
	int a = 0;
	PRINT(a)

	int
		*a__addr, a__val,
		*b__addr, b__val;

	{
		a += 1;
		PRINT(a)

		int a = 3222;

		a__addr = &a;
		a__val = a;

		PRINT(a)

		int b = 799;

		b__addr = &b;
		b__val = b;

		PRINT(b)
	}

	PRINT(a)

	int b;
	PRINT(b)

	int c;
	PRINT(c)

	if (((a__addr == &b) && (a__val == b)) &&
		((b__addr == &c) && (b__val == c))) 
		puts(
			"\n"
			"creating blocks, inside a function(stack frame),\n\t"
			"allows the code after the block, to re-use(conserve) the memory,\n\t"
			"which was previously used, by the variables of the (now preceding) block,\n\t"
			"*hence* a good(and recommended) practice");

	return 0;
}
