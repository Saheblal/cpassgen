
	ERRORLEVEL 1, -302, -207

#include <P16F877A.INC>
#include "registers.inc"

    CODE

; 16-bit CCIT CRC
; Adds WREG byte to the CRC checksum AH:AL. WREG, BL destroyed on return.
ADD_CRC                             ; B0/B1 Init: AH = HHHH hhhh, AL = LLLL llll
    GLOBAL 	ADD_CRC
;    B0toB1                          ; B0 -> B1
AddCrcB1:
    xorwf   AH, w           ; B1 Pre:  HHHH hhhh     WREG =      IIII iiii
    movwf   BL              ; B1
    movf    AL, w           ; B1 Pre:  LLLL llll     AH =      LLLL llll
    movwf   AH              ; B1
    movf    BL, w           ; B1
    movwf   AL              ; B1 Pre:  IIII iiii     AL =      IIII iiii
    swapf   AL, w           ; B1 Pre:  IIII iiii     WREG =      iiii IIII
    andlw   0x0F            ; Pre:  iiii IIII     WREG =      0000 IIII
    xorwf   AL, f           ; B1 Pre:  IIII iiii     AL =      IIII jjjj
    swapf   AL, w           ; B1 Pre:  IIII jjjj     WREG =      jjjj IIII
    andlw   0xF0            ; Pre:  jjjj IIII     WREG =      jjjj 0000
    xorwf   AH, f           ; B1 Pre:  LLLL llll     AH =      MMMM llll
    swapf   AL, f           ; B1 Pre:  IIII jjjj     WREG =      jjjj IIII
    bcf     STATUS, C       ; Bx
    rlf     AL, w           ; B1 Pre:  jjjj IIII     WREG =      jjjI IIIj
    btfsc   STATUS, C       ; Bx
    addlw   .1
    xorwf   AH, f           ; B1 Pre:  MMMM llll     AH =      XXXN mmmm
    andlw   b'11100000'     ; Pre:  jjjI IIIj     WREG =      jjj0 0000
    xorwf   AH, f           ; B1 Pre:  jjj0 0000     AH =      MMMN mmmm
    swapf   AL, f           ; B1 Pre:  IIII jjjj     WREG =      jjjj IIII
    xorwf   AL, f           ; B1 Pre:  MMMN mmmm     AL =      JJJI jjjj
    return

; ***********************************************
; Commands
; ***********************************************


    END