.data                                  
    p1:     .asciiz "Digite o dividendo: "  # prompt do dividendo
    p2:     .asciiz "Digite o divisor: "     # prompt do divisor
    pquoc:  .asciiz "Quociente: "             # rotulo do quociente
    presto: .asciiz "\nResto: "                # rotulo do resto

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4               # $v0 = 4 -> serviço "imprimir string"
    la   $a0, p1               # $a0 = endereço do prompt do dividendo
    syscall                   # imprime o prompt
    li   $v0, 5               # $v0 = 5 -> serviço "ler inteiro"
    syscall                   # le inteiro -> resultado em $v0
    move $t0, $v0             # $t0 = dividendo

    li   $v0, 4               # $v0 = 4 -> servico "imprimir string"
    la   $a0, p2               # $a0 = endereco do prompt do divisor
    syscall                   # imprime o prompt
    li   $v0, 5               # $v0 = 5 -> servico "ler inteiro"
    syscall                   # le inteiro -> resultado em $v0
    move $t1, $v0             # $t1 = divisor

    div  $t0, $t1             # lo = quociente ($t0/$t1), hi = resto
    mflo $t2                  # $t2 = quociente (copiado de lo)
    mfhi $t3                  # $t3 = resto (copiado de hi)

    li   $v0, 4               # $v0 = 4 -> servico "imprimir string"
    la   $a0, pquoc            # $a0 = endereco do rotulo "Quociente: "
    syscall                   # imprime o rotulo
    move $a0, $t2             # $a0 = valor do quociente
    li   $v0, 1               # $v0 = 1 -> servico "imprimir inteiro"
    syscall                   # imprime o quociente

    li   $v0, 4               # $v0 = 4 -> serviço "imprimir string"
    la   $a0, presto           # $a0 = endereço do rotulo "\nResto: "
    syscall                   # imprime o rotulo
    move $a0, $t3             # $a0 = valor do resto
    li   $v0, 1               # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                   # imprime o resto

    li   $v0, 10              # $v0 = 10 -> serviço "encerrar programa"
    syscall                   # finaliza a execução