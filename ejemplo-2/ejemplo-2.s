.data
mensaje: .asciz "%ld \n"

.text
.globl main
.extern printf			# Indico que quiero utilizar la función
				# printf de libc

main:
	subq $8, %rsp		#Alinear datos

 	mov $4, %rax		#rax=4
	mov $15, %rbx		#rbx=5
	add %rbx, %rax		#rax=rax+rbx

	#Bloque de impresion
	#printf("ld \n", rax);
	#	 rdi   , rsi

	mov $mensaje, %rdi
	mov %rax, %rsi
	xor %rax, %rax		#rax=0
	call printf

	addq $8, %rsp		#Volver a alinear datos evitar corrupcion

	#Salir al sistema

	mov $60, %rax		# Indico que vamos a usar la funcion sys_exit
	mov $0, %rdi		# Indico que el argumento tiene un valor de 0
	syscall			# No es parte de ensamblador pero llama a las
				# funciones del sistema
