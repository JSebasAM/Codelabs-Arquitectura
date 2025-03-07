.text

.globl _start

_start:
	mov $0x3F, %al
	mov $0xF3, %ah

#Salir al sistema
	mov $60, %rax
	xor %rdi, %rdi
	syscall
