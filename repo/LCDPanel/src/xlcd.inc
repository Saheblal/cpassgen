
#ifndef _XLCD_INC
#define _XLCD_INC

;*******************************************************************************;
;*  This implements a generic library functionality to support 
;*  using external LCD module for PIC16 family
;*******************************************************************************;
;* FileName:            XLCD.inc	
;* Dependencies:        P16xxx.inc	
;*                      XLCD.Def	
;* Processor:           PIC16xxxx	
;* Assembler:           MPASMWIN 02.70.02 or higher
;* Linker:              MPLINK 2.33.00 or higher
;* Company:             Microchip Technology, Inc.		
;* Software License Agreement
;* The software supplied herewith by Microchip Technology Incorporated	
;* (the "Company") for its PICmicro� Microcontroller is intended and
;* supplied to you, the Company's customer, for use solely and	
;* exclusively on Microchip PICmicro Microcontroller products. The
;* software is owned by the Company and/or its supplier, and is	
;* protected under applicable copyright laws. All rights are reserved.
;* Any use in violation of the foregoing restrictions may subject the
;* user to criminal sanctions under applicable laws, as well as to
;* civil liability for the breach of the terms and conditions of this
;* license.	
;*	
;* THIS SOFTWARE IS PROVIDED IN AN "AS IS" CONDITION. NO WARRANTIES,
;* WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED
;* TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
;* PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. THE COMPANY SHALL NOT,
;* IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL OR
;* CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
;* ANY SPECIAL DESCRIPTION THAT MIGHT BE USEFUL FOR THIS FILE.
;*								
;* Author               Date            Comment	
;*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;
;*Naveen Raj            March   xx      Initial Release (V1.0)
;***********************************************************************;
						
; XLCD definition values

#define CLOCK_FREQ   .15000000
#define XLCDINTERFACE   8
#define XLCDLINE   1
#define XLCDFONT   0
#define XLCDNIBBLESEL   0
#define XLCDDATAPORT   PORTD
#define XLCDRSPORT   PORTE
#define XLCDRSPIN   0
#define XLCDENPORT   PORTE
#define XLCDENPIN   2
#define XLCDRWPORT  PORTE
#define XLCDRWPIN   1
#define XLCDBLOCKING    1
#define XLCDMODE    1
;#define XLCDDELAY    .20
#define XLCDDELAY 	.250
#define XLCDDISPLAYON   1
#define XLCDCURSORON   1
#define XLCDBLINKON   1
#define XLCDENTRYID   1
#define XLCDENTRYSHIFT   0

    #ifndef	XLCD_Source
    #include "P16xxx.inc"
;    #include "P18xxx.inc"
    
    ;private					
    EXTERN  XLCDInit
    EXTERN  XLCDCommand
    EXTERN  XLCDPut
    EXTERN  XLCDCommandInit4bit
    EXTERN  XLCDL1home
    EXTERN  XLCDL2home
    EXTERN  XLCDClear
    EXTERN  XLCDReturnHome
    EXTERN  XLCDSendMsg
    EXTERN  XLCDSendMsgRAM
    EXTERN  XLCDSetCursorPos
    
    EXTERN  XLCDDelay5ms
    EXTERN  XLCDDelay100us
	EXTERN	_vXLCDreg4
    
    #if XLCDMODE == 1
    EXTERN  XLCDDelay
    #endif

    #if XLCDRWPIN !=10
    EXTERN  XLCDIsBusy
    EXTERN  XLCDReadData
    #endif
    
    
     
    #else
    ;global

    GLOBAL  XLCDInit                    ;initialize LCD
    GLOBAL  XLCDCommand                 ;instruction command
    GLOBAL  XLCDPut	                    ;put content into LCD
    GLOBAL  XLCDDelay5ms
    GLOBAL  XLCDDelay100us
    GLOBAL  XLCDCommandInit4bit         ;function used only in 4 bit init by instruction
    GLOBAL  XLCDL1home                  ;Sets DDRam address to first line
    GLOBAL  XLCDL2home                  ;Sets DDRam address to second line
    GLOBAL  XLCDClear                   ;Clears DDram content and points to address 00
    GLOBAL  XLCDReturnHome              ;Sets DDRAM address 0 DDramConent remain unchanged
    GLOBAL  XLCDSendMsg
    GLOBAL  XLCDSetCursorPos
	GLOBAL	_vXLCDreg4    
    
    #if XLCDMODE == 1
    GLOBAL  XLCDDelay                   ;delay to becalled after every instruction Command
    #endif
    
    #if XLCDRWPIN !=10                  ;if RW grounded
    GLOBAL  XLCDIsBusy                  ;reads the busy flag
    GLOBAL  XLCDReadData                ;readdata from DDRAM
    #endif
    
    
     
	#endif

	
    #ifdef  _PIC16xxx


;***********************************************************************
; MACRO: mXLCDSendMsgRAM
; PreCondition: System initialized
; Overview: This macro sets the pointers to start reading a table
; Input:
; Output:
; Side Effects:
; Stack requirement: X level deep
;***********************************************************************

mXLCDSendMsgRAM    macro   MsgPtr
	bcf	INTCON, GIE
		movlw	MsgPtr
        pagesel XLCDSendMsgRAM
        call    XLCDSendMsgRAM             ;call the function
	bsf	INTCON, GIE
        endm


;***********************************************************************
; MACRO: mXLCDSendMsg
; PreCondition: System initialized
; Overview: This macro sets the pointers to start reading a table
; Input:
; Output:
; Side Effects:
; Stack requirement: X level deep
;***********************************************************************

mXLCDSendMsg    macro   MsgPtr
	bcf	INTCON, GIE
        movlw   HIGH (MsgPtr)           ;points to the table
        banksel EEADRH
        movwf   EEADRH
        movlw   LOW (MsgPtr)
        movwf   EEADR
        pagesel XLCDSendMsg
        call    XLCDSendMsg             ;call the function
	bsf	INTCON, GIE
        endm

	#endif
    #ifdef  _PIC18xxx
;***********************************************************************
; MACRO: mXLCDSendMsg
; PreCondition: System initialized
; Overview: This macro sets the pointers to start reading a table
; Input:
; Output:
; Side Effects:
; Stack requirement: X level deep
;***********************************************************************
mXLCDSendMsg    macro   MsgPtr
        movlw   UPPER (MsgPtr)           ;points to the table
        movwf   TBLPTRU
        movlw   HIGH (MsgPtr)           
        movwf   TBLPTRH
        movlw   LOW (MsgPtr)           
        movwf   TBLPTRL
        call    XLCDSendMsg             
        endm

    #endif
;*********************************************************************

#endif