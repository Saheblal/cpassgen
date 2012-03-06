
#ifndef __REGISTERS_INC           ;Check if inc file already included
#define __REGISTERS_INC

	ERRORLEVEL 1, -207

    EXTERN AX, AL, AH, CX, CH, CL, BX, BH, BL, SI, SIH, SIL, DI, DIH, DIL
    EXTERN DX, DH, DL

MOVFSR	macro	REGISTER
	movfw	REGISTER
	movwf	FSR
	endm

RAMPAGE	macro	PAGENUM
	bcf		STATUS, IRP
	movlw	PAGENUM
	iorlw	0x00
	btfss	STATUS, Z
	bsf		STATUS, IRP
			endm

MOVWLW	macro	REGISTER, CONSTDATA
	movlw	LOW(CONSTDATA)
	movwf	REGISTER
	movlw	HIGH(CONSTDATA)
	movwf	REGISTER + 1
			endm

MOVW	macro	DEST_REGISTER, SOURCE_REGISTER
	movfw	SOURCE_REGISTER
	movwf	DEST_REGISTER
	movfw	SOURCE_REGISTER + 1
	movwf 	DEST_REGISTER + 1
			endm

STOSW	macro	REGISTER
	movfw	DI
	movwf	FSR
	movfw	REGISTER
	movwf	INDF
	incf	FSR, F
	movfw	REGISTER + 1
	movwf	INDF
			endm

LODSW	macro	REGISTER
	movfw	SI
	movwf	FSR
	movfw	INDF
	movwf	REGISTER
	incf	FSR, F
	movfw	INDF
	movwf	REGISTER + 1
			endm

DECW	macro	REGISTER
	movlw	0x01
	subwf	REGISTER, F
	btfss	STATUS, C
	decf	REGISTER + 1
			endm

INCW	macro	REGISTER
	incf	REGISTER
	btfsc	STATUS, Z
	incf	REGISTER + 1
			endm

ISNULLW	macro	REGISTER
	movfw	REGISTER
	iorwf	REGISTER + 1, W
			endm

NEGW	macro	REGISTER
	movlw	REGISTER
	call	NEGATE_WORD
			endm

ADDW	macro	REG1RESULT, REG2	; REG1RESULT = REG1RESULT + REG2
	MOVW	AX, REG1RESULT
	MOVW	BX, REG2
	call	ADDAXBX
	MOVW	REG1RESULT, AX
			endm

SUBW	macro	REG1RESULT, REG2	; REG1RESULT = REG1RESULT - REG2
	MOVW	AX, REG1RESULT
	MOVW	BX, REG2
	call	SUBAXBX
	MOVW	REG1RESULT, AX
			endm

BYTETOBCD       macro   REG, DEST
        clrf    AH
        movfw   REG
        movwf   AL
        movlw   DEST
        movwf   FSR
        call    WORD_TO_BCD
                endm

INTTOBCD	macro	REG, DEST
	MOVW	AX, REG
	movlw	DEST
	movwf	FSR
	call	INT_TO_BCD
				endm

WORDTOBCD	macro	REG, DEST
	MOVW	AX, REG
	movlw	DEST
	movwf	FSR
	call	WORD_TO_BCD
				endm

PRINTBCD	macro	IN, OUT
	movlw	IN
	movwf	SI
	movlw	OUT
	movwf	DI
	call	PRINT_BCD
				endm

PRINTBIN	macro	REG, OUTBUF
	movlw	OUTBUF
	movwf	FSR
	movfw	REG
	call	PRINT_BIN
				endm

PRINTHEX	macro	REG, OUTBUF
	movlw	OUTBUF
	movwf	FSR
	movfw	REG
	call	PRINT_HEX
				endm


#endif
