.data                                
    pn:     .asciiz "Quantos termos de Fibonacci deseja exibir? " # prompt de quantidade
    espaco: .asciiz " "                                           # string separadora

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pn                       # $a0 = endereço do prompt
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro -> resultado em $v0
    move $t0, $v0                      # $t0 = N (quantidade de termos desejada)

    li   $t1, 0                        # $t1 = 0 (termo atual inicial: fib(0))
    li   $t2, 1                        # $t2 = 1 (proximo termo inicial: fib(1))
    li   $t3, 0                        # $t3 = 0 (contador de termos ja impressos)

loop:                                  # rotulo: inicio da geração
    bge  $t3, $t0, fim                 # se contador >= N, termina o laço

    move $a0, $t1                      # $a0 = valor do termo atual
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o termo atual

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, espaco                   # $a0 = endereço da string de espaco
    syscall                            # imprime espaco entre numeros

    add  $t4, $t1, $t2                 # $t4 = atual + proximo (calcula o termo seguinte)
    move $t1, $t2                      # atual = proximo (desliza os valores pra frente)
    move $t2, $t4                      # proximo = soma recem-calculada

    addi $t3, $t3, 1                   # incrementa o contador de termos impressos
    j    loop                          # volta ao inicio do laço

fim:                                   # rotulo de finalização
    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução