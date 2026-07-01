.data                                  
    espaco: .asciiz " "                # string com um espaco em branco para separacao

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $t0, 1                        # $t0 = 1 (inicializa o contador do loop)

loop:                                  # rotulo: topo da estrutura de repeticao
    bgt  $t0, 10, fim                  # se contador > 10, sai do loop e vai para 'fim'

    move $a0, $t0                      # $a0 = valor atual do contador
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o numero atual

    li   $v0, 4                        # $v0 = 4 -> servico "imprimir string"
    la   $a0, espaco                   # $a0 = serviço da string de espaco
    syscall                            # imprime o espaco em branco

    addi $t0, $t0, 1                   # contador = contador + 1 (incrementa)
    j    loop                          # salta de volta para o inicio do loop

fim:                                   # rotulo: fim do programa
    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução