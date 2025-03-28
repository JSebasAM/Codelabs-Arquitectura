# Archivo: seno_taylor.s
.data
#mensaje:         .asciz "Ingrese un ángulo (radianes): "
#formato_entrada: .asciz "%lf"     # Formato para leer un double
#formato_salida:  .asciz "sen(%.4f) = %.15f\n"  # Formato para imprimir resultado
#input:           .double 0.0       # Variable para almacenar el input
#resultado:       .double 0.0       # Variable para el resultado

.section .rodata
    .align 8
.epsilon: .double 1e-15				# Precisión
.signo: .double -1.0				# Para alternar signos
.radian: .double 0.01745329251994329576		#pi/180

.text
.globl sin_taylor

# Función seno (serie de Taylor)
sin_taylor:
    # Registros usados:
    #   xmm0: resultado (sum)
    #   xmm1: x²
    #   xmm2: término actual
    #   xmm3: denominador
    #   xmm4: -1.0
    #   xmm5: epsilon
    #   ecx: contador (n)

    #Convertir grados a radianes (xmm0 = grados)
    movsd .radian(%rip), %xmm1	# xmm1 = pi/180
    mulsd %xmm1, %xmm0		# xmm0 = xmm0 * xmm1


    # Inicializar constantes
    movsd .epsilon(%rip), %xmm5	 # epsilon = 1e-15
    movsd .signo(%rip), %xmm4	 # -1.0
    mov $1, %ecx		 # n = 1

    # Calcular x²
    movsd %xmm0, %xmm1		# xmm1 = resultado
    mulsd %xmm1, %xmm1		# xmm1 = resultado * resultado

    # Primer término (x)
    movsd %xmm0, %xmm2       # termino actual = resultado

serie:
    # Calcular denominador = (2n)(2n + 1)
    mov %ecx, %eax		# eax =  contador (n)
    add %eax, %eax		# eax = eax + eax =2n
    lea 1(%eax), %edx		# edx = eax + 1
    imul %edx, %eax		# eax = eax(2n)edx(2n+1)

    # Convertir a double y actualizar término
    cvtsi2sd %eax, %xmm3	# xmm3 = denominador -- lo convierte a double 5 = 5.0
    mulsd %xmm4, %xmm2		# termino actual = termino actual * -1
    mulsd %xmm1, %xmm2		# termino actual = termino actual * resultado^2
    divsd %xmm3, %xmm2		# termino actual = termino actual /  denominador

    # Actualizar resultado
    addsd %xmm2, %xmm0		# resultado = termino actual

    # Verificar bucle (termino actual < epsilon)
    pabsd %xmm2, %xmm6		# Usar instrucción SIMD para valor absoluto
    comisd %xmm5, %xmm6		# termino actual < epsilon
    jb fin

    # Incrementar contador y repetir
    inc %ecx
    jmp serie

fin:
    ret



    #sub $8, %rsp           # Alineación de la pila

#    Imprimir mensaje
#    mov $mensaje, %rdi
#    xor %rax, %rax
#    call printf

#    Leer input (double)
#    mov $formato_entrada, %rdi
#    mov $input, %rsi
#    xor %rax, %rax
#    call scanf

#   movsd input(%rip), %xmm0	# xmm0 = input


#    #Calcular seno y guardar el resultado
#    call seno			 # Llamar a la función seno
#    movsd %xmm0, resultado(%rip) # Guardar resultado

#    Imprimir resultado
#    mov $formato_salida, %rdi
#    movsd input(%rip), %xmm0		# Primer argumento: x
#    movsd resultado(%rip), %xmm1	# Segundo argumento: resultado
#    mov $2, %rax			# Indicar 2 argumentos en registros vectoriales
#    call printf

#    add $8, %rsp	 # Restaurar la pila

#    Salir
#    mov $60, %rax
#    xor %rdi, %rdi
#    syscall
