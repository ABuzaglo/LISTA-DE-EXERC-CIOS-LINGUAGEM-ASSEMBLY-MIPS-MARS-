.data
    vetor:  .word 5, 10, 15, 20, 25    # declara vetor
    pmaior: .asciiz "O maior elemento e: " # rotulo do resultado

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    la   $t0, vetor                    # $t0 = endereço base do vetor
    li   $t1, 5                        # $t1 = 5 (tamanho do vetor)

    lw   $t3, 0($t0)                   # inicializa 'maior' ($t3) com o 1o elemento do vetor
    addi $t0, $t0, 4                   # avanca o ponteiro para o 2o elemento
    li   $t2, 1                        # o indice de leitura comeca em 1 (o 0 ja foi lido)

loop:                                  # rotulo: busca continua
    bge  $t2, $t1, fim                 # se indice >= tamanho, sai do laco

    lw   $t4, 0($t0)                   # $t4 = carrega o elemento atual da memoria
    ble  $t4, $t3, nao_atualiza        # se o elemento <= 'maior' salvo, nao faz nada
    move $t3, $t4                      # senao, o elemento vira o novo 'maior'

nao_atualiza:                          # rotulo: ponto de convergencia do laco
    addi $t0, $t0, 4                   # avanca o ponteiro para o proximo elemento
    addi $t2, $t2, 1                   # avanca o indice
    j    loop                          # volta ao topo

fim:                                   # rotulo: bloco de finalizacao
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pmaior                   # $a0 = endereço do rotulo
    syscall                            # imprime o rotulo
    move $a0, $t3                      # $a0 = valor do maior elemento encontrado
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o maior elemento

    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução