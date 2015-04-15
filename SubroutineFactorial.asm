**************************************
*
* Name: Robert Stovall
* ID: 12360729
* Date: 04/06/2015
* Lab4
*
* Program description: Calculate the factorial of each number in an array,
*	and store the resulting numbers in an array called NFAC. The factorial calculation
*	is done in a subroutine, and the result is returned back to the main program to be stored.
*
* Pseudocode of Main Program: 
*	
*	int N[] = 0,1,2,3,4,5,6,7,8,$FF (ten byte)
*	int NFAC[] (18byte)
*	int sentin = $FF (1 byte)
*	int factor (2byte)
*	int subcount (1byte)
*	int temp (2byte)
*	int i (1byte)
*
*	initialize POINTER1
*	initialize POINTER2
*	while(POINTER1->ITEM!=$FF){
*		POINTER2->ITEM=FACT(POINTER1->ITEM)
*		POINTER1++
*		POINTER2++
*		POINTER2++
*	}
*
* Pseudocode of Subroutine:
*	
*	FACT(POINTER1->ITEM){
*		RET=POINTER2
*		PULL RETURN ADDRESS
*		NUM=POINTER1->ITEM
*		SUBCOUNT=1
*		TEMP=1
*		FACTOR=1
*		IF(NUM=0){
*			FACTOR=0
*		}
*		WHILE(SUBCOUNT<=NUM){
*			I=SUBCOUNT-1
*			TEMP=FACTOR
*			WHILE(I!=0){
*				FACTOR=TEMP+FACTOR
*				I--
*			}
*			SUBCOUNT++
*		}
*		RETURN(FACTOR)
*	}
*
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

	LDX	#N	initialize POINTER1
	LDY	#NFAC	initialize POINTER2
WHILE	LDAB	0,X	while(pointer1->item!=$FF)
	CMPB	#$FF
	BEQ	ENDWHILE	
* POINTER2->ITEM=FACT(POINTER1->ITEM)
	JSR	SUB	
	PULA
	PULB
	STD	0,Y
	INX		POINTER1++
	INY		POINTER2++
	INY		POINTER2++
	BRA	WHILE
ENDWHILE
DONE	BRA	DONE
	END


* define any variables that your SUBROUTINE might need here
SUBCOUNT	RMB	1
TEMP	RMB	2
FACTOR	RMB	2
RET	RMB	2	
I	RMB	1
NUM	RMB	1


	ORG $D000
* start of your subroutine
*FACT(pointer1->item)
SUB			
	STY	RET	RET=pointer2	
	PULY		PULL RETURN ADRESS
	STAB	NUM	NUM=pointer1->item	
	LDD 	#1	
	STAB 	SUBCOUNT	SUBCOUNT=1
	STD	TEMP	TEMP=1
	STD	FACTOR	FACTOR=1
	LDAB	NUM	
IF	CMPB	#0	IF(NUM=0)
	BNE	ENDIF
THEN	LDD	#0
	STD	FACTOR	FACTOR=0
ENDIF	
WHILE1	LDAB	SUBCOUNT	
	CMPB	NUM	WHILE(SUBCOUNT<=NUM)
	BHI	ENDWHL1
	LDAB	SUBCOUNT	I=SUBCOUNT-1
	STAB	I
	DEC	I
	LDD	FACTOR	
	STD	TEMP	TEMP=FACTOR
WHILE2	TST	I	WHILE(I!=0)
	BEQ	ENDWHL2
	LDD	FACTOR	FACTOR=TEMP+FACTOR
	ADDD	TEMP
	STD	FACTOR
	DEC	I	I--
	BRA	WHILE2
ENDWHL2	INC	SUBCOUNT	SUBCOUNT++
	BRA	WHILE1
ENDWHL1			
	LDD	FACTOR	RETURN(FACTOR)
	PSHB		PUSH LOW BYTE
	PSHA		PUSH HIGH BYTE
	PSHY		PUSH RETURN ADDRESS
	LDY	RET	RELOAD Y REGISTER
	RTS
