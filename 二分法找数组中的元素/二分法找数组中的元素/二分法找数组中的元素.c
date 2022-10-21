#define  _CRT_SECURE_NO_WARNINGS 1

#include <stdio.h>

int main()
{
	int x = 0;

	printf("请输入一个数字\n");

	scanf("%d", &x);

	char sz[] = {1,2,4,6,8,7,3,9,10 };

	int	 num = sizeof(sz) / sizeof(sz[0]);/*计算元素个数*/

	int l = 0;//左下标

	int r = num-1;//右下标

	while (l <= r)
	{
		
		int middle = (l + r) / 2;
		if (x > sz[middle])
		{
			l = middle + 1;
		}
		else if (x < sz[middle])
		{
			r = middle - 1;
		}
		else  if(x==sz[middle])
		{
			printf("找到您所搜索的数子，其下标为：%d", middle);
			break;
		}
	}

	if (l > r)
	{
		printf("找不到你所输入的元素，再换一个试试吧。");
	}

	return 0;
}
