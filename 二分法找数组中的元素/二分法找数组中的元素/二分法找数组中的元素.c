#define  _CRT_SECURE_NO_WARNINGS 1

#include <stdio.h>

int main()
{
	int x = 0;

	printf("������һ������\n");

	scanf("%d", &x);

	char sz[] = {1,2,4,6,8,7,3,9,10 };

	int	 num = sizeof(sz) / sizeof(sz[0]);/*����Ԫ�ظ���*/

	int l = 0;//���±�

	int r = num-1;//���±�

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
			printf("�ҵ��������������ӣ����±�Ϊ��%d", middle);
			break;
		}
	}

	if (l > r)
	{
		printf("�Ҳ������������Ԫ�أ��ٻ�һ�����԰ɡ�");
	}

	return 0;
}
