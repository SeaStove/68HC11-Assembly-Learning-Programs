**************************************
*
* Name: Robert Stovall
* ID: 12360729	
* Date: 02/21/2015
* Lab2
*
* Program description: Multiple two numbers,
*   NUM1 and NUM2, by adding NUM1 to itsself 
* Pseudocode:
* 	int NUM1,NUM2,COUNT;
*	long RESULT,TEMP;
*	
*	WHILE (COUNT<NUM2) {
*	    RESULT=NUM1+RESULT;
*	    COUNT++;
*	} 
*	
*	
*
**************************************

* start of data section

	ORG $B000
NUM1	FCB	81
NUM2	FCB	24

	ORG $B010
RESULT	RMB	2
COUNT	RMB	1
TEMP	RMB	2

* define any other variables that you might need here


	ORG $C000
* start of your program

* Initialize variables
	CLR	RESULT
* clear the second bit of result
	CLR	$B011
	CLR	COUNT
	CLR	TEMP
	LDAA	NUM1
*Store NUM1 into the second bit of temp
	STAA	$B014

* while (count<NUM2)
	LDAA 	COUNT
WHILE	CMPA	NUM2
	BHS	ENDWHILE

* RESULT = NUM1 + RESULT;
	LDAD	RESULT
	ADDD	TEMP
	STAD	RESULT

*COUNT++	
	LDAA	COUNT
	INCA
	STAA	COUNT
	
*End loop
	BRA	WHILE
ENDWHILE	END

*End
DONE	BRA	DONE

	