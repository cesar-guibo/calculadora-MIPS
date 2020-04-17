# Dvisao deve retornar o resto ?
# TODO Strings que devem ser impressas
# No caso IMC, peso primeiro, altura dps
# TODO imprime_resultado
# TODO tabuada 
    .data

    .align 0
requerir_id_operacao:           .asciiz "\n"
requerir_operando1_soma:        .asciiz "\n"
requerir_operando2_soma:        .asciiz "\n"
requerir_operando1_sub:         .asciiz "\n"
requerir_operando2_sub:         .asciiz "\n"
requerir_operando1_mult:        .asciiz "\n"
requerir_operando2_mult:        .asciiz "\n"
requerir_operando1_div:         .asciiz "\n"
requerir_operando2_div:         .asciiz "\n"
requerir_operando1_pot:         .asciiz "\n"
requerir_operando2_pot:          .asciiz "\n"
requerir_operando_raiz:         .asciiz "\n"
requerir_operando_tabuada:      .asciiz "\n"
requerir_operando1_imc:         .asciiz "\n"
requerir_operando2_imc:         .asciiz "\n"
requerir_operando_fatorial:     .asciiz "\n"
requerir_operando_fibonacci:    .asciiz "\n"
id_invalido: 			.asciiz "\n"
string_precede_resultado:       .asciiz "\n"

    .align 2
cases_table: .word case_sair, case_soma, case_subtracao, case_multiplicacao, 
                  case_divisao, case_potencia, case_raiz_quadrada,
		  case_tabuada, case_imc, case_fatorial, case_fibonacci


    .text
main:   
    la $s0, cases_table                     # Carrega o vetor de labels cases_table em $s0
    la $s1, requerir_id_operacao            # Carrega a string que pede o id_operacao em $s1

main_loop:
    li $v0, 4                               # $v0 = 4, syscall imprime string
    move $a0, $s1                           # $a0 = $s1, seleciona requerir_id_operacao
    syscall                                 # Imprime requerir_id_operacao

    li $v0, 5                               # $v0 = 5, syscall le int
    syscall                                 # Le o id da operacao
    move $s2, $v0 			    # Carrega o id da operacao em $s2

    # Verifica se o id_operacao e invalido 
    slti $t0, $s2, 11                       # $t0 = ($v0 < 11)
    beq $t0, $zero, id_operacao_invalido    # Se $t0 = false jump to id_operacao_invalido

    # Vai para o case da operacao selecionada
    sll $t0, $s2, 2                         # $t0 = id da operacao * 4
    add $t0, $t0, $s0                           # $t0 = &cases_table[id_operacao]
    lw $t1, 0($t0)                          # $t1 = cases_table[id_operacao] 
    jr $t1                                  # Jump to cases_table[id_operacao] 

case_sair:
    j main_loop_end                 # Sai do loop

case_soma:
    li $a0, 2                       # Carrega o numero de operandos em $a0
    la $a1, requerir_operando1_soma # Carrega a string que pede o primeiro operando da soma em $a1 
    la $a2, requerir_operando2_soma # Carrega a string que pede o segundo operando da soma em $a2
    jal le_operandos                # Chama sub_rotina le operandos   

    move $a0, $v0                   # Carrega o primeiro operando obtido por le_operandos em $a0
    move $a1, $v1                   # Carrega o segundo operando obtido por le_operandos em $a1
    jal soma                        # Chama sub-rotina soma

    j cases_end                     

#Equivalente � soma, mas com subtra��o
case_subtracao:
    li $a0, 2
    la $a1, requerir_operando1_sub
    la $a2, requerir_operando2_sub
    jal le_operandos    

    move $a0, $v0
    move $a1, $v1
    jal subtracao

    j cases_end

#Equivalente � soma, mas com multiplica��o
case_multiplicacao:
    li $a0, 2
    la $a1, requerir_operando1_mult
    la $a2, requerir_operando2_mult
    jal le_operandos    

    move $a0, $v0
    move $a1, $v1
    jal multiplicacao

    j cases_end
    
#Equivalente � soma, mas com divis�o
case_divisao:
    li $a0, 2
    la $a1, requerir_operando1_div
    la $a2, requerir_operando2_div
    jal le_operandos    

    move $a0, $v0
    move $a1, $v1
    jal divisao

    j cases_end

#Equivalente � soma, mas com pontencia��o
case_potencia:
    li $a0, 2
    la $a1, requerir_operando1_pot
    la $a2, requerir_operando2_pot
    jal le_operandos    

    move $a0, $v0
    move $a1, $v1
    jal potencia

    j cases_end

case_raiz_quadrada:
    li $a0, 1 # Carrega o numero de operandos em $a0
    la $a1, requerir_operando_raiz # Carrega a string que pede o operando da raiz em $a1 
    jal le_operandos    # Chama sub_rotina le operandos

    move $a0, $v0 # Carrega o operando obtido por le_operandos em $a0
    jal raiz_quadrada # Chama sub-rotina raiz
    
    j cases_end

#Equivalente � raiz, mas com tabuada
case_tabuada:
    li $a0, 1
    la $a1, requerir_operando_tabuada
    jal le_operandos    

    move $a0, $v0
    jal tabuada
    
    j cases_end
    
#Equivalente � soma, mas com IMC
case_imc:
    li $a0, 2
    la $a1, requerir_operando1_imc
    la $a2, requerir_operando2_imc
    jal le_operandos    

    move $a0, $v0
    move $a1, $v1
    jal imc
    
    j cases_end

#Equivalente � raiz, mas com fatorial
case_fatorial:
    li $a0, 1
    la $a1, requerir_operando_fatorial
    jal le_operandos    

    move $a0, $v0
    jal fatorial

    j cases_end

#Equivalente � raiz, mas com a sequencia de Fibonacci
case_fibonacci:
    li $a0, 1
    la $a1, requerir_operando_fibonacci
    jal le_operandos    

    move $a0, $v0
    jal fibonacci

cases_end:
    move $a0, $s2 		 # Carrega o id da operacao para $a0
    move $a1, $v0 		 # Carrega o valor retornado pela operacao em $a1
    jal imprime_resultado
    
    j main_loop

#Cuida do caso no qual o id inserido � invalido
id_operacao_invalido:
    la $a0, id_invalido
    syscall

    j main_loop

main_loop_end:
    li $v0, 10
    syscall 


# Sub-rotina que recebe uma parcela da soma em $a0,
# outra em $a1 e retorna o resultado da soma em $v0
soma:
    add $v0, $a0, $a1   # $v0 = $a0 + $a1
    jr $ra              


# Sub-rotina que recebe o minuendo da subtracao em $a0,
# o subtraendo em $a1 e retorna a diferenca em $v0
subtracao:
    sub $v0, $a0, $a1   # $v0 = $a0 - $a1       
    jr $ra               

# Sub-rotina que recebe um fator da multiplicacao em $a0,
# outro em $a1 e retorna o produto em $v0
multiplicacao:
    mul $v0, $a0, $a1   # $v0 = $a0 * $a1
    jr $ra

# Sub-rotina que receb um dividendo em $a0,
# um divisor em $a1 e retorna o quociente em $v0
divisao:
    div $v0, $a0, $a1   # $v0 = $a0 / $a1
    jr $ra


# Sub-rotina que recebe a base em $a0 e o expoente em $a1 e 
# retorna o resultado de $ao^$a1.
potencia:
    beq $a1, 1, potencia_caso_base              # Se o expoente for 1 jump to potencia_caso_base
    
    move $t0, $a0                               # Guarda o valor armazenado em $a0 em $t0
    move $t1, $a1                               # Guarda o valor armazenado em $a1 em $t1
    li $t2, 2                                   # Deixa 2 carregado em $t2

    subi $sp, $sp, 12                           # Cresce a stack em 12 posições 
    sw $ra, 8($sp)                              # Salva $ra na stack
    sw $a0, 4($sp)                              # Salva $a0 na stack
    sw $a1, 0($sp)                              # Salva $a1 na stack

    mul $a0, $t0, $t0                           # $a0 = $t0 * $t0
    div $a1, $t1, $t2                           # $a1 = $t1 / 2 
    jal potencia                                # Chama sub-rotina potencia recursivamente

    lw $ra, 8($sp)                              # Recupera $ra da stack
    lw $a0, 4($sp)                              # Recupera $a0 da stack
    lw $a1, 0($sp)                              # Recupera $a1 da stack
    addi $sp, $sp, 12                           # Encolhe a stack em 12 posições

    rem $t3, $a1, $t2                           # Verifica se o expoente é par
    bne $t3, $zero, potencia_expoente_impar     # Se o expoente for par jump to potencia_expoente_impar
potencia_expoente_par:
    jr $ra                                      # Retorna $v0
potencia_expoente_impar:
    mul $v0, $v0, $a0                           # $v0 = $v0 * $a0
    jr $ra                                      # Retorna $v0
potencia_caso_base:
    move $v0, $a0                               # $v0 = $a0
    jr $ra                                      # Retorna $v0


raiz_quadrada:
	add $t0, $a0, $zero                     #t0 = a0
	li $t1, 0				#t1 = 0
	li $t5, 2				#t5 = 2
	li $t6, 1				#t6 = 1
	add $t2, $a0, $zero			#t2 = a0
	div $t3, $t0, 2				#t3 = a0/2
	subi $sp, $sp, 4			#subtrai 4 posicoes da stack
	sw $ra, 0($sp)				#Guarda o return adress
	jal loop_raiz
	lw $ra, 0($sp)				#Recupera o return adress
	addi $sp, $sp, 4			#Volta a stack a posicao inicial
	jr $ra

loop_raiz:
	div $t4, $t0, $t2			#t4 = t0/t2
	add $t4, $t4, $t2			#t4 = t4 + t2
	div $t2, $t4, $t5			#t2 = t4/2
	add $t1, $t1, $t6			#t1++
	blt $t1, $t3, loop_raiz			#if t1<t3, loop
	move $v0, $t2				#Retorna t2
	jr $ra
tabuada:

imc:
	mul $t0, $a1, $a1 #t0 = altura^2
	div $v0, $a0, $t0  #v0 = ao/a1
	jr $ra

# Sub-rotina que recebe como parametro o numero, o qual
# se deseja calcular o fatorial em $a0 e retorna o valor
# do fatorial em $v0
fatorial:
    slti $t0, $a0, 2
    bne $t0, $zero, fatorial_base_case

    subi $sp, $sp, 8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    subi $a0, $a0, 1
    jal fatorial

    lw $a0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8

    mul $v0, $a0, $v0

    jr $ra

fatorial_base_case:
    li $v0, 1
    jr $ra

# Sub-rotina que recebe como parametro o indice da 
# sequencia de fibonacci desejado em $a0 e retorna 
# o valor desse numero de fibonacci
fibonacci:
    beq $a0, $zero fibonacci_base_case_zero
    beq $a0, 1, fibonacci_base_case_one

    subi $sp, $sp, 12
    sw $ra, 8($sp)
    sw $a0, 4($sp)
    sw $s0, 0($sp) 
   
    subi $a0, $a0, 1
    jal fibonacci
    move $s0, $v0

    subi $a0, $a0, 1
    jal fibonacci

    add $v0, $s0, $v0
    
    lw $s0, 0($sp) 
    lw $a0, 4($sp)
    lw $ra, 8($sp)
    addi $sp, $sp, 12

    jr $ra

fibonacci_base_case_zero:
	move $v0, $zero
	jr $ra

fibonacci_base_case_one:
	li $v0, 1
	jr $ra



# Sub-rotina que recebe como parametros o numero de operandos
# que devem ser requisitados em $a0, a string que requisita o 
# primeiro operando em $a1 e se $a0 == 2 a string que requisita
# o segundo operando. Retorna o primeiro operando em $v0 e caso
# exista um segundo operando o retorna em $v1
le_operandos:
    move $t0, $a0                   # Salva o valor de $a0 em $t0 

    li $v0, 4                       # Valor para syscall imprimir string 
    move $a0, $a1                   # Carrega a string que requisita o operando1 como argumento para syscall
    syscall                         

    li $v0, 5                       # Valor para syscall ler um int
    syscall

    # Se o numero de operandos que deve se ler e apenas um, finaliza operacao
    bne $t0, 2 le_operandos_end    # Se $t0 != 2 jump to le_operandos_end

    move $t3, $v0                   # Salva o primeiro operando em $t3
    
    li $v0, 4                       # Valor para syscall imprimir string 
    move $a0, $a1                   # Carrega a string que requisita o operando1 como argumento para syscall
    syscall                         

    li $v0, 5                       # Valor para syscall ler um int
    syscall

    move $v1, $v0                   # Passa o valor do segundo operando para $v1
    move $v0, $t3                   # Retorna o valor do primeiro operando para $v0

le_operandos_end:
    move $a0, $t0                   # Restaura o valor inicial de $a0
    jr $ra


imprime_resultado:
    move $t0, $a0

    la $a0, string_precede_resultado
    li $v0, 4
    syscall

    move $a0, $a1
    li $v0, 1
    syscall

    move $a0, $t0

    jr $ra
