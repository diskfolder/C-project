#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
int all(int n)
{
	if (n != 1)
		return n * all(n - 1);
	else
		return 1;
}
int main()
{
	printf("������һ�����֣��������һ��:>\n");
	int x = 0;
	scanf("%d", &x);
	printf("�׳�Ϊ%d\n", all(x));
	return 0;
}