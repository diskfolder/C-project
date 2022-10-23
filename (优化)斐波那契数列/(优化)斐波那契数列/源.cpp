#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
int all(int n)
{
	int a = 1;
	int b = 1;
	int c = 1;
	while (n > 2)
	{
		c = a + b;
		a = b;
		b = c;
		n--;
	}
	return c;
}
int main()
{
	int x = 0;
	printf("请输入一个数字。\n");
	scanf("%d", &x);
	printf("第%d个斐波那契数是:%d\n", x,all(x));
	return 0;
}