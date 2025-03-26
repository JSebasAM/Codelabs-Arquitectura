
.text

.global calculadoraCiclos

calculadoraCiclos:
    # xmm0  funcion (xmm0, rsi, xmm1)
    mulss %xmm1, %xmm0		## ss Significa S (scalar) y  S (single: float)

#while
ciclos:

    cmp $0, %rdi	#Comparacion entre rsi y cero
    je fin		#Podemos usar je o jz arbitrariamente

    addss %xmm0, %xmm0	#xmm0 = xmm0 + xmm0

   dec %rdi
   jmp ciclos

fin:

    ret
