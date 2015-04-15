**************************************
*
* Name:Robert Stovall 
* ID:12360729
* Date: 03/03/15
* Lab3
*
* Program description:simulate an assembly language program which will
* calculate the factorial N! of a number N. 
*
* Pseudocode: 
*  
* unsigned int N=8; (1 byte)
* unsigned int NFAC=1;(2byte)
* unsigned int count=1;(1byte)
* unsigned int i;(1byte)
* unsigned int temp;(2byte)
*
* if(n=0)
*	nfac=1; 
*
* while(count<=n){
*	i=count-1;
*	temp=nfac;
*	while(i!=0){
*		nfac=nfac+temp;
*		i--;
*	}
*	count++;
* }
*
**************************************

* start of data section

	ORG $B000
N 	FCB 	8


	ORG $B010
NFAC 	RMB 	2
* define any other variables that you might need here
COUNT 	RMB 	1
I	RMB	1
TEMP	RMB	2
	
	ORG $C000
* start of your programs

* unsigned int N=8; (1 byte)
*	LDAA	#100
*	STAA	N
* unsigned int NFAC=1;(2byte)
	LDD	#1
	STD	NFAC
* unsigned int count=1;(1byte)
	LDAA	#1
	STAA	COUNT
* unsigned int i;(1byte)
	CLR	I
* unsigned int temp;(2byte)
	CLR	TEMP
	CLR	TEMP+1






* if(n=0)
IF 	LDAB	N 			
	CMPB	#0 			
	BNE	ENDIF
* nfac=1;
THEN	LDAA	#1
	STAA	NFAC+1
ENDIF
 


* while(count<=n){
WHILE1	CMPA	N
	BHI	ENDWHL1

* i=count-1;
	LDAA	COUNT
	STAA	I
	DEC	I

* temp=nfac;
	LDD	NFAC
	STD	TEMP

* while(i!=0){
WHILE2	TST	I
	BEQ	ENDWHL2

* nfac=nfac+temp;
	LDD	NFAC
	ADDD	TEMP
	STD	NFAC

* i--;
	DEC	I

* }
	BRA	WHILE2
ENDWHL2	STD	NFAC

* count++;
	INC	COUNT

* }
	LDAA	COUNT
	BRA	WHILE1

ENDWHL1	
DONE	BRA	DONE
	END
