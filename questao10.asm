.data                                  
    pn:    .asciiz "Digite o valor de N: "      # string do prompt
    psoma: .asciiz "A soma de 1 até N e: "      # string do rotulo de resultado

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pn                       # $a0 = endereço do prompt
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro -> resultado em $v0
    move $t0, $v0                      # $t0 = N (limite do loop)

    li   $t1, 1                        # $t1 = 1 (inicializa o contador 'i')
    li   $t2, 0                        # $t2 = 0 (inicializa o acumulador 'soma')

loop:                                  # rotulo: inicio do laço
    bgt  $t1, $t0, fim                 # se i > N, sai do loop e vai para 'fim'
    add  $t2, $t2, $t1                 # soma = soma + i (acumula o valor atual)
    addi $t1, $t1, 1                   # i = i + 1 (incrementa o contador)
    j    loop                          # volta para o inicio do loop

fim:                                   # rotulo: fim do laço e impressao
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, psoma                    # $a0 = endereço da string de resultado
    syscall                            # imprime o rotulo
    move $a0, $t2                      # $a0 = valor total acumulado na soma
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime a soma

    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução