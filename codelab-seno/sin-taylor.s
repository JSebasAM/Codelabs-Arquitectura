# Archivo: seno_taylor.s
.data
mensaje:        .asciz "Ingrese un ángulo (radianes): "
formato_entrada: .asciz "%lf"     # Formato para leer un double
formato_salida:  .asciz "sen(%.4f) = %.15f\n"  # Formato para imprimir resultado
x:              .double 0.0       # Variable para almacenar el input
resultado:      .double 0.0       # Variable para el resultado

.text
.globl main
.extern printf, scanf

main:
    sub $8, %rsp           # Alineación de la pila
    
    # Imprimir mensaje
    mov $mensaje, %rdi
    xor %rax, %rax         # 0 argumentos vectoriales
    call printf
    
    # Leer input (double)
    mov $formato_entrada, %rdi
    mov $x, %rsi
    xor %rax, %rax
    call scanf
    
    # Calcular seno(x)
    movsd x(%rip), %xmm0   # Cargar x en xmm0
    call seno              # Llamar a la función seno
    movsd %xmm0, resultado(%rip)  # Guardar resultado
    
    # Imprimir resultado
    mov $formato_salida, %rdi
    movsd x(%rip), %xmm0    # Primer argumento: x
    movsd resultado(%rip), %xmm1 # Segundo argumento: resultado
    mov $2, %rax           # Indicar 2 argumentos en registros vectoriales
    call printf
    
    add $8, %rsp           # Restaurar la pila
    
    # Salir
    mov $60, %rax
    xor %rdi, %rdi
    syscall

# Función seno (serie de Taylor)
seno:
    # Registros usados:
    #   xmm0: resultado (sum), xmm1: x², xmm2: término actual
    #   xmm3: denominador, xmm4: -1.0, xmm5: epsilon
    #   ecx: contador (n)
    
    # Inicializar constantes
    movsd .LC0(%rip), %xmm5   # epsilon = 1e-15
    movsd .LC1(%rip), %xmm4   # -1.0
    mov $1, %ecx              # n = 1
    
    # Calcular x²
    movapd %xmm0, %xmm1
    mulsd %xmm1, %xmm1        # xmm1 = x²
    
    # Primer término (x)
    movapd %xmm0, %xmm2       # current_term = x
    movapd %xmm0, %xmm0       # sum = x
    
.Lbucle:
    # Calcular denominador = (2n)(2n + 1)
    mov %ecx, %eax
    add %eax, %eax            # 2n
    lea 1(%eax), %edx         # 2n + 1
    imul %edx, %eax           # eax = (2n)(2n+1)
    
    # Convertir a double y actualizar término
    cvtsi2sd %eax, %xmm3     # xmm3 = denominador
    mulsd %xmm4, %xmm2       # current_term *= -1
    mulsd %xmm1, %xmm2       # current_term *= x²
    divsd %xmm3, %xmm2       # current_term /= denominador
    
    # Actualizar suma
    addsd %xmm2, %xmm0       # sum += current_term
    
    # Verificar condición de parada (|current_term| < epsilon)
    pabsd %xmm2, %xmm6       # Usar instrucción SIMD para valor absoluto
    comisd %xmm5, %xmm6
    jb .Lfin
    
    # Incrementar contador y repetir
    inc %ecx
    jmp .Lbucle

.Lfin:
    ret

.section .rodata
    .align 8
.LC0: .double 1e-15       # Precisión
.LC1: .double -1.0        # Para alternar signos
