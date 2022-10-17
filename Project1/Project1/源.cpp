#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
//int main()
//{
//   int a = 0;
//   int b = 0;
//   int sum = 0;
//   
//   scanf("%d%d",&a,&b);
//   sum = a + b;
//   printf("sum=%d", sum);
//
//     return 0;
//}
//int main()
//{
//	int abc = getchar();
//	putchar(abc);
//	printf("\n%c", abc);
//
//
//
//
//	return 0;
//}
//int main()
//{
//	while (1)
//		printf("dfff\n");
//
//
//
//
//
//	return 0;
//}
int main()
{
	int ret = 0;
	char password[20] = { 0 };
	printf("请输入密码:>");
	scanf("%s", password);
	printf("请确认输入(Y/N)");
	ret = getchar();
	if (ret == 'Y')
	{

		printf("确认成功");

	}
	else
	{

		printf("放弃确认");
	}




	return 0;
}
