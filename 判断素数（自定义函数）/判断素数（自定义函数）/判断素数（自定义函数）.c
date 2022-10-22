#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
int is_prime(int n)
{
	int i = 0;
	for (i = 2; i < n; i++)
	{
		if (n % i == 0)
			return 0;
	}
	return 1;
}
int main()
{
	int a = 0;
	for (a = 100; a <= 200; a++)
	{
		if (is_prime(a) == 1)
		{
			printf("%d\n", a);
		}
	}
     return 0;
}