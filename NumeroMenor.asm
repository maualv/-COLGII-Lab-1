.data
mensaje_inicial:   .asciiz "Ingrese min 3 números positivos (y cuando estés listo escribe -1 para terminar): "
mensaje_resultado: .asciiz "El número menor es: "
numero_menor:     .word 0  # Variable para almacenar el número menor
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

    # Reemplazamos el valor inicial de cero con el primero número ingresado
    lw $t0, numero_menor
    li $t1, 0
    beq $t1, $t0, actualizar_min
    
    # Compara el número ingresado con -1 para terminar el programa
    li $t0, -1
    beq $v0, $t0, ingreso_completado   # Salta a ingreso_completado si se ingresa -1

    # Compara el número ingresado con el número mínimo actual
    lw $t1, numero_menor   # Carga el número mínimo actual en $t1
    lw $t2, numero_recibido  # Carga el número ingresado en $t2
    ble $t2, $t1, actualizar_min  # Salta a actualizar_min si el número ingresado es menor o igual

    # Si no es menor, continúa el loop
    j solicitar_num

actualizar_min:
    # Actualiza el número mínimo
    lw $t1, numero_recibido
    sw $t1, numero_menor

    # Vuelve al inicio del loop
    j solicitar_num

ingreso_completado:
    # Mostrar el mensaje con el número menor
    li $v0, 4
    la $a0, mensaje_resultado
    syscall

    # Imprimir el número mínimo
    lw $a0, numero_menor
    li $v0, 1
    syscall

    # Finaliza el programa
    li $v0, 10
    syscall
