#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
#include"ADD.h"
int main()
{
	int a = 0;
	int b = 0;
	printf("�������������֣����ǽ��ᱻ���:>\n");
	scanf("%d%d", &a, &b);
	int x=ADD(a, b);
	printf("%d", x);

	return 0;
}