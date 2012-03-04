
#ifndef __MATHS_INC           ;Check if inc file already included
#define __MATHS_INC


MOVLWACCWA	macro	WORDDATA
	banksel	ACCWA
	movlw	LOW(WORDDATA)
	movwf	ACCWA
	movlw	HIGH(WORDDATA)
	movwf	ACCWA + 1
			endm

MOVLWACCWB	macro	WORDDATA
	banksel	ACCWB
	movlw	LOW(WORDDATA)
	movwf	ACCWB
	movlw	HIGH(WORDDATA)
	movwf	ACCWB + 1
			endm


	EXTERN	NEGATE_WORD
	EXTERN	ADDAXBX
	EXTERN	SUBAXBX
	EXTERN	WORD_TO_BCD
	EXTERN	INT_TO_BCD
	EXTERN	PRINT_BCD
	EXTERN	PRINT_BIN
	EXTERN	PRINT_HEX


#endif
