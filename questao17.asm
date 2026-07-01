.data               
    vetor:  .word 5, 10, 15, 20, 25    # declaração do vetor
    ppares: .asciiz "Quantidade de numeros pares: " # string de resultado

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    la   $t0, vetor                    # $t0 = ponteiro do vetor
    li   $t1, 5                        # $t1 = tamanho do vetor
    li   $t2, 0                        # $t2 = 0 (indice)
    li   $t3, 0                        # $t3 = 0 (contador de numeros pares)

loop:                                  # rotulo: analise de elementos
    bge  $t2, $t1, fim                 # se lidos >= tamanho, vai para o fim

    lw   $t4, 0($t0)                   # $t4 = elemento atual da iteracao
    li   $t5, 2                        # carrega a constante 2 para a divisao
    div  $t4, $t5                      # divide elemento por 2 (resto vai para hi)
    mfhi $t6                           # $t6 = resto da divisao
    bne  $t6, $zero, eh_impar          # se resto != 0 (impar), pula o incremento

    addi $t3, $t3, 1                   # passou pelo if: é par, incrementa o contador

eh_impar:                              # rotulo: pulo para ignorar os impares
    addi $t0, $t0, 4                   # avanca ponteiro em 4 bytes
    addi $t2, $t2, 1                   # avanca indice
    j    loop                          # volta pro inicio

fim:                                   # rotulo: resultados
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, ppares                   # $a0 = endereço da string de resultado
    syscall                            # imprime a string
    move $a0, $t3                      # $a0 = contagem de pares
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime a contagem

    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução