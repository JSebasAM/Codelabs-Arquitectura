.data
mensaje: .string "Hola mundo\n"

.text
.globl _start  # Hacemos a el procedimiento _start publico
_start:

	# Aqui empieza el codigo de la aplicacion
	mov $1, %rax		# rax=1  rax es un registro existente
	mov $1, %rdi		# rdi=1 guardar cualquier numero de 64 bits
	mov $mensaje, %rsi 	# rsi=direccion donde inicia el mensaje
	mov $11, %rdx		# rdx=11 cantidad de caracteres del mensaje
	syscall			# llamamos al sistema

	mov $60, %rax		# rax=60
	xor %rdi, %rdi		# rdi=rdi (xor) rdi
	syscall			# llamamos al sistema
