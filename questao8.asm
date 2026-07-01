.data                                
    p1:     .asciiz "Digite o primeiro numero: " # prompt do numero A
    p2:     .asciiz "Digite o segundo numero: "  # prompt do numero B
    p3:     .asciiz "Digite o terceiro numero: " # prompt do numero C
    pmaior: .asciiz "O maior numero e: "         # rotulo do resultado final

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, p1                       # $a0 = endereco do prompt de A
    syscall                            # imprime o prompt de A
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro -> resultado em $v0
    move $t0, $v0                      # $t0 = A

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, p2                       # $a0 = endereço do prompt de B
    syscall                            # imprime o prompt de B
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro -> resultado em $v0
    move $t1, $v0                      # $t1 = B

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, p3                       # $a0 = endereço do prompt de C
    syscall                            # imprime o prompt de C
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro -> resultado em $v0
    move $t2, $v0                      # $t2 = C

    bge  $t0, $t1, a_maior_b           # Passo 1: se A >= B, vai para a_maior_b
    move $t3, $t1                      # senao, o maior temporario ($t3) recebe B
    j    compara_c                     # pula o bloco a_maior_b e vai comparar com C

a_maior_b:                             # rotulo: se A maior que B
    move $t3, $t0                      # maior temporario ($t3) recebe A

compara_c:                             # Passo 2: compara o atual maior com C
    bge  $t3, $t2, maior_final         # se maior_temporario >= C, vai para maior_final
    move $t3, $t2                      # senao, o maior definitivo ($t3) recebe C

maior_final:                           # rotulo: impressão do maior
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pmaior                   # $a0 = endereço da string de resultado
    syscall                            # imprime o rotulo
    move $a0, $t3                      # $a0 = valor do maior numero final
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o maior numero

    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução