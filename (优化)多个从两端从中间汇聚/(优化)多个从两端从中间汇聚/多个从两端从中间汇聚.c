#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
#include<windows.h>
#include<stdlib.h>

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

		printf("%s\n", num2);

		Sleep(3000);//休息一秒，1000ms=1s
		system("cls");//执行系统命令--cls--清屏
		
		l++;

		r--;
	}

	return 0;
}
