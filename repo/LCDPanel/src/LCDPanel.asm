
	ERRORLEVEL 1, -302

#include <P16F877A.INC>
	__config (_WDT_OFF & _PWRTE_OFF & _LVP_OFF & _HS_OSC & _CP_OFF)

    __idlocs 15F0

#include    "xlcd.inc"
#include    "uart.inc"
#include    "maths.inc"
#include    "registers.inc"
#include    "prg_tests.inc"

;#define BOOTLOADER

DEEPROM	CODE
	de	"v. 1.00", 0
BAUD_DIV_TABLE
	de	.196, .96, .50, .29, .17, .9
BAUD_CODE
	de	.1

;	idata	0x070
;RAM_COUNTER res 1;
;TEST_DATA   res 1;
;BANK_COUNTER    res 2;
;	endc

PAGE_0_DATAS	idata   0x20
Delay1		res	1; Define two file registers for the
Delay2		res	1; delay loop
Delay3		res	1;
Buttons_old	res	1;
Buttons		res	1;
PORTD_BUF	res	1;
TRISD_BUF	res	1;
MENU_LEVEL      res     1;  menu level (0-2)
; *****************************************************************************
;CRCL            res 1;    equ 0xA0        ; GPR RAM in bank 1
;CRCH            res 1;   0xA1

CHECKSUM	dw	0
;ACCW0		dw	0
;ACCW1		dw	0
;ACCW2		dw	0
;ACCW3		dw	0
;ACCaLO		res	2
;ACCaHI		res	1
;ACCbLO		res	1
;ACCbHI		res	1
OUTBUF		res     10
PRINTBUF        res     10

#define	BUTTON_UP	3
#define BUTTON_DOWN	2
#define BUTTON_ENTER	0
#define BUTTON_EXIT	7
#define BUTTON_MENU	6
#define BUTTON_START_STOP	5
#define TEST_POS        0x045
#define MAX_MENU_LEVEL  3   ; max. menu level

#define ADCON1_ALLDIGITALS	0x06	; all  pin's AN7=D, AN6=D, AN5=D, AN4=D, AN3=D, AN2=D, AN1=D, AN0=D 


STARTUP	CODE

#ifndef BOOTLOADER
        ORG     0x0000
        dw  0x3FFF, 0x3FFF, 0x3FFF
#endif

	ORG	0x0003

	goto	Cold_Start	

	ORG	0x0004		;place code at interrupt vector
	goto	InterruptCode

PROG1	CODE


;Cold_Start

;        MOVWLW  CL, 0x3F        ; tested program lenght in 0x0FF bytes block's
;        call    PRG_EEM_TEST

;        MOVWLW  AX, .15423
;        WORDTOBCD   AX, OUTBUF
;        PRINTBCD    OUTBUF, PRINTBUF
;        movlw   0x0FE
;        movwf   Buttons
;        PRINTHEX    Buttons, OUTBUF


                                ; ColdStart
	call 	PORTS_INIT      ;Initialization I/O ports
        clrf    MENU_LEVEL      ;main menu (level 0)
;        decf    MENU_LEVEL
;        PRINTHEX    MENU_LEVEL, OUTBUF

Start_Tests				; Start tests programs

	call	XLCDClear	
	mXLCDSendMsg CRANKMET   ; welcome test to LCD
;	call	XLCDL2home
;	mXLCDSendMsg INIT_PROGRAM

Init_Program			; program initialisation

	call	XLCDL2home
;	mXLCDSendMsg	TEST_MSG


	mXLCDSendMsg	PRG_EEM

Cold_Start

        MOVWLW  CX, 0x05D7      ; tested program lenght
;        MOVWLW  CX, 0x0008      ; tested program lenght

#ifdef  BOOTLOADER              ; if defined BOOTLOADER, the firsr 3 bytes contain
                                ; the jump code
        MOVWLW  DX, 0x5EF3      ; mov checksum those first 3 bytes
        MOVWLW  BX, 0x0000      ; set start address
#else
        CLRWREG DX
        CLRWREG BX
#endif
        call    prg_checksum
;       call	PRG_EEM_TEST	; test program EEPROM memory

        PRINTHEX    AH, OUTBUF
        mXLCDSendMsgRAM OUTBUF
        PRINTHEX    AL, OUTBUF
        mXLCDSendMsgRAM OUTBUF

inf_loop
        goto    inf_loop

	btfsc	STATUS, C
	goto	PRG_EEM_ERROR	; goto error 

	call	DELAY500
	call	PUT_OK_MSG
	call	DELAY500

	movlw	TEST_POS
	call	XLCDSetCursorPos
	mXLCDSendMsg	PDT_RAM

;	call	PDT_RAM_TEST		; pogram data RAM test
;	btfsc	STATUS, C
;	goto	PDT_RAM_ERROR		; goto error


	call	DELAY500
	call	PUT_OK_MSG
	call	DELAY500

	movlw	TEST_POS
	call	XLCDSetCursorPos
	mXLCDSendMsg	DATA_EEM
;	call	DATA_EEM_TEST		; pogram data EEPROM test
;	btfsc	STATUS, C
;	goto	DATA_EEM_ERROR		; goto error

	call	SetupSerial	

	movlw	TEST_POS
	call	XLCDSetCursorPos
	mXLCDSendMsg	SERIAL
	call	SERIAL_TEST			; pogram data RAM test
	btfsc	STATUS, C
	goto	SERIAL_ERROR		; goto error 

End_Test

	call	SetupTimer1
;	call	SetupSerial

; ********************** Main Loop ************************************-

MainLoop:	

	banksel	Buttons
	movfw	Buttons
	xorwf	Buttons_old, W  ; is changed Buttons ?
	btfss	STATUS, Z       ;
	goto	button_change   ; button was changed
	goto	button_no_change; button wasn't change
button_change
	movfw	Buttons
	movwf	Buttons_old     ; copy new button state to Buttons_old


;	call	XLCDSetCursorPos

;        movlw   'a'
;        call    XLCDPut
;        PRINTBCD MENU_LEVEL, OUTBUF
;        mXLCDSendMsgRAM OUTBUF

;        call    BUT_TO_JUMP

;**************** jumptable for 0. level *******************

;    addwf   PCL, F                  ; 0 Bx Jump in command jump table based on COMMAND from host
;JUMPTABLE_BEGIN:
;    goto    BootloaderInfo          ; 1 B0 0
;    goto    ReadFlash               ; 2 Bx 1
;    goto    VerifyFlash             ; 3 Bx 2
;    goto    EraseFlash              ; 4 Bx 3
;    goto    WriteFlash              ; 5 Bx 4
;    goto    ReadEeprom              ; 6 B0 5
;    goto    WriteEeprom             ; 7 Bx 6
;    goto    SendAcknowledge         ; 8 B0 7 - WriteConfig not supported on PIC16F devices
;    nop                             ; 9 B0 8
;    movlw   high(AppVector)         ; 10 B0 9
;JUMPTABLE_END:

	banksel	PORTA
	btfsc	PORTA, 5
	goto	set_port
	bsf		PORTA, 5
	goto	t1_on
set_port
	bcf		PORTA, 5
t1_on
	nop

	movlw	0x04B
	call	XLCDSetCursorPos

;        PRINTBIN    Buttons, OUTBUF
;	PRINTHEX    Buttons, OUTBUF

        BYTETOBCD   Buttons, OUTBUF
        PRINTBCD    OUTBUF, PRINTBUF
	mXLCDSendMsgRAM PRINTBUF

button_no_change

	banksel	TIMER_ON
	btfsc	TIMER_ON, ON_BIT
	call	InButton

	goto	MainLoop	;repeat main loop to check for data

; ************************** Main loop *****************************

InButton

	banksel	TIMER_ON
	bcf	TIMER_ON, ON_BIT

	call	SaveTRISD
	call	SavePorts

	banksel	TRISD
	movlw	B'11001111'
	movwf	TRISD

	nop
	banksel	PORTD
	nop
	bsf	PORTD, 4
	bcf	PORTD, 5

	nop
	movfw	PORTD
	andlw	0x0F
	banksel	Buttons
	movwf	Buttons
	swapf	Buttons, F

	banksel	PORTD
	bcf	PORTD, 4
	bsf	PORTD, 5

	nop	
	movfw	PORTD
	andlw	0x0F
	banksel	Buttons
	iorwf	Buttons, F

	call	RestorePorts
	call	RestoreTRISD
	return	

PORTS_INIT
	clrf    PCLATH		;select program memory page 0
	banksel	ADCON1
	movlw	ADCON1_ALLDIGITALS		;
	movwf	ADCON1		; set all RE pins as digital I/O
	banksel	TRISA		; 
	clrf	TRISA		; set all A port pins as digital output
	banksel	PORTA		;
	clrf	PORTA		;
	banksel	TRISE		; 
	clrf	TRISE		; set all E port pins as digital output
	call 	XLCDInit	; LCD initialisation
	movlw	B'00001110'	; LCD cursor on, 
	call	XLCDCommand
	call	XLCDClear
	return

SaveTRISD

	banksel	TRISD
	movfw	TRISD
	movwf	TRISD_BUF
	return

RestoreTRISD

	banksel	TRISD
	movfw	TRISD_BUF
	movwf	TRISD
	return
	
SavePorts
	
	banksel	PORTD
	movfw	PORTD
	movwf	PORTD_BUF	
	return

RestorePorts
	banksel	PORTD
	movfw	PORTD_BUF
	movwf	PORTD
	return

SERIAL_ERROR

	goto	exit_errors

DATA_SRM_ERROR

	goto	exit_errors

DATA_EEM_ERROR

	goto	exit_errors
	
PDT_RAM_ERROR

	goto	exit_errors

PRG_EEM_ERROR

exit_errors
	
	mXLCDSendMsg	ER_MSG
	goto	Start_Tests

PUT_ER_MSG

	movlw	0x04E
	call	XLCDSetCursorPos
	mXLCDSendMsg ER_MSG	; program initialisation = 'OK'
	return

PUT_OK_MSG

	movlw	0x04E
	call	XLCDSetCursorPos
	mXLCDSendMsg OK_MSG	; program initialisation = 'OK'
	return

SERIAL_TEST

	call	DELAY500
	bcf	STATUS, C

	return 

DATA_EEM_TEST

	clrf	CHECKSUM

	movlw	0xFF - 4
;	movwf	CL

next_word_01
;	movfw	CL
	call	Get_EEPROM_Byte
;	movwf	ACCW0
;	decf	CL
;	movfw	CL
	call	Get_EEPROM_Byte
;	movwf	ACCW0 + 1

;	ADDW	CHECKSUM, ACCW0
	
;	decf	CL
	btfss	STATUS, C

	goto	next_word_01


	bcf		STATUS, C

	return

PDT_RAM_TEST
	
;	clrf	TEST_DATA
	bcf		STATUS, IRP

NEXT_IND_PAGES
	movlw	0x020
	movwf	FSR
;	banksel	RAM_COUNTER
	movlw	.80
;	movwf	RAM_COUNTER

Next_RAM_Loc

;	movfw	TEST_DATA
	movwf	INDF
	nop
	movfw	INDF
;	subwf	TEST_DATA, W
	btfss	STATUS, Z
	goto	RAM_ERROR
;	incf	TEST_DATA
	incf	FSR
;	decfsz	RAM_COUNTER
	goto	Next_RAM_Loc

	movlw	0x0A0
	movwf	FSR
;	banksel	RAM_COUNTER
	movlw	.80
;	movwf	RAM_COUNTER

Next_RAM_Loc_01

;	movfw	TEST_DATA
	movwf	INDF
	nop
	movfw	INDF
;	subwf	TEST_DATA, W
	btfss	STATUS, Z
	goto	RAM_ERROR
;	incf	TEST_DATA
	incf	FSR
;	decfsz	RAM_COUNTER
	goto	Next_RAM_Loc_01
	btfsc	STATUS, IRP
	goto	END_TEST
	bsf		STATUS, IRP
	goto	NEXT_IND_PAGES
END_TEST
	bcf		STATUS, IRP
	bcf		STATUS, C
	return

RAM_ERROR
	bcf		STATUS, IRP
	bsf	STATUS, C
	return

; ******************************** PRG_EEM_TEST *****************************
; test program memory crc sum CL: program size of 0xFF bytes AH:AL CRC sum **

PRG_EEM_TEST            ; test program memory crc sum CL:
        banksel EEADRH
        clrf    EEADRH	; select program memory block to 0
        clrf    AH      ; clear CRC result register(s)
        clrf    AL
        BANKSEL EECON1
        bsf     EECON1,EEPGD	; select program memory

GetNextBlock
        banksel EEADR       ; select program address of 0x0000
        movfw   BL
        movwf   EEADR
;        clrf    EEADR
GetNextChar
        BANKSEL EECON1
        bsf     EECON1, RD		; select read program memory
        nop
        nop
        BANKSEL	EEDATH
        movfw   EEDATH
        movwf	DH
        BANKSEL EEDATA			;
        movfw   EEDATA
;        call    ADD_CRC
        movfw   DH
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
	
	banksel	CHECKSUM
	movlw	B'00111111'
	andwf	CHECKSUM + 1, F

	movlw	0xFE
	call	Get_EEPROM_Byte
	banksel	CHECKSUM
	subwf	CHECKSUM
	btfss	STATUS, Z
	goto	EEPROM_CHK_ERROR
	
	movlw	0xFF
	call	Get_EEPROM_Byte
	banksel	CHECKSUM
	subwf	CHECKSUM + 1
	btfss	STATUS, Z
	goto	EEPROM_CHK_ERROR
	

	bcf		STATUS, C
	return

EEPROM_CHK_ERROR
	bcf		STATUS, C
	return

;**************************************************************************************************

Get_EEPROM_Byte

	banksel	EEADR
	MOVWF 	EEADR 		
	banksel	EECON1
	BCF EECON1, EEPGD 	;Point to Data memory
	BSF EECON1, RD 		;Start read operation
	banksel	EEDATA
	MOVF EEDATA, W 		;W = EEDATA

	return

Put_EEPROM_Byte

	banksel	EECON1
	BTFSC 	EECON1, WR 	;Wait for
	GOTO $-1 			;write to finish
	banksel	EEADR
;	MOVF 	DI, W 		;Address to
	MOVWF 	EEADR 		;write to
;	MOVF 	AL, W 		;Data to
	MOVWF 	EEDATA 		;write
	banksel	EECON1
	BCF 	EECON1, EEPGD 	;Point to Data memory
	BSF 	EECON1, WREN 	;Enable writes
	;Only disable interrupts
	BCF 	INTCON, GIE 	;if already enabled,
	;otherwise discard
	MOVLW 	0x55 		;Write 55h to
	MOVWF 	EECON2 		;EECON2
	MOVLW 	0xAA 		;Write AAh to
	MOVWF 	EECON2 		;EECON2
	BSF 	EECON1, WR 	;Start write operation
	;Only enable interrupts
	BSF 	INTCON, GIE ;if using interrupts,
	;otherwise discard
	BCF 	EECON1, WREN ;Disable writes
	return

;**************************************************************************************************

DELAY500
	global	DELAY500
	banksel Delay1
	movlw	.1
	movwf	Delay3
	movlw	.250
	movwf	Delay2
	movlw	.50
	movwf	Delay1
	decfsz	Delay1,f
	goto	$-1
	decfsz	Delay2,f
	goto	$-3
	decfsz	Delay3
	goto	$-5
    nop                     ; nop for breakpoint
	return


; Datas in code ----------------------------------------------------------------------------------------------

OK_MSG	de "OK", 0
ER_MSG	de "ER", 0

CRANKMET
	de  	"TEST-II v 1.00", 0
INIT_PROGRAM
   	de   	"Init program:   ", 0 
TEST_MSG
   	de   	"TEST ", 0 
PRG_EEM
   	de   	"PRG CHK:   ", 0
PDT_RAM
   	de   	"PRDT RAM   ", 0
DATA_EEM
   	de   	"DAT EEPM   ", 0
DATA_SRM
   	de   	"DAT SRAM   ", 0
SERIAL
   	de   	"SERIAL     ", 0
INIT_SERIAL
	de		"INIT SERIAL", 0
STOP_SERIAL
	de		"STOP SERIAL", 0

BAUD_NUM_TABLE
	de	"  4800", 0
	de	"  9600", 0
	de	" 19200", 0
	de	" 33600", 0
	de	" 57600", 0
	de	"115200", 0



	END


	banksel	ACCW0

	movlw	0x10
	movwf	ACCW0
	movlw	0x4f
	movwf	ACCW0 + 1

	movlw	0x10
	movwf	ACCW1
	movlw	0x50
	movwf	ACCW1 + 1
	movlw	ACCW0
	call	D_sub


	banksel	Buttons
	btfsc	Buttons, 7
	goto	set_port

	banksel	PORTA
	bsf		PORTA, 5
	goto	t1_on
set_port
	banksel	PORTA
	bcf		PORTA, 5
t1_on

TXT_MAIN_PRG

    db  'End main prg'

CHECKSUM_WORD

    db  0x00, 0x00

END_PROGRAM

