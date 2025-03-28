.data
mensaje: .asciz "%ld \n"

.text
.globl main
.extern printf

main:

        subq $8, %rsp
        xor %rbx, %rbx

bucle:

        mov $mensaje, %rdi
        mov %rbx, %rsi
	xor %rax, %rax
        call printf

        inc %rbx
        CMPQ $11, %rbx
        JL bucle

        addq $8, %rsp

        mov $60, %rax
        xor %rdi, %rdi
        syscall
