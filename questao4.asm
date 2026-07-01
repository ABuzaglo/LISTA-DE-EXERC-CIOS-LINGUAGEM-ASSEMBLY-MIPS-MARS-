.data                                 
    p1:      .asciiz "Digite o primeiro numero: "  # prompt 1
    p2:      .asciiz "Digite o segundo numero: "   # prompt 2
    presult: .asciiz "O produto e: "                 # rotulo de resultado

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4               # $v0 = 4 -> servico "imprimir string"
    la   $a0, p1               # $a0 = endereço do primeiro prompt
    syscall                   # imprime o prompt
    li   $v0, 5               # $v0 = 5 -> serviço "ler inteiro"
    syscall                   # le inteiro -> resultado em $v0
    move $t0, $v0             # $t0 = primeiro numero

    li   $v0, 4               # $v0 = 4 -> serviço "imprimir string"
    la   $a0, p2               # $a0 = endereco do segundo prompt
    syscall                   # imprime o prompt
    li   $v0, 5               # $v0 = 5 -> serviço "ler inteiro"
    syscall                   # le inteiro -> resultado em $v0
    move $t1, $v0             # $t1 = segundo numero

    mul  $t2, $t0, $t1        # $t2 = $t0 * $t1

    li   $v0, 4               # $v0 = 4 -> serviço "imprimir string"
    la   $a0, presult          # $a0 = endereço do rotulo "O produto e: "
    syscall                   # imprime o rotulo
    move $a0, $t2             # $a0 = valor do produto
    li   $v0, 1               # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                   # imprime o resultado

    li   $v0, 10              # $v0 = 10 -> serviço "encerrar programa"
    syscall                   # finaliza a execução