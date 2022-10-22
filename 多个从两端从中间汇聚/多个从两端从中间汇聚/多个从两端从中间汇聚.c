#define  _CRT_SECURE_NO_WARNINGS 1

#include <stdio.h>

int main()
{
	char num1[] = { "welcome to bit..." };

	char num2[] = { "#################" };////定义两个数组

	int l = 0;

	int r = sizeof(num1) / sizeof(num1[0]) - 2;//计算最右边的那个字符下标

	while (l <= r)
	{
		num2[l] = num1[l];

		num2[r] = num1[r];

		l++;

		r--;

		printf("%s\n", num2);
	}

    return 0;
}