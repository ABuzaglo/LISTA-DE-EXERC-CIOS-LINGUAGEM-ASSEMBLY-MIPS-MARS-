.data                                  # inicio do segmento de dados
    p1:     .asciiz "Digite um numero inteiro: " # string do prompt
    epar:   .asciiz "PAR"              # string para o resultado par
    eimpar: .asciiz "IMPAR"            # string para o resultado impar

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4                        # $v0 = 4 -> servico "imprimir string"
    la   $a0, p1                       # $a0 = endereco do prompt
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> servico "ler inteiro"
    syscall                            # le inteiro -> resultado vem em $v0
    move $t0, $v0                      # $t0 = numero digitado

    li   $t1, 2                        # $t1 = 2 (divisor)
    div  $t0, $t1                      # hi = resto da divisao de $t0 por 2
    mfhi $t2                           # $t2 = resto da divisao (copiado de hi)

    beq  $t2, $zero, eh_par            # se resto == 0, desvia para o rotulo eh_par
    j    eh_impar                      # caso contrario, salta para eh_impar

eh_par:                                # rotulo: bloco executado se for par
    li   $v0, 4                        # $v0 = 4 -> servico "imprimir string"
    la   $a0, epar                     # $a0 = endereco da string "PAR"
    syscall                            # imprime "PAR"
    j    fim                           # salta para o fim (pula o bloco impar)

eh_impar:                              # rotulo: bloco executado se for impar
    li   $v0, 4                        # $v0 = 4 -> servico "imprimir string"
    la   $a0, eimpar                   # $a0 = endereco da string "IMPAR"
    syscall                            # imprime "IMPAR"

fim:                                   # rotulo de finalizacao do programa
    li   $v0, 10                       # $v0 = 10 -> servico "encerrar programa"
    syscall                            # finaliza a execucao