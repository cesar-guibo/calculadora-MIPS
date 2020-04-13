	.data

	.align 0
requerir_id_operacao: .asciiz "\n"
output_resultado: 		.space 50

	.align 2
jump_table: .word case_sair, case_soma, case_subtracao, case_multiplicacao, 
		          case_divisao, case_potencia, case_raiz_quadrada, case_tabuada,
		  	      case_imc, case_fatorial, case_fibonacci, case_default


	.text
main:	
	la $s0, jump_table
	la $s1, requerir_id_operacao
main_loop:
	li $v0, 4 										# $v0 = 4, syscall imprime string
	move $a0, $s1 									# $a0 = $s1, seleciona requerir_id_operacao
	syscall 										# Imprime requerir_id_operacao

	li $v0, 5 										# $v0 = 5, syscall le int
	syscall 										# Le o id da operacao
sll $t0, $v0, 2 								# $t0 = id da operacao * 4
	add $t0, $t0, $s0 								# $t0 = &jump_table[id_operacao]
	lw $t1, 0($t0) 									# $t1 = jump_table[id_operacao] 
	jr $t1 											# Jump to jump_table[id_operacao] 

case_sair:
	j main_loop_end 								# Sai do loop

case_soma:
#Colocar a string que pede os operandos
	li $v0, 1
	li $a0, 1
	syscall

	li $v0, 4
	la $a0, requerir_id_operacao
	syscall

	li $v0, 5
	syscall
	move $a0, $v0

	li $v0, 5
	syscall
	move $a1, $v0

	jal soma
	move $t0, $v0

	li $v0, 4
	la $a0, output_resultado
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	j main_loop

case_subtracao:
#Colocar a string que pede os operandos 
	li $v0, 1
	li $a0, 2
	syscall

	li $v0, 4
	la $a0, requerir_id_operacao
	syscall

	li $v0, 5
	syscall
	move $a0, $v0

	li $v0, 5
	syscall
	move $a1, $v0

	jal subtracao
	move $t0, $v0

	li $v0, 4
	la $a0, output_resultado
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	j main_loop 

case_multiplicacao:
#Colocar a string que pede os operandos
	li $v0, 1
	li $a0, 3
	syscall

	li $v0, 4
	la $a0, requerir_id_operacao
	syscall

	li $v0, 5
	syscall
	move $a0, $v0

	li $v0, 5
	syscall
	move $a1, $v0

	jal multiplicacao
	move $t0, $v0
	
	li $v0, 4
	la $a0, output_resultado
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	j main_loop

case_divisao:
#Colocar a string que pede os operandos
	li $v0, 1
	li $a0, 4
	syscall

	li $v0, 4
	la $a0, requerir_id_operacao
	syscall

	li $v0, 5
	syscall
	move $a0, $v0

	li $v0, 5
	syscall
	move $a1, $v0

	jal divisao
	move $t0, $v0

	li $v0, 4
	la $a0, output_resultado
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	j main_loop

case_potencia:
#Colocar a string que pede os operandos
	li $v0, 1
	li $a0, 5
	syscall
	
	li $v0, 4
	la $a0, requerir_id_operacao
	syscall

	li $v0, 5
	syscall
	move $a0, $v0

	li $v0, 5
	syscall
	move $a1, $v0

	jal potencia
	move $t0, $v0
	
	li $v0, 4
	la $a0, output_resultado
	syscall

	li $v0, 1
	move $a0, $t0
	syscall
	
	j main_loop

case_raiz_quadrada:
#Colocar a string que pede os operandos
	li $v0, 5
	syscall
	move $v0, $a0

	jal raiz_quadrada
	
	li $v0, 4
	la $a0, output_resultado
	syscall
	
	move $a0, $v0
	li $v0, 1
	syscall

	j main_loop

case_tabuada:
#Colocar a string que pede os operandos
	li $v0, 5
	syscall
	move $v0, $a0

	jal raiz_quadrada
	
	li $v0, 4
	la $a0, output_resultado
	syscall
	
	move $a0, $v0
	li $v0, 1
	syscall

	j main_loop

case_imc:
#Colocar a string que pede os operandos
	li $v0, 5
	syscall
	move $v0, $a0

	li $v0, 5
	syscall
	move $v0, $a1

	jal imc
	
	li $v0, 4
	la $a0, output_resultado
	syscall

	move $a0, $v0
	li $v0, 1
	syscall

	j main_loop

case_fatorial:
#Colocar a string que pede os operandos
	li $v0, 5
	syscall
	move $v0, $a0

	jal fatorial

	li $v0, 4
	la $a0, output_resultado
	syscall

	move $a0, $v0
	li $v0, 1
	syscall

	j main_loop

case_fibonacci:
#Colocar a string que pede os operandos
	li $v0, 5
	syscall
	move $v0, $a0

	jal fatorial

	li $v0, 4
	la $a0, output_resultado
	syscall

	move $a0, $v0
	li $v0, 1
	syscall

	j main_loop

case_default:
	j main_loop

main_loop_end:
	li $v0, 10
	syscall	


soma:
	slt $t0, $a0, $zero 					# $t0 = ($a0 < 0)
	slt $t1, $a1, $zero 					# $t1 = ($a1 < 0)

	and $t2, $t0, $t1 						# $t2 = (($a0 < 0) and ($a1 < 0))

	# $t3 = (($a0 >= 0) and ($a1 >= 0))
	or $t3, $t0, $t1 						# $t3 = (($a0 < 0) or ($a1 < 0))
	xori $t3, $t3, 1 						# $t3 = (not (($a0 < 0) or ($a1 < 0)))		


	jr $ra 									# Volta para onde essa funcao foi chamada


subtracao:
	# $a0 - $a1 = $a0 + (- $a1)
	sub $a1, $zero, $a1 					# $$a1 = - $a1
	jal soma

	sub $a1, $zero, $a1 					# Restaura $a1

	jr $ra

multiplicacao:
	mul $v0, $a0, $a1
	jr $ra

divisao:
	div $v0, $a0, $a1	
	jr $ra

potencia:
	beq $a1, 1, potencia_caso_base 				# Se o expoente for 1 jump to potencia_caso_base
	
	move $t0, $a0 								# Guarda o valor armazenado em $a0 em $t0
	move $t1, $a1 								# Guarda o valor armazenado em $a1 em $t1
	li $t2, 2 									# Deixa 2 carregado em $t2

	subi $sp, $sp, 12 							# Cresce a stack em 12 posições 
	sw $ra, 8($sp) 								# Salva $ra na stack
	sw $a0, 4($sp) 								# Salva $a0 na stack
	sw $a1, 0($sp) 								# Salva $a1 na stack

	mul $a0, $t0, $t0 							# $a0 = $t0 * $t0
	div $a1, $t1, $t2 							# $a1 = $t2 / 2
	jal potencia 								# Chama subrotina potencia

	lw $ra, 8($sp) 								# Recupera $ra da stack
	lw $a0, 4($sp) 								# Recupera $a0 da stack
	lw $a1, 0($sp) 								# Recupera $a1 da stack
	addi $sp, $sp, 12 							# Encolhe a stack em 12 posições

	rem $t3, $a1, $t2 							# Verifica se o expoente é par
	bne $t3, $zero, potencia_expoente_impar 	# Se o expoente for par jump to potencia_expoente_impar
potencia_expoente_par
	jr $ra 										# Retorna $v0
potencia_expoente_impar:
	mul $v0, $v0, $a0 							# $v0 = $v0 * $a0
	jr $ra 										# Retorna $v0
potencia_caso_base:
	move $v0, $a0 								# $v0 = $a0
	jr $ra 										# Retorna $v0

raiz_quadrada:
	move $t0, $a0

	li $v0, 1
	li $a0, 5
	syscall

	jr $ra

tabuada:
	move $t0, $a0

	li $v0, 1
	li $a0, 6
	syscall

	jr $ra

imc:
	move $t0, $a0

	li $v0, 1
	li $a0, 7
	syscall

	jr $ra

fatorial:
	move $t0, $a0

	li $v0, 1
	li $a0, 8
	syscall

	jr $ra

fibonacci:
	move $t0, $a0

	li $v0, 1
	li $a0, 9
	syscall

	jr $ra

