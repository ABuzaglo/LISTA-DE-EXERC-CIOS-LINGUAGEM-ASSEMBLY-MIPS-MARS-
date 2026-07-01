.data
    p1:     .asciiz "Digite o primeiro numero: " # string do primeiro prompt
    p2:     .asciiz "Digite o segundo numero: "  # string do segundo prompt
    pmaior: .asciiz "O maior numero e: "         # string do rotulo de resultado

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, p1                       # $a0 = endereço do primeiro prompt
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro -> resultado em $v0
    move $t0, $v0                      # $t0 = A (primeiro numero)

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, p2                       # $a0 = endereço do segundo prompt
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro -> resultado em $v0
    move $t1, $v0                      # $t1 = B (segundo numero)

    bge  $t0, $t1, a_eh_maior          # se A >= B, desvia para a_eh_maior
    move $t2, $t1                      # senao (A < B), define maior = B
    j    imprime                       # salta para a impressão (pula a_eh_maior)

a_eh_maior:                            # rotulo: bloco executado se A for maior ou igual
    move $t2, $t0                      # define maior = A

imprime:                               # rotulo: bloco de impressão do resultado
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pmaior                   # $a0 = endereço da string "O maior numero e: "
    syscall                            # imprime o rotulo
    move $a0, $t2                      # $a0 = valor armazenado como maior
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o numero maior

    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução