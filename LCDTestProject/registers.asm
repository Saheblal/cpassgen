

;#include "registers.inc"

    global  AX, AH, AL, BX, BH, BL, CX, CH, CL
    global  DX, DH, DL, SI, SIH, SIL, DI, DIH, DIL

GLOBAL_REGISTERS    udata_shr   ; shared bank for 8086 like registers.
AX
AL  res 1
AH  res 1
BX
BL  res 1
BH  res 1
CX
CL  res 1
CH  res 1
DX
DL  res 1
DH  res 1

SI  
SIL res 1
SIH res 1
;SIB res 2
DI  
DIL res 1
DIH res 1
;DIB res 2

;SP  res 2

    END