#include "game.h"
void menu()//初始化菜单
{
	printf("                                    **********************************************                  \n");
	printf("                                    *********** 这是一个三子棋游戏 ***************                  \n");
	printf("                                    ************     1.Play！      ***************                  \n");
	printf("                                    ************     2.exit.       ***************                  \n");
	printf("                                    ************     3.about.      ***************                  \n");
	printf("                                    **********************************************                  \n");
}

void test()
{
	int x = 0;
	menu();
	printf("请选择数字:>\n");
	scanf("%d", &x);
	switch (x)
	{
	case 1:
		printf("正在初始化程序.... \n");
		return 0;
	case 2:
		printf("正在退出程序.....  \n");
		return 0;
	default:
		printf("请重新输入一个数字！\n");
		return 0;
	}




}
//算法的实现
void game()
{    //初始化数组
	char qwe[r][l] = { 0 };
	char x = 0;
	initblank(qwe, r, l);//初始化表格
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
		printf("您赢了！\n");
	}
	else if (x == '#')
	{
		printf("电脑赢了！\n");

	}

	else
		printf("平局！！！");
}




int main()
{
	test();
	game();
	return 0;
}