#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
typedef struct qwe
{
	char name[20];
	short age;
	char tele[12];
	char sex[5];
}x;
void print1(x* sss)
{
	printf("%s\n", sss->name);
	printf("%d\n", sss->age);
	printf("%s\n", sss->tele);
	printf("%s\n", sss->sex);
}
int main()
{
	x z = { "mike",33,"15529986262","ÄÐ" };
	print1(&z);
	return 0;

}