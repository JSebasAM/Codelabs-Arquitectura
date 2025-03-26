
.data

mensaje: .asciz "numero1 %d numero2 %d \r\n"

.text
.globl main
.extern printf		#similar al include<stdio.h>

main:
	subq $8, %rsp		#Alineacion

	mov $4, %rax
	mov $5, %rbx

	#printf("numero1 %d numero2 %d \r\n", rax, rbx)
	#		%rdi		      rsi  rdx

	movq $mensaje, %rdi
	movq %rax, %rsi
	movq %rbx, %rdx

	call imprimir
	addq $8, %rsp

	# rax se pone en 0 para indicar que necesitamos 0 registros de punto
	# flotante

	movq $0, %rax	#rax=0 toca memoria
	xorq %rax, %rax	#rax=0 no toca memoria

	call printf


	call salir

salir:
	#salir al sistema
	mov $60, %rax
	mov $0, %rdi
	syscall
	ret	# rax se pone en 0 para indicar que necesitamos 0 registros de punto
	# flotante

	movq $0, %rax	#rax=0 toca memoria
	xorq %rax, %rax	#rax=0 no toca memoria

	call printf

