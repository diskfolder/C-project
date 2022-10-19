#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
int main()
{
	int a ;
	int b = 1;
	int c = 0;
		int sum = 0;
		int n = 0;
		scanf("%d", &n);
	
		
	for(a = 1; a <=n ; a++)
	{
		b = b*a;

		sum = sum + b;
		
	}
	
	printf("%d", sum);



	return 0;
}