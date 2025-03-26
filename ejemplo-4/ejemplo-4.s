#Ejemplo de una funcion hecha en assembly

.text
.globl sumar
.globl restar

sumar:	#en lenguaje C: resultado = sumar(int a, int b)

	add %rsi, %rdi
	mov %rdi, %rax
	ret

restar:	#En lenguaje C: resultado = restar(int a, int b)

	sub %rsi, %rsi
	mov %rsi, %rax
	ret
