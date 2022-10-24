#include<stdio.h>
/*main()
{
   short int a,b;
   float d,e;
   char c1,c2;
   double f,g;
   long m,n;
   unsigned int p,q;
   a=61;
   b=62;
   c1='a';
   c2='b';
   d=3.56;
   e=6.87;
   f=3157.890121;
   g=0.123456789;
   m=5000;
   n=60000;
   p=32768;
   q=40000;
   printf("a=%d,b=%d\nc1=%c,c2=%c\nd=%6.2f,e=%6.2f\n",a,b,c1,c2,d,e);
   printf("f=%15.6f,g=%15.12f\nm=%d,n=%d\np=%u,q=%u\n",f,q,m,p,q);
}*/
/*main()
{
   short int a,b;
   float d,e;
   char c1,c2;
   double f,g;
   long m,n;
   unsigned int p,q;
   a=50000;
   b=60000;
   c1=a;
   c2=b;
   d=f;
   e=g;
   f=3157.890121;
   g=0.123456789;
   m=5000;
   n=60000;
   p=50000;
   q=60000;
   printf("a=%d,b=%d\nc1=%c,c2=%c\nd=%6.2f,e=%6.2f\n",a,b,c1,c2,d,e);
   printf("f=%15.6f,g=%15.12f\nm=%d,n=%d\np=%u,q=%u\n",f,q,m,p,q);
}*/
 main()
{
	int a=0;
	int b=0;
	char c1='0';
	char c2='0';
	float d=0;
    float e=0;
	double f=0;
	double g=0;
    long m=0;
	long n=0;
	unsigned p=0;
	unsigned q=0;
    printf("请输入12个数字或字母，其中第三四为字母，当你输入他们的时候，会被打印:>格式：数字或字符(空格)数字（空格）");
    scanf("%d,%d,%c,%c,%f,%f,%lf,%lf,%ld,%ld,%u,%u",&a,&b,&c1,&c2,&d,&e,&f,&g,&m,&n,&p,&q);
printf("%d %d\n%c %c\n%f %f\n%lf %lf\n%ld %ld\n%u %u",a,b,c1,c2,d,e,f,g,m,n,p,q);





}
















