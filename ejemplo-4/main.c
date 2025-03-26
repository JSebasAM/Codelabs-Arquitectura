#include <stdio.h>
#include <stdlib.h>

//rax	    rdi, rsi
  int sumar(int, int);

int main(int numeroParametros, char ** argumentos)
{
	int resultado;
	int numero_1 = 5;
	int numero_2 = 6;

	printf("El numero de parametros en la lidea de comandos fue: %d\r\n",numeroParametros);
	resultado = sumar(numero_1,numero_2);
	printf("La suma de %d y %d es %d\r\n",numero_1,numero_2,resultado);

	return(EXIT_SUCCESS);
}

