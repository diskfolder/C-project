#include "game.h"
void menu()//��ʼ���˵�
{
	printf("                                    **********************************************                  \n");
	printf("                                    *********** ����һ����������Ϸ ***************                  \n");
	printf("                                    ************     1.Play��      ***************                  \n");
	printf("                                    ************     2.exit.       ***************                  \n");
	printf("                                    ************     3.about.      ***************                  \n");
	printf("                                    **********************************************                  \n");
}

void test()
{
	int x = 0;
	menu();
	printf("��ѡ������:>\n");
	scanf("%d", &x);
	switch (x)
	{
	case 1:
		printf("���ڳ�ʼ������.... \n");
		return 0;
	case 2:
		printf("�����˳�����.....  \n");
		return 0;
	default:
		printf("����������һ�����֣�\n");
		return 0;
	}




}
//�㷨��ʵ��
void game()
{    //��ʼ������
	char qwe[r][l] = { 0 };
	char x = 0;
	initblank(qwe, r, l);//��ʼ�����
	display(qwe, r, l);
	 srand((unsigned int)time(NULL));
	 while (19)
	 {
		 
		 playermove(qwe, r, l);
		 display(qwe, r, l);
		 x = iswin(qwe, r, l);
		 if (x != 'c')
			 break;
		 computermove(qwe, r, l);
		 display(qwe, r, l);
		 x = iswin(qwe, r, l);
		 if (x != 'c')
		{
			 break;
		 }
	 }
	if (x == '@')
	{
		printf("��Ӯ�ˣ�\n");
	}
	else if (x == '#')
	{
		printf("����Ӯ�ˣ�\n");

	}

	else
		printf("ƽ�֣�����");
}




int main()
{
	test();
	game();
	return 0;
}