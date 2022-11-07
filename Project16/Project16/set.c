#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
struct S
{
	int a;
	char c;
	char arr[20];
	double d;
};
struct T
{
	char ch[10];
	struct S s;
	char* pc;
};

int main()
{
	struct T w = { "herty",{100,'w',"hello",3.987},NULL };
	printf("%s\n", w.ch);
}