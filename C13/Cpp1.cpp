#include<stdio.h>
main()
{
float h,r,l,s,sq,vq,vz;
float pi=3.14152;
printf("请输入圆的半径r，圆柱高h:>");
scanf("%f%f",&r,&h);
l=2*pi*r;
s=r*r*pi;
sq=4*pi*r*r;
vq=3.0/4.0*pi*r*r*r;
vz=pi*r*r*h;
printf("圆周长：%6.2f\n",l);
printf("圆面积： %6.2f\n",s);
printf("圆球表面积：%6.2f\n",sq);
printf("圆球体积：%6.2f\n",vq);
printf("圆柱体积：%6.2f\n",vz);



}