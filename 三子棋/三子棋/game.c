#include"game.h"

void initblank(char qwe[l][r], int q, int s)
{
	int x = 0;
	int y = 0;
	for (x = 0; x < l; x++)
	{
		for (y = 0; y < r; y++)
		{
			qwe[x][y] = ' ';

		}
	}


}
void display(char qwe[r][l], int d, int vdf)
{
	int i = 0;
	int j = 0;
	/*for (i = 0; i < r; i++)
	{
		printf(" %c | %c | %c \n",qwe[i][0],qwe[i][1],qwe[i][2]);
		if(i<l-1)
		printf("---|---|---\n");
	}
	*/
	for (i = 0; i < r; i++)
	{
		for (j = 0; j < l; j++)
		{
			printf(" %c ", qwe[i][j]);
			if(j<r-1)
			printf("|");
			
		
		}
		printf("\n");
		if (i < r - 1)
		{
			for (j = 0; j < l; j++)
			{
				printf("---");
				if(j<r-1)
				printf("|");
			}
			printf("\n");
		}
		
	}
}
void playermove(char qwe[r][l], int s, int df)
{
	int x = 0;
	int y = 0;
	printf("请玩家先走（输入坐标）");
	scanf("%d\n%d", &x, &y);
	//判断坐标的合法性
	while (1)
	{
		if (x > 0 && x <= r && y > 0 && y <= l)
		{
			if (qwe[x - 1][y - 1] = ' ')
			{
				qwe[x - 1][y - 1] = '@';
				break;
			}
			else
			{
				printf("坐标非法请重新输入！");
				continue;
			}
		}
		else
		{
			printf("坐标非法请重新输入\n");
			continue;
		}
	}
}
void  computermove(char qwe[r][l], int q, int s)
{
	int x = 0;
	int y = 0;
	printf("电脑下....\n");
	while (1)
	{
		int  x = rand() % r;
		int y = rand() % l;
		//判断是否被占用
		if (x > 0 && x <= r && y > 0 && y <= l)
		{
			qwe[x][y] = '&';
			break;
		}
	}
}
int isfull(char qwe[r][l],int m,int n)
{
	int i = 0;
	int j = 0;
	for (i = 0; i < r; i++)
	{
		for (j = 0; j < l; j++)
		{
			if (qwe[i][j] == ' ')
			{
				return 0;
			}
			
	   }
	}
	return 1;
}

char iswin(char qwe[r][l], int tt, int qwee[])
{
	int i = 0;
	for (i = 0; i < r; i++)
	{
		if (qwe[i][0] ==qwe[i][1] && qwe[i][1] == qwe[i][2]&&qwe[i][2]!=' ')
		{
			return qwe[i][0];
		}
	
	} 
	for (i = 0; i < l; i++)
	{
		if (qwe[0][i] == qwe[1][i] && qwe[1][i] == qwe[2][i]&&qwe[2][i]!=' ')
		{
			return qwe[0][i];
		}

	}
	if (qwe[0][0] == qwe[1][1] && qwe[1][1] == qwe[2][2] && qwe[0][0] != ' ')
	{
		return qwe[0][0];
	}
	if (qwe[0][2] == qwe[1][1] && qwe[1][1] == qwe[2][0] && qwe[1][1] != ' ')
	{
		return qwe[0][2];
	}
	//判断每次下完后此时棋盘是否满了
	int x = isfull(qwe, r, l);
	if (x == 1)
	{
		return 'e';
	}
	else
		return 'c';


}