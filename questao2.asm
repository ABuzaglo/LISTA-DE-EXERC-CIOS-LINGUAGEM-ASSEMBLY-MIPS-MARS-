.data                                  # inicio do segmento de dados
    p1:       .asciiz "Digite o primeiro numero: "  # primeira string
    p2:       .asciiz "Digite o segundo numero: "   # segunda string
    presult:  .asciiz "A soma e: "                    # string do rotulo de resultado

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # início do programa
    li   $v0, 4               # $v0 = 4 -> servico "imprimir string"
    la   $a0, p1               # $a0 = endereco da primeira string
    syscall                   # imprime "Digite o primeiro numero: "

    li   $v0, 5               # $v0 = 5 -> servico "ler inteiro"
    syscall                   # le inteiro -> resultado vem em $v0
    move $t0, $v0             # $t0 = primeiro numero (copia antes que $v0 seja reusado)

    li   $v0, 4               # $v0 = 4 -> servico "imprimir string"
    la   $a0, p2               # $a0 = endereco da segunda string
    syscall                   # imprime "Digite o segundo numero: "

    li   $v0, 5               # $v0 = 5 -> servico "ler inteiro"
    syscall                   # le inteiro -> resultado vem em $v0
    move $t1, $v0             # $t1 = segundo numero

    add  $t2, $t0, $t1        # $t2 = soma = $t0 + $t1

    li   $v0, 4               # $v0 = 4 -> servico "imprimir string"
    la   $a0, presult          # $a0 = endereco do rotulo de resultado
    syscall                   # imprime "A soma e: "

    move $a0, $t2             # $a0 = valor da soma
    li   $v0, 1               # $v0 = 1 -> servico "imprimir inteiro"
    syscall                   # imprime o valor da soma

    li   $v0, 10              # $v0 = 10 -> servico "encerrar programa"
    syscall                   # finaliza a execucao