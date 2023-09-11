.data
mensaje_inicial:   .asciiz "Ingrese min 3 números positivos (y cuando estés listo escribe -1 para terminar): "
mensaje_resultado: .asciiz "El número mayor es: "
numero_mayor:     .word 0  # Variable para almacenar el número mayor
numero_recibido: .word 0  # Variable para almacenar el número ingresado por el usuario

.text
.globl main

main:
    # Muestra el mensaje para solicitar los números.
    li $v0, 4 # Codigo de llamada para imprimr una cadena.
    la $a0, mensaje_inicial
    syscall

solicitar_num:
    # Leer un número
    li $v0, 5 # Codigo de llamada para pedir un numero.
    syscall
    sw $v0, numero_recibido  # Almacena el número ingresado en numero_recibido

    # Compara el número ingresado con -1 para terminar el programa
    li $t0, -1
    beq $v0, $t0, ingreso_completado   # Salta a ingreso_completado si se ingresa -1

    # Compara el número ingresado con el número máximo actual
    lw $t1, numero_mayor   # Carga el número máximo actual en $t1
    lw $t2, numero_recibido  # Carga el número ingresado en $t2
    bge $t2, $t1, actualizar_max  # Salta a actualizar_max si el número ingresado es mayor o igual

    # Si no es mayor, continúa el loop
    j solicitar_num

actualizar_max:
    # Actualiza el número máximo
    lw $t1, numero_recibido
    sw $t1, numero_mayor

    # Vuelve al inicio del loop
    j solicitar_num

ingreso_completado:
    # Mostrar el mensaje con el número mayor
    li $v0, 4
    la $a0, mensaje_resultado
    syscall

    # Imprimir el número máximo
    lw $a0, numero_mayor
    li $v0, 1
    syscall

    # Finaliza el programa
    li $v0, 10
    syscall
