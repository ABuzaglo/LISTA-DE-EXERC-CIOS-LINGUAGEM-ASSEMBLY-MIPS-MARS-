.data
    vetor: .word 5, 10, 15, 20, 25     # declara vetor com 5 elementos inteiros
    psoma: .asciiz "A soma dos elementos e: " # rotulo de resultado

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    la   $t0, vetor                    # $t0 = endereço base do vetor
    li   $t1, 5                        # $t1 = 5 (tamanho do vetor)
    li   $t2, 0                        # $t2 = 0 (indice)
    li   $t3, 0                        # $t3 = 0 (acumulador de soma inicializado em zero)

loop:                                  # rotulo: laco de percurso
    bge  $t2, $t1, fim                 # se indice >= tamanho, sai do loop

    lw   $t4, 0($t0)                   # $t4 = carrega o elemento atual da memoria
    add  $t3, $t3, $t4                 # soma = soma + elemento atual

    addi $t0, $t0, 4                   # avanca o ponteiro em 4 bytes (proximo inteiro)
    addi $t2, $t2, 1                   # incrementa o indice
    j    loop                          # volta para ler o proximo

fim:                                   # rotulo: impressão fora do loop
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, psoma                    # $a0 = endereço do rotulo
    syscall                            # imprime o rotulo
    move $a0, $t3                      # $a0 = valor total acumulado no laço
    li   $v0, 1                        # $v0 = 1 -> servico "imprimir inteiro"
    syscall                            # imprime a soma final

    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução