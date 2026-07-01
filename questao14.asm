.data                                  
    vetor:  .word 5, 10, 15, 20, 25    # aloca 5 inteiros (4 bytes cada) consecutivos
    espaco: .asciiz " "                # string de espaco em branco

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    la   $t0, vetor                    # $t0 = carrega o endereço base do vetor (ponteiro)
    li   $t1, 5                        # $t1 = 5 (tamanho total do vetor)
    li   $t2, 0                        # $t2 = 0 (indice atual)

loop:                                  # rotulo: percurso do vetor
    bge  $t2, $t1, fim                 # se indice >= tamanho, sai do loop

    lw   $t3, 0($t0)                   # $t3 = le a palavra na memoria no endereco de $t0
    move $a0, $t3                      # $a0 = elemento atual do vetor
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o elemento lido

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, espaco                   # $a0 = endereço do espaco em branco
    syscall                            # imprime o espaco

    addi $t0, $t0, 4                   # $t0 = $t0 + 4 (avanca o ponteiro 4 bytes)
    addi $t2, $t2, 1                   # incrementa o indice
    j    loop                          # volta ao topo do laço

fim:                                   # rotulo de finalização
    li   $v0, 10                       # $v0 = 10 -> servico "encerrar programa"
    syscall                            # finaliza a execução