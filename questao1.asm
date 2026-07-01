.data                                  # inicio do segmento de dados
    msg_resultado: .asciiz "O resultado da soma e: "  # 

.text                                  
.globl main                            # define a main
main:                                  # rotulo que marca o inicio do programa
    li   $t0, 10              # $t0 = A = 10
    li   $t1, 20              # $t1 = B = 20
    add  $t2, $t0, $t1        # $t2 = A + B

    li   $v0, 4               # para fazer o print
    la   $a0, msg_resultado   # endereço do que deve ser impresso
    syscall                   # executa o print

    move $a0, $t2             # leva o resultado da soma para $a0
    li   $v0, 1               # para fazer o print
    syscall                   # executa o print

    li   $v0, 10              # $v0 = 10 -> servico "encerrar programa"
    syscall                   # finaliza a execução