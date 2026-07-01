.data
    pn:   .asciiz "Digite um numero para calcular o fatorial (recursivo): "  # prompt
    pfat: .asciiz "O fatorial e: "                                           # rotulo resultado

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pn                       # $a0 = endereço do prompt
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro
    move $a0, $v0                      # $a0 = valor lido (parametro passado direto)

    jal  fatorial                      # chama a rotina recursiva
    move $t0, $v0                      # $t0 recebe o resultado

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pfat                     # $a0 = rotulo de resposta
    syscall                            # imprime o rotulo
    move $a0, $t0                      # $a0 = resultado do fatorial
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime a resposta

    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução

fatorial:                              # rotulo da função fatorial
    bgt  $a0, 1, caso_recursivo        # se N > 1, deve fazer a chamada recursiva
    li   $v0, 1                        # se N <= 1 (caso base), fatorial é 1
    jr   $ra                           # retorna sem precisar alocar pilha

caso_recursivo:                        # rotulo para calcular N * fatorial(N-1)
    addi $sp, $sp, -8                  # abre 8 bytes na pilha (para guardar N e o RA)
    sw   $a0, 4($sp)                   # salva o 'N' atual no topo da pilha
    sw   $ra, 0($sp)                   # salva o 'return address' desta etapa na pilha

    addi $a0, $a0, -1                  # parametro atualiza: N = N - 1
    jal  fatorial                      # chamada recursiva para fatorial(N-1)

    lw   $ra, 0($sp)                   # apos o retorno do filho, restaura este 'return address'
    lw   $a0, 4($sp)                   # restaura o 'N' que gerou esta chamada
    addi $sp, $sp, 8                   # libera os 8 bytes da pilha

    mul  $v0, $a0, $v0                 # $v0 = N (restaurado) * fatorial(N-1) (retorno da subrotina)
    jr   $ra                           # retorna o resultado do calculo para quem chamou