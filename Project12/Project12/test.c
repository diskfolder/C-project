#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
int main()
{
	int cha[10] = {1,2,3,4,5,7,6,8,9,10};
	int i = 0;
	int* p = cha;
	int  sz = sizeof(cha) / sizeof(cha[0]);
	for (i = 0; i < sz; i++)
	{
		printf("%d ", *p);
		p++;
	}

	return 0;
}