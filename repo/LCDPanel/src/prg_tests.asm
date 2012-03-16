
#include <P16F877A.INC>
#include "registers.inc"
#include "maths.inc"

    CODE

; prg_checksum checksum for prg bytes start program word in BX register,
; words count in CX register. return DX register in checksum word.

prg_checksum

    GLOBAL  prg_checksum

        BANKSEL EECON1
        bsf     EECON1,EEPGD	; select program memory

next_word
    banksel EEADRH
        movfw   BH
        movwf   EEADRH
        movfw   BL
        movwf   EEADR       ; mov start address onto EEADRH:EEADR register


        call    GetEEWord   ; get EEADRH:EEADR word in AX
        call    ADDDXAX

        INCW    BX          ; next memory word address
        DECW    CX          ; decrement loop counter

        btfss   STATUS, Z   ;
        goto    next_word
        return

;        ADDW    DX, AX          ;

; GetEEDATChar: in AX return the EEADRH, EEADR address character

GetEEWord

        BANKSEL EECON1
        bsf     EECON1, RD		; select read program memory
        nop
        nop
        BANKSEL	EEDATH
        movfw   EEDATH
        movwf	AH
        movfw   EEDATA
        movwf   AL
        return

; ******************************** PRG_EEM_TEST *****************************
; test program memory crc sum CL: program size of 0xFF bytes AH:AL CRC sum **


GetNextBlock
        banksel EEADR       ; select program address of 0x0000
        movfw   BL
        movwf   EEADR
;        clrf    EEADR
GetNextChar
;        call    ADD_CRC     ; CRC calculate of lower and higher program byte
        BANKSEL EEADR
        incfsz  EEADR       ; one block (0xFF bytes) tested ?
        goto    GetNextChar ; next char CRC check
        incf    EEADRH      ; get next block
        decfsz  CL          ; decrement block counter
        goto    GetNextBlock    ; goto next block

        return  ; now return
;inf_loop
;        goto    inf_loop

	btfss	STATUS, Z
	goto	GetNextChar

;	banksel	CHECKSUM
	movlw	B'00111111'
;	andwf	CHECKSUM + 1, F

	movlw	0xFE
;	call	Get_EEPROM_Byte
;	banksel	CHECKSUM
;	subwf	CHECKSUM
	btfss	STATUS, Z
	goto	EEPROM_CHK_ERROR

	movlw	0xFF
;	call	Get_EEPROM_Byte
;	banksel	CHECKSUM
;	subwf	CHECKSUM + 1
	btfss	STATUS, Z
	goto	EEPROM_CHK_ERROR


	bcf		STATUS, C
	return

EEPROM_CHK_ERROR
	bcf		STATUS, C
	return



    END
