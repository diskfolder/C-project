#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
#include<string.h>
int main()
{
	int i = 0;

		char password[20] = {0};
	
	for (i = 0; i < 3; i++)
	{
		printf("����������\n");
		scanf("%s", &password);
		if (strcmp(password, "123456") == 0)
		{
			printf("��½�ɹ�\n");
			break;

		}
		else
			printf("��������������Ŷ�������԰ɡ�\n");

	}
	if (i == 3)
		printf("�������");



	return 0;
}