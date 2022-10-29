#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
int main()
{
	int x = 10;
	int y = 88;
	printf("%d %d\n", x, y);
	x = x ^ y;
	y = x ^ y;
	x = x ^ y;
	printf("%d %d",x,y);
	///
	/*int a = 9;
	int b = 18;
	a = a + b;
	b = a - b;
	a = a - b;
	printf("%d %d", a, b); 
	return 0;*/
}