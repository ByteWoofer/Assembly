@Program: evaluate_expression
@Author: Chris Gendreau
@Purpose: Operate on a list of values based on a list of characters
@Date: 10/21/2016

.text
.equ mult, 77
.global _main
_main:
		LDR R0, =eoa 	@load end of number address into R0
		LDR R1, =arrn	@load address for numbers into R1
		LDR R2, =arrc	@load address for characters into R2
		LDRB R3, [R1], #1 @load one byte from arrn to R3
		MOV R6, #mult   	 @load capital M into R6
loop:
		LDRB R4, [R1], #1 @load one byte from arrn to R4
		LDRB R5, [R2], #1 @load one byte from arrc to R5
		CMP R5, R6		@compare char - M(77)
		BL evaluate_expression @create return and branch
		CMP R1, R0 		@are we at the end?
		BNE loop			@go again!
		B stop		@Fin!
stop:
		MOV R0, #1		@output: stdout
		MOV R1, R3		@data: R3
		SWI 0x6B		@print data to output
		SWI 0x11		@exit
evaluate_expression:
		BEQ fmult		@if char = M(77) branch to fmult
		BPL fsub		@if char > M(77) branch to fsub
		BMI fadd		@if char < M(77) branch to fadd
		BX LR			@return
fmult:
		MOV R7,R3		@move r3 to temp for multiplication
		MUL R3,R7,R4	@multiply
		BX LR			@return
fsub:
		SUB R3,R3,R4	@subtract
		BX LR			@return
fadd:
		ADD R3,R3,R4	@add
		BX LR			@return
		
.data
arrc: .asciz "AMSAMASS"
arrn: .byte 10, 15, 20, 25, 13, 15, 28, 38, 50
eoa: