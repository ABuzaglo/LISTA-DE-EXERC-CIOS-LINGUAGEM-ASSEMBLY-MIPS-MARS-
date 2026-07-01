.data
    p1:    .asciiz "Digite o primeiro numero: "  # prompt do primeiro numero
    p2:    .asciiz "Digite o segundo numero: "   # prompt do segundo numero
    psoma: .asciiz "A soma e: "                  # rotulo para o retorno da função

.text                                  # inicio do segmento de codigo
.globl main                            # define "main" como ponto de entrada
main:                                  # rotulo de inicio do programa
    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, p1                       # $a0 = endereço do prompt 1
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro
    move $t0, $v0                      # $t0 = primeiro numero (a)

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, p2                       # $a0 = endereço do prompt 2
    syscall                            # imprime o prompt
    li   $v0, 5                        # $v0 = 5 -> serviço "ler inteiro"
    syscall                            # le inteiro
    move $t1, $v0                      # $t1 = segundo numero (b)

    move $a0, $t0                      # $a0 = primeiro parametro para a funcao
    move $a1, $t1                      # $a1 = segundo parametro para a funcao
    jal  somar                         # "jump and link": chama a funcao e salva retorno em $ra
    move $t2, $v0                      # $t2 = salva o valor de retorno da funcao ($v0)

    li   $v0, 4                        # $v0 = 4 -> serviço "imprimir string"
    la   $a0, psoma                    # $a0 = endereço do rotulo
    syscall                            # imprime o rotulo
    move $a0, $t2                      # $a0 = resultado retornado
    li   $v0, 1                        # $v0 = 1 -> serviço "imprimir inteiro"
    syscall                            # imprime o resultado retornado

    li   $v0, 10                       # $v0 = 10 -> serviço "encerrar programa"
    syscall                            # finaliza a execução

somar:                                 # rotulo da função somar
    add  $v0, $a0, $a1                 # soma os argumentos e guarda o resultado em $v0 (retorno)
    jr   $ra                           # "jump register": volta para o endereço armazenado em $ra