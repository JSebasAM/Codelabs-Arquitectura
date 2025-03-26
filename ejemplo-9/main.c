#include <stdio.h>
#include <stdlib.h>
//rax			(rdi, rsi , rdx)  int
//rax			(xmm0,xmm1,xmm2) float | double
//Mezclando:

//rax			(xmm0, rsi, xmm2)
  float calculadoraCiclos(float,int,float);

int main(int numArgs, char ** args)
{
    float pi = 3.1415926535F;
    int ciclos = 5;
    float radio = 2.41F;
    float resultado;

    resultado = calculadoraCiclos(pi,ciclos,radio);
    printf("\r\n");
    printf("radio: %f \r\n ciclos: %d \r\n resultado: %f \r\n",radio,ciclos,resultado);
    exit(EXIT_SUCCESS);
}

