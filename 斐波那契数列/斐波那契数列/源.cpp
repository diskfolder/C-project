#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
int count = 0;
int Fib(int x)
{
	if (x ==3)
	{
		count++;
	}
	if (x >= 3)
	{
		return Fib(x - 2) + Fib(x - 1);
	}
	if (x <= 2)
	{
		return 1;
	}

}
int main()
{
	int x = 0;
	scanf("%d", &x);
	printf("第%d个斐波那契数为%d\n", x, Fib(x));
	printf("%d\n", count);
	return 0;
}
