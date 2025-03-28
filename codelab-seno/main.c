#include <stdio.h>
#include <stdlib.h>

double sin_taylor(double input);

int main(int  numArgs, char ** args)
{
	double grados;

	printf("Ingrese el angulo para sin(): ");
	scanf("%lf", &grados);

	double resultado = sin_taylor(grados);

	printf("\r\n");
	printf("sen(%.2f °) = %.15f\n",grados, resultado);

	exit(EXIT_SUCCESS);
}
