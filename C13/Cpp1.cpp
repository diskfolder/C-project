#include<stdio.h>
main()
{
float h,r,l,s,sq,vq,vz;
float pi=3.14152;
printf("������Բ�İ뾶r��Բ����h:>");
scanf("%f%f",&r,&h);
l=2*pi*r;
s=r*r*pi;
sq=4*pi*r*r;
vq=3.0/4.0*pi*r*r*r;
vz=pi*r*r*h;
printf("Բ�ܳ���%6.2f\n",l);
printf("Բ����� %6.2f\n",s);
printf("Բ��������%6.2f\n",sq);
printf("Բ�������%6.2f\n",vq);
printf("Բ�������%6.2f\n",vz);



}