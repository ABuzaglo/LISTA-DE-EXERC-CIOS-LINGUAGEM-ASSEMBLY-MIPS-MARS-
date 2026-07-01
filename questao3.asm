.data                                 
    p1:       .asciiz "Digite o valor de A: "  # prompt para A
    p2:       .asciiz "Digite o valor de B: "  # prompt para B
    presult:  .asciiz "A - B = "                # rotulo de resultado

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4               # $v0 = 4 -> serviço "imprimir string"
    la   $a0, p1               # $a0 = endereço do prompt de A
    syscall                   # imprime "Digite o valor de A: "

    li   $v0, 5               # $v0 = 5 -> servico "ler inteiro"
    syscall                   # le inteiro -> resultado em $v0
    move $t0, $v0             # $t0 = A

    li   $v0, 4               # $v0 = 4 -> servico "imprimir string"
    la   $a0, p2               # $a0 = endereco do prompt de B
    syscall                   # imprime "Digite o valor de B: "

    li   $v0, 5               # $v0 = 5 -> servico "ler inteiro"
    syscall                   # le inteiro -> resultado em $v0
    move $t1, $v0             # $t1 = B

    sub  $t2, $t0, $t1        # $t2 = A - B

    li   $v0, 4               # $v0 = 4 -> serviço "imprimir string"
    la   $a0, presult          # $a0 = endereço do rotulo "A - B = "
    syscall                   # imprime o rotulo

    move $a0, $t2             # $a0 = resultado da subtração
    li   $v0, 1               # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                   # imprime o resultado

    li   $v0, 10              # $v0 = 10 -> serviço "encerrar programa"
    syscall                   # finaliza a execução