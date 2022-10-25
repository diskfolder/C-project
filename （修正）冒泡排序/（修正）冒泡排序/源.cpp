#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
void ex(int* qwe, int size)
{
	
	int i = 0;
	int x = 0;
	for (i = 0; i < size-1; i++)
	{
		int x = 0;//假设值为0是是有序的
		int you = 1;
		for (x = 0; x < size - 1 - i; x++)
		{
			if (qwe[x] > qwe[x + 1])
			{
				int tmp = 0;
				tmp = qwe[x];
				qwe[x] = qwe[x + 1];
				qwe[x+1] = tmp;
				you = 0;
		    }

		}
		if (you == 1)
			break;
	}


}
int main()
{
	int i = 0;
	int qwe[] = { 10,9,8,7,6,5,4,3,2,1 };
	int size = sizeof(qwe) / sizeof(qwe[0]);
	ex(qwe, size);
	for (i = 0; i < size; i++)
	{
		printf("%d ", qwe[i]);
	}


	return 0;
}