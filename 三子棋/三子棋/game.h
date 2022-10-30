#define  _CRT_SECURE_NO_WARNINGS 1
#include <stdio.h>
#define r  3 
#define l  3 
#include <stdlib.h>
#include<time.h>


void initblank(char qwe[r][l], int q, int s);
void display(char qwe[r][l], int d, int vdf);
void playermove(char qwe[r][l], int s, int df);
void  computermove(char qwe[r][l], int q, int s);
char   iswin(char qwe[r][l], int tt, int qwee[]);