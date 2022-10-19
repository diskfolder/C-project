#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
int main()
{
	int a ;
	int n ;
	
	int sum=0 ;
	
	for (n = 1; n <= 3; n++)
	{
		int ret = 1;
		for (a = 1; a <= n; a++)
		{
			
			ret = ret * a;

			
		}
		sum = ret+sum;
	}
	printf("ºÍÎª:%d",sum);

	return 0;
}