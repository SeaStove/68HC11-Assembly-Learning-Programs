**************************************
* Program description: Calculate the factorial of each number in an array,
*	and store the resulting numbers in an array called NFAC. The factorial calculation
*	is done in a subroutine, and the result is returned back to the main program to be stored.
*	This program is transparent.
*
* Pseudocode of Main Program:
*
* int N[]
* int NFAC[]
*
* pointer1=&N[0]
* pointer2=&NFAC[0]
* while (pointer1->item != sentinel){
*	A-register=pointer1->item
*	call subroutine
*	get 2-byte factorial off the stack
*	store it to memory where pointer2 is pointing to
*	pointer1++
*	pointer2++
*	pointer2++
* }
* END
*
*
*---------------------------------------
*	
*
* Pseudocode Subroutine
*
* make slot for return address
* push registers onto stack
* make variable holes on stack
* point X register to top of stack
* i=data sent to subroutine;
* FC=1;
* while(i!=0){
*	j=i;
*	sum=0;
*	while(j!=0){
*		sum=FC+sum;
*		j--;
*	}
*	FC=sum;
*	i--;
* }
* move return address up two bytes
* close variable holes
* store return variable in bottom two bytes
* pull registers
* return to main program
*
*
**************************************


* start of data section

	ORG $B000
N	FCB	0, 1, 2, 3, 4, 5, 6, 7, 8, $FF
SENTIN	EQU	$FF

	ORG $B010
NFAC	RMB	18


* define any variables that your MAIN program might need here
* REMEMBER: Your subroutine must not access any of the main
* program variables including N and NFAC.
	ORG $C000
	LDS	#$01FF		initialize stack pointer
* start of your main program
	LDX	#N		initialize pointer1
	LDY	#NFAC		initialize pointer2
WHILE1	LDAB	0,X		get N item
	CMPB	#SENTIN		compare to sentinel
	BEQ	ENDWHL1		if sentinel, done
	JSR	FACT		jump to subroutine
	PULA			get high result byte off the stack
	PULB			get low result byte off the stack
	STD	0,Y		pointer2->item = result bytes
	INY			pointer2++
	INY			pointer2++
	INX			pointer1++
	BRA	WHILE1
ENDWHL1				END
DONE	BRA	DONE


* define any variables that your SUBROUTINE might need here

	ORG $D000
* start of your subroutine
FACT	DES		MAKE SLOT FOR RET
	DES
	PSHX		push registers onto stack
	PSHY	
	PSHA
	TPA
	PSHA
	PSHB
	DES		FC
	DES		FC+1	
	DES		I
	DES		J
	TSX		point x to the top of the stack
	STAB	1,X	STORE A IN I
	LDD	#1
	STD	2,X	STORE 1 IN TEMP
WHILE2	TST	1,X	TEST I
	BEQ	ENDWH2	while(i!=0){
	LDAA	1,X	INITIALIZE J VARIABLE TO I
	STAA	0,X	J=I
	LDD	#0	sum=0
WHILE3	TST	0,X
	BEQ	ENDWH3
	ADDD	2,X	sum=fc+sum	
	DEC	0,X	j--
	BRA	WHILE3
ENDWH3	STD	2,X	sum = fc
	DEC	1,X	i--
	BRA	WHILE2
ENDWH2	LDY	13,X	move return address up
	STY	11,X
	LDD	2,X	store return variable in last two bytes
	STD	13,X
	INS		close variable holes
	INS
	INS
	INS
	PULB		pull registers
	PULA
	TAP
	PULA
	PULY
	PULX
	RTS