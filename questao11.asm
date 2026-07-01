.data                                  
    pn:    .asciiz "Digite um numero: " # prompt para o numero base da tabuada
    sep:   .asciiz " x "               # string separadora da multiplicacao
    igual: .asciiz " = "               # string do sinal de igual
    nl:    .asciiz "\n"                # string de quebra de linha

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pn                       # $a0 = endereço do prompt
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro -> resultado em $v0
    move $t0, $v0                      # $t0 = numero escolhido para a tabuada

    li   $t1, 1                        # $t1 = 1 (contador/multiplicador, de 1 a 10)

loop:                                  # rotulo: inicio do laço
    bgt  $t1, 10, fim                  # se contador > 10, sai do laço

    move $a0, $t0                      # $a0 = numero base da tabuada
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o numero base

    li   $v0, 4                        # $v0 = 4 -> servico "imprimir string"
    la   $a0, sep                      # $a0 = serviço da string " x "
    syscall                            # imprime " x "

    move $a0, $t1                      # $a0 = valor atual do multiplicador
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o multiplicador

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, igual                    # $a0 = endereco da string " = "
    syscall                            # imprime " = "

    mul  $t2, $t0, $t1                 # $t2 = numero base * multiplicador
    move $a0, $t2                      # $a0 = resultado da multiplicacao
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o resultado

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, nl                       # $a0 = endereço da string de quebra de linha "\n"
    syscall                            # imprime a quebra de linha

    addi $t1, $t1, 1                   # contador = contador + 1
    j    loop                          # volta ao topo do laço

fim:                                   # rotulo de encerramento
    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução