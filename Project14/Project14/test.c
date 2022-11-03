#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
int main()
{
	int qwe[10] = { 0 };
	int* p = qwe;
	int i = 0;
	for (i = 0; i < 10; i++)
	{
		printf("%p   <======>   %p\n", p + i, &qwe[i]);
	}
	return 0;
}