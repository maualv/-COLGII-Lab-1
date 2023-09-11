.data
mensaje:     .asciiz "Número de términos de Fibonacci a generar: "
mensaje_resultado:     .asciiz "Serie de Fibonacci: "
espacio:        .asciiz " " # Solo con fines estéticos.
.text
.globl main

main:
    # Se solicita el número de términos de la serie que se quieren generar.
    li $v0, 4
    la $a0, mensaje
    syscall

    # Se lee el valor ingresado.
    li $v0, 5
    syscall
    move $t0, $v0  # Se almacena en $t0

    # Se almacenan los primeros términos.
    li $t1, 0     # Primero
    li $t2, 1     # Segundo

    # Se imprime el mensaje de resultado
    li $v0, 4
    la $a0, mensaje_resultado
    syscall

    # Se imprimen los dos valores.
    li $v0, 1
    move $a0, $t1
    syscall
    
    li $v0, 4
    la $a0, espacio,
    syscall,
    
    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, espacio,
    syscall,
    
    # Calculan los términos restantes.
    addi $t0, $t0, -1  # Se resta dos, de los valores ya impresos en pantalla.

bucle_fib:
    beqz $t0, cierre_programa  # Si $t0 es 0, cierre del programa.

    # Calculamos el próximo término: $t3 = $t1 + $t2
    add $t3, $t1, $t2

    # Lo imprimimos
    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, espacio,
    syscall,
    
    # Actualizamos los valores para la próxima iteración.
    move $t1, $t2
    move $t2, $t3

    addi $t0, $t0, -1  # Restamos 1 a los términos restantes.
    j bucle_fib

cierre_programa:
    li $v0, 10 # Codigo de Llamdo al cierre del programa
    syscall
