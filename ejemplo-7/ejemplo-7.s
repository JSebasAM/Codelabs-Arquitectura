.text
.globl suma_float

#Para los floats se utiliza los registros xmm
#Segun System V:
#xmm0 funcion (xmm0, xmm1, xmm2, ...) En ensamblador
# float funcion (float1, float2, float3, ...) En Lenguaje C

suma_float:
	addss %xmm1, %xmm0	# xmm0 = xmm0 + xmm1
	ret


#addss: Add Scalar Single precision (Sumar un escalar de precision simple, es decir float)
