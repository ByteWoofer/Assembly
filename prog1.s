@Program: Who_is_the_biggest
@Author: Chris Gendreau
@Purpose: Compare three values from memory
@Date: 9/30/2016

	.global _start
main:
	.text
	LDR R0, =NA  @load address of nA
	LDR R0, [R0] @load value of nA
	LDR R1, =NB  @load address of nB
	LDR R1, [R1] @load value of nB
	LDR R2, =NC  @load address of nC
	LDR R2, [R2] @load value of nC

	SUBS R3, R0, R1 @find difference between nA and nB -> R3 & set flags
	BMI b           @branch to part B if negative flag set
	SUBS R0, R0, R2 @find difference between nA and nC -> R0 & set flags
	BMI c		@branch to part C if negative flag set
	LDR R1, =MA    @load address to message A is largest
	B done		@branch to display
b:
	SUBS R0, R1, R2 @find difference between nB and nC -> R0 & set flags
	BMI c		@branch to part C if negative flag set
	LDR R1, =MB    @load address to message B is largest
	B done		@branch to display
c:
	LDR R1, =MC    @load address to message C is largest
done:	
	MOV R0, #1 @set output file to stdout
	MOV R2, #16 @set bytes to output to 16
	SWI 0x69	@print to stdout
	SWI 0x11	@terminate

	.data
NA:	.word 12  	@value A
NB:	.word 250	@value B
NC:	.word 100	@value C
MA:	.asciz "A > B and A > C\n" @Message A
MB:	.asciz "B > A and B > C\n" @Message B
MC:	.asciz "C > A and C > B\n" @Message C
