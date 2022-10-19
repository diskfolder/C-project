#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
int main()
{
	long a ;
	long n ;
	long ret = 1;
	int b, c, d, e, f, g, h, i, j;
	
	scanf("%d", &n);
		for (a = 1; a <= n; a++)
	{
		ret = ret * a;
	

	}
	printf("%d", ret);


	return 0;
}