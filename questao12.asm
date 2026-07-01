.data                            
    pn:   .asciiz "Digite um numero para calcular o fatorial: " # string do prompt
    pfat: .asciiz "O fatorial e: "                              # string de resultado

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pn                       # $a0 = endereço do prompt
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro -> resultado em $v0
    move $t0, $v0                      # $t0 = N (numero limite do fatorial)

    li   $t1, 1                        # $t1 = 1 (acumulador do fatorial começa em 1)
    li   $t2, 1                        # $t2 = 1 (contador de iteracao começa em 1)

loop:                                  # rotulo: inicio do calculo
    bgt  $t2, $t0, fim                 # se contador > N, o fatorial ja esta pronto
    mul  $t1, $t1, $t2                 # fatorial = fatorial * contador
    addi $t2, $t2, 1                   # contador = contador + 1
    j    loop                          # volta ao topo do laço

fim:                                   # rotulo: impressão final
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pfat                     # $a0 = endereço da string de resultado
    syscall                            # imprime "O fatorial e: "
    move $a0, $t1                      # $a0 = valor do fatorial acumulado
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o fatorial

    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução