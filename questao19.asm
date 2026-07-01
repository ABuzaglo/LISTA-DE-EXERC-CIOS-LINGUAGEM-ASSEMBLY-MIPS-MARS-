.data
    pnum:  .asciiz "Digite um numero: "                          # prompt de entrada
    porig: .asciiz "Numero original: "                           # rotulo do numero preservado
    pres:  .asciiz " | Resultado (numero*2+1): "                 # rotulo do processamento

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pnum                     # $a0 = endereço do prompt
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> servico "ler inteiro"
    syscall                            # le inteiro
    move $t0, $v0                      # $t0 = numero lido, que sera preciso APOS a funcao

    move $a0, $t0                      # passa o numero como parametro em $a0
    jal  calcular                      # chama a rotina calcular
    move $t1, $v0                      # $t1 = pega o retorno da funcao

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, porig                    # $a0 = endereço do rotulo do valor preservado
    syscall                            # imprime o rotulo
    move $a0, $t0                      # $a0 = valor original de $t0
                                       # (deve estar intacto se a pilha funcionou)
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o valor de $t0

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, pres                     # $a0 = rotulo da segunda parte
    syscall                            # imprime rotulo do resultado
    move $a0, $t1                      # $a0 = valor retornado de fato
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o valor alterado pela funcao

    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução

calcular:                              # rotulo da função
    addi $sp, $sp, -4                  # subtrai 4 de $sp (abre espaco no topo da pilha)
    sw   $t0, 0($sp)                   # salva o valor do $t0 atual na pilha

    move $t0, $a0                      # agora a função pode modificar $t0 sem estragar o main
    add  $t0, $t0, $t0                 # $t0 = $t0 * 2
    addi $t0, $t0, 1                   # $t0 = $t0 + 1
    move $v0, $t0                      # $v0 = resultado que sera retornado

    lw   $t0, 0($sp)                   # restaura o valor original de $t0 lendo a pilha
    addi $sp, $sp, 4                   # libera a pilha (soma 4 no $sp)

    jr   $ra                           # retorna para o fluxo principal