

	ERRORLEVEL 1, -302, -207

#include <P16F877A.INC>
#include "registers.inc"

#define NUM_LETTER_DISTANCE 7

	CODE

WORD_TO_BCD  			; ; Input data (WORD): AX , Output [FSR] + 6 byte nibbles
	GLOBAL	WORD_TO_BCD
	bcf     STATUS,0                ; clear the carry bit
	movlw   .16
	movwf   CL
	
	clrf	INDF			; R0, R1, R2
	incf	FSR, F
	clrf	INDF
	incf	FSR, F
	clrf	INDF

	movfw	FSR
	movwf	BH				; BH = FSR + 2
return_000
loop16
	movfw	BH		
	movwf	FSR				; FSR = BH
	rlf     AL, F
	rlf     AH, F
	
	rlf     INDF, F
	decf	FSR
	rlf     INDF, F
	decf	FSR
	rlf     INDF, F
;
	decfsz  CL, F
	goto    adjDEC_00
	RETLW   0
;
adjDEC_00
	movfw	BH
	movwf	FSR	
	call    adjBCD_01

	decf	FSR, F
	call    adjBCD_01

	decf	FSR, F
	call    adjBCD_01

	goto    loop16
	return


INT_TO_BCD		; Input data (integer): AX , Output [FSR] + 6 byte nibbles
	GLOBAL	INT_TO_BCD
	clrf	CH
	bcf     STATUS,0                ; clear the carry bit
	movlw   .16
	movwf   CL
	
	clrf	INDF			; R0, R1, R2
	incf	FSR, F
	clrf	INDF
	incf	FSR, F
	clrf	INDF

	movfw	FSR
	movwf	BH				; BH = FSR + 2
	btfsc	AH, 0x07
	goto	neg_data
return_001
loop17
	movfw	BH		
	movwf	FSR				; FSR = BH
	rlf     AL, F
	rlf     AH, F
	
	rlf     INDF, F
	decf	FSR
	rlf     INDF, F
	decf	FSR
	rlf     INDF, F
;
	decfsz  CL, F
	goto    adjDEC_01

	btfsc	CH, 0
	bsf		INDF, 0x07

	return
;
adjDEC_01
	movfw	BH
	movwf	FSR	
	call    adjBCD_01

	decf	FSR, F
	call    adjBCD_01

	decf	FSR, F
	call    adjBCD_01

	goto    loop17

adjBCD_01
	movlw   3
	addwf   INDF,W
	movwf   BL
	btfsc   BL,3          ; test if result > 7
	movwf   INDF
	movlw   30
	addwf   INDF,W
	movwf   BL
	btfsc   BL,7          ; test if result > 7
	movwf   INDF         	; save as MSD
	return

neg_data
	
	NEGW	AX	
	bsf		CH, 0
	goto	return_001

; Substraction function AX = AX + (- BX)

SUBAXBX	
	GLOBAL	SUBAXBX
	NEGW	BX	

; Addition function AX = AX + BX

ADDAXBX	; AX + BX = AX
	GLOBAL	ADDAXBX
	movf    BX, W
	addwf   AX, F       	;add lsb
	btfsc   STATUS,C        ;add in carry
	incf    AX + 1, F
	movf    BX + 1, W
	addwf   AX + 1, F   	;add msb
	return

; Negate word of FSR addressed register [FSR] = -[FSR]
	
NEGATE_WORD
	GLOBAL 	NEGATE_WORD
	movwf	FSR					; negate ACCW ( -ACCW -> ACCW )
	comf	INDF, F	
	incf	INDF, F
	movfw	STATUS
	incf	FSR, F
	movwf	STATUS
	btfsc	STATUS, Z
	decf	INDF, F
	comf	INDF, F
	decf	FSR, F
	movfw	FSR
	return
;


PRINT_BCD	; [SI]: BCD number MSB (3 bytes), [DI]: OUTBUFFER (6 bytes + 1 zero byte)
	GLOBAL	PRINT_BCD

	MOVFSR	SI

	btfsc	INDF, 0x07	; negative?
	goto	negative

jump_003
	movlw	3
	movwf	CL
	goto	print_low_nibble

print_loop

	MOVFSR	SI

	movfw	INDF
	movwf	BL
	swapf	BL, F	; get high nibble byte, of BCD number
	movlw	0x0F
	andwf	BL, F
	movlw	'0'
	addwf	BL, F

	MOVFSR	DI		;

	movfw	BL
	movwf	INDF	; store high nibble character
	incf	DI, F

print_low_nibble

	MOVFSR	SI		;

	movfw	INDF
	movwf	BL
	movlw	0x0F
	andwf	BL, F
	movlw	'0'
	addwf	BL, F

	MOVFSR	DI
	movfw	BL
	movwf	INDF
	
	incf	DI, F
	incf	SI, F
	decfsz	CL
	goto	print_loop

	incf	FSR, F
	movlw	0
	movwf	INDF

	return

negative

	MOVFSR	DI
	movlw	'-'
	movwf	INDF
	incf	DI, F
	goto	jump_003

PRINT_BIN	; Inputs WREG input byte, FSR OUTBUFFER (8 bytes + 1 zero byte)
	GLOBAL	PRINT_BIN

	movwf	AH
	movlw	0x08
	movwf	CL
	
next_bit

	movlw	'0'
	rlf	AH, F
	btfsc	STATUS, C
	movlw	'1'
	movwf	INDF
	incf	FSR, F		

	decfsz	CL
	goto	next_bit

	movlw	0
	movwf	INDF

	return

PRINT_HEX	; Inputs WREG input byte, FSR OUTBUFFER (2 bytes + 1 zero byte)
	GLOBAL	PRINT_HEX

	movwf	AH
        call    GET_HEX_CHAR
	incf	FSR, F
	movwf	INDF
	rrf	AH, F
	rrf	AH, F
	rrf	AH, F
	rrf	AH, F
        call    GET_HEX_CHAR
	decf	FSR, F
	movwf	INDF
	incf	FSR, F
	incf	FSR, F
	movlw	0
	movwf	INDF

	return

GET_HEX_CHAR            ; get hexa char code for wreg
	movlw	0x0F
	andwf	AH, W
        addlw   -9
        btfsc   STATUS, C
        addlw   NUM_LETTER_DISTANCE
	addlw	'0'
        addlw   9
        return

	END



;*******************************************************************
;                       Double Precision Multiplication
;
;               ( Optimized for Code : Looped Code )
;
;   Multiplication : ACCb(16 bits) * ACCa(16 bits) -> ACCd,ACCc ( 32 bits )
;      (a) Load the 1st operand in location ACCaLO & ACCaHI ( 16 bits )
;      (b) Load the 2nd operand in location ACCbLO & ACCbHI ( 16 bits )
;      (c) CALL D_mpyS
;      (d) The 32 bit result is in location ( ACCdHI,ACCdLO,ACCdHI,ACCdLO )
;
;   Performance :
;            Program Memory  :   21 (UNSIGNED)
;                                52 (SIGNED)
;            Clock Cycles    :   242 (UNSIGNED :excluding CALL & RETURN)
;                            :   254 (SIGNED :excluding CALL & RETURN)
;            Scratch RAM     :   1 (used only if SIGNED arithmetic)
;
;       Note : The above timing is the worst case timing, when the
;               register ACCb = FFFF. The speed may be improved if
;               the register ACCb contains a number ( out of the two
;               numbers ) with less number of 1s.
;
;               Double Precision Multiply ( 16x16 -> 32 )
;         ( ACCb*ACCa -> ACCb,ACCc ) : 32 bit output with high word
;  in ACCd ( ACCdHI,ACCdLO ) and low word in ACCc ( ACCcHI,ACCcLO ).
;********************************************************************
;
MULAXBX                	;MUL AX, BX result = CX, DX
;

     #if   SIGNED
	CALL    S_SIGN
     #endif
;
	clrf     count, F
	bsf     count,4         ; set count = 16
;
  #if MODE_FAST
	movpf    ACCbLO,tempLo
	movpf    ACCbHI,tempHi
  #else
	movfp    ACCbLO,WREG
	movwf     tempLo
	movfp    ACCbHI,WREG
	movwf     tempHi
  #endif
	clrf     ACCdHI, F
	clrf     ACCdLO, F
;
; shift right and addwf 16 times
;
mpyLoop
	rrcf     tempHi, F
	rrcf     tempLo, F
	btfss      ALUSTA,C
	goto    NoAdd                   ; LSB is 0, so no need to addwf
	movfp    ACCaLO,WREG
	addwf     ACCdLO, F             ;addwf lsb
	movfp    ACCaHI,WREG
	addwfc    ACCdHI, F           ;addwf msb
NoAdd
	rrcf     ACCdHI, F
	rrcf     ACCdLO, F
	rrcf     ACCcHI, F
	rrcf     ACCcLO, F
	decfsz     count, F
	goto    mpyLoop
;
    #if SIGNED
	btfss      sign,MSB
	return
	comf    ACCcLO, F
	incf     ACCcLO, F
	btfsc      ALUSTA,Z
	decf     ACCcHI, F
	comf    ACCcHI, F
	btfsc      ALUSTA,Z
	decf     ACCdLO, F
	comf    ACCdLO, F
	btfsc      ALUSTA,Z
	decf     ACCdHI, F
	comf    ACCdHI, F
	return
    #else
	return
    #endif
;
;  Assemble this section only if Signed Arithmetic Needed
;
     #if    SIGNED
;
S_SIGN
	movfp    ACCaHI,WREG
	xorwf     ACCbHI,W
	movwf     sign              ; MSB of sign determines whether signed
	btfss      ACCbHI,MSB        ; if MSB set go & negate ACCb
	goto    chek_A
	comf    ACCbLO, F
	incf     ACCbLO, F
	btfsc      ALUSTA,Z                ; negate ACCb
	decf     ACCbHI, F
	comf    ACCbHI, F
;
chek_A
	btfss      ACCaHI,MSB        ; if MSB set go & negate ACCa
	return
	comf    ACCaLO, F
	incf     ACCaLO, F
	btfsc      ALUSTA,Z                ; negate ACCa
	decf     ACCaHI, F
	comf    ACCaHI, F
	return
;
     #endif



