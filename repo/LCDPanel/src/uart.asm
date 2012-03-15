
	#include <P16F877A.INC>	;processor specific definitions

	#define	__UART_CODE

	#include 	"uart.inc"


	errorlevel -302, -207		;suppress "not in bank 0" message

TMR1_HIGH	EQU	0x01
TMR1_LOW	EQU	0x00

;----------------------------------------------------------------------------
;Variables

	UDATA
Flags		res	1			;byte to store indicator flags
TempData	res	1			;temporary data in main routines 
BufferData	res	1		;temporary data in buffer routines 
TxStartPtr	res	1		;pointer to start of data in TX buffer
TxEndPtr	res	1		;pointer to end of data in TX buffer
RxStartPtr	res	1		;pointer to start of data in RX buffer
RxEndPtr	res	1		;pointer to end of data in RX buffer
Buttons		res	1
PORTD_BUF	res	1
TIMER_ON	res	1
	GLOBAL	TIMER_ON

		CBLOCK	0x70
		WREG_TEMP		;storage for WREG during interrupt
		STATUS_TEMP		;storage for STATUS during interrupt
		PCLATH_TEMP		;storage for PCLATH during interrupt
		FSR_TEMP		;storage for FSR during interrupt
		ENDC

		CBLOCK	0xA0
		TxBuffer:TX_BUF_LEN	;transmit data buffer
		ENDC

		CBLOCK	0x120
		RxBuffer:RX_BUF_LEN	;receive data buffer
		ENDC

PROG1	CODE

InterruptCode:	
		GLOBAL	InterruptCode
		banksel	WREG_TEMP
		movwf	WREG_TEMP	;save WREG
		movf	STATUS,W	;store STATUS in WREG
		clrf	STATUS		;select file register bank0
		movwf	STATUS_TEMP	;save STATUS value
		movf	PCLATH,W	;store PCLATH in WREG
		movwf	PCLATH_TEMP	;save PCLATH value
		clrf	PCLATH		;select program memory page0
		movf	FSR,W		;store FSR in WREG
		movwf	FSR_TEMP	;save FSR value

		;test other interrupt flags here

		banksel PIR1		
		btfsc	PIR1,RCIF	;test RCIF receive interrupt
		bsf		STATUS,RP0	;change to bank1 if RCIF set
		btfsc	PIE1,RCIE	;test if interrupt enabled if RCIF set
		goto	GetData		;if RCIF and RCIE set, do receive

		banksel PIR1		
		btfsc	PIR1,TXIF	;test for TXIF transmit interrupt
		bsf		STATUS,RP0	;change to bank1 if TXIF set
		btfsc	PIE1,TXIE	;test if interrupt enabled if TXIF set
		goto	PutData		;if TXIF and TCIE set, do transmit

		banksel	PIR1
		btfsc	PIR1, TMR1IF; test for TMR1 Overflow Interrupt Flag bit
		bsf		STATUS,RP0	;change to bank1 if TMR1 set
		btfsc	PIE1, TMR1IE;test if interrupt enabled if TRR1IE set
		goto	TimerTick

;can do special error handling here - an unexpected interrupt occurred 

		goto	EndInt

;------------------------------------
;Get received data and write into receive buffer.

GetData:	
		banksel RCSTA
		btfsc	RCSTA,OERR	;test overrun error flag
		goto	ErrOERR		;handle it if error
		btfsc	RCSTA,FERR	;test framing error flag
		goto	ErrFERR		;handle it if error

		btfsc	Flags,RxBufFull	;check if buffer full
		goto	ErrRxOver	;handle it if full

		movf	RCREG,W		;get received data
		xorlw	0x0d		;compare with <CR>		
		btfsc	STATUS,Z	;check if the same
		bsf		Flags,ReceivedCR ;indicate <CR> character received
		xorlw	0x0d		;change back to valid data
		call	PutRxBuffer	;and put in buffer
		goto	EndInt

;error because OERR overrun error bit is set
;can do special error handling here - this code simply clears and continues

ErrOERR:	
		bcf		RCSTA,CREN	;reset the receiver logic
		bsf		RCSTA,CREN	;enable reception again
		goto	EndInt

;error because FERR framing error bit is set
;can do special error handling here - this code simply clears and continues

ErrFERR:	
		movf	RCREG,W		;discard received data that has error
		goto	EndInt

;error because receive buffer is full and new data has been received
;can do special error handling here - this code simply clears and continues

ErrRxOver:	
		movf	RCREG,W		;discard received data
		xorlw	0x0d		;but compare with <CR>		
		btfsc	STATUS,Z	;check if the same
		bsf		Flags,ReceivedCR ;indicate <CR> character received
		goto	EndInt

;------------------------------------
;Read data from the transmit buffer and transmit the data.

PutData:	
		banksel Flags		
		btfss	Flags,TxBufEmpty ;check if transmit buffer empty
		goto	PutDat1		;if not then go get data and transmit
		banksel PIE1			;select bank1
		bcf		PIE1,TXIE	;disable TX interrupt because all done
		goto	EndInt

PutDat1:	
		call	GetTxBuffer	;get data to transmit
		movwf	TXREG		;and transmit

;End of interrupt routine restores context
EndInt:		
		banksel FSR_TEMP
		movf	FSR_TEMP,W	;get saved FSR value
		movwf	FSR			;restore FSR
		movf	PCLATH_TEMP,W	;get saved PCLATH value
		movwf	PCLATH		;restore PCLATH
		movf	STATUS_TEMP,W	;get saved STATUS value
		movwf	STATUS		;restore STATUS
		swapf	WREG_TEMP,F	;prepare WREG to be restored
		swapf	WREG_TEMP,W	;restore WREG without affecting STATUS
		retfie				;return from interrupt

;------------------------------------

TimerTick:

	banksel	T1CON
	bcf		T1CON, TMR1ON

	banksel	PIR1	
	bcf	 	PIR1, TMR1IF
	banksel	TMR1H
	movlw	0x001
	movwf	TMR1H
	clrf	TMR1L

	banksel	TIMER_ON
	bsf		TIMER_ON, ON_BIT

	banksel	T1CON
	bsf		T1CON, TMR1ON	

	goto	EndInt

;------------------------------------

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

StopSerial:
	GLOBAL	StopSerial
		movlw	0x00		;disable global and peripheral ints
		movwf	INTCON
		banksel PIE1
		movlw	0x00		;disable TX and RX interrupts
		movwf	PIE1
	
	return

;----------------------------------------------------------------------------

SetupTimer1
	GLOBAL	SetupTimer1
	banksel	T1CON
	bcf		T1CON, TMR1ON	; stop timer 1

	banksel	TMR1H
	movlw	TMR1_HIGH
	movwf	TMR1H
	movlw	TMR1_LOW
	movwf	TMR1L

	clrf	INTCON	
	clrf	PIR1
	banksel	PIE1
	clrf	PIE1
	bsf 	PIE1, TMR1IE

	banksel	PIR1
	clrf	PIR1
	bsf		INTCON, PEIE
	bsf		INTCON, GIE
	banksel	T1CON
	movlw	B'00110000'		; internal clock, enable timer1 prescaler = 8
	movwf	T1CON
	bsf		T1CON, TMR1ON

	return

;Set up serial port and buffers.

SetupSerial:	
	GLOBAL	SetupSerial
		banksel TRISC		
		movlw	0xc0		;set tris bits for TX and RX
		iorwf	TRISC,F
		movlw	SPBRG_VAL	;set baud rate
		movwf	SPBRG
		movlw	0x24		;enable transmission and high baud rate
		movwf	TXSTA
		banksel RCSTA	
		movlw	0x90		;enable serial port and reception
		movwf	RCSTA
		clrf	Flags		;clear all flag bits

		call	InitTxBuffer	;initialize transmit buffer
		call	InitRxBuffer	;initialize receive buffer

		movlw	0xc0		;enable global and peripheral ints
		iorwf	INTCON, F
		banksel PIE1
		movlw	0x30		;enable TX and RX interrupts
		iorwf	PIE1, F
		return

;----------------------------------------------------------------------------
;Circular buffer routines.

;----------------------------------------------------------------------------
;Initialize transmit buffer

InitTxBuffer:	
		banksel TxStartPtr
		movlw	LOW TxBuffer	;take address of transmit buffer
		movwf	TxStartPtr		;and place in transmit start pointer
		movwf	TxEndPtr		;and place in transmit end pointer
		bcf		Flags,TxBufFull	;indicate Tx buffer is not full
		bsf		Flags,TxBufEmpty ;indicate Tx buffer is empty
		return

;----------------------------------------------
;Initialize receive buffer

InitRxBuffer:	
		banksel RxStartPtr
		movlw	LOW RxBuffer	;take address of receive buffer
		movwf	RxStartPtr	;and place in receive start pointer
		movwf	RxEndPtr	;and place in receive end pointer
		bcf	Flags,RxBufFull	;indicate Rx buffer is not full
		bsf	Flags,RxBufEmpty ;indicate Rx buffer is empty
		return

;----------------------------------------------
;Add a byte (from WREG) to the end of the transmit buffer

PutTxBuffer:	
	GLOBAL	PutTxBuffer
		banksel PIE1
		bcf		PIE1,TXIE		;disable transmit interrupt
		banksel Flags
		btfsc	Flags,TxBufFull	;check if buffer full
		goto	ErrTxBufFull	;and go handle error if full

		bankisel	BufferData	;bank bit for indirect addressing
		movwf	BufferData		;save WREG data into BufferData
		movf	TxEndPtr,W		;get EndPointer
		movwf	FSR				;and place into FSR
		movf	BufferData,W	;get BufferData
		movwf	INDF			;and store in buffer

;test if buffer pointer needs to wrap around to beginning of buffer memory

		movlw	LOW TxBuffer+TX_BUF_LEN-1 ;get last address of buffer
		xorwf	TxEndPtr,W		;and compare with end pointer
		movlw	LOW TxBuffer	;load first address of buffer
		btfss	STATUS,Z		;check if pointer is at last address
		incf	TxEndPtr,W		;if not then increment pointer
		movwf	TxEndPtr		;store new end pointer value

;test if buffer is full

		subwf	TxStartPtr,W	;compare with start pointer
		btfsc	STATUS,Z	;check if the same
		bsf		Flags,TxBufFull	;if so then indicate buffer full
		bcf		Flags,TxBufEmpty ;buffer cannot be empty
		banksel PIE1			;select bank 1
		bsf		PIE1,TXIE	;enable transmit interrupt
		banksel PORTA			;select bank 0
		return

;error because attempting to store new data and the buffer is full
;can do special error handling here - this code simply ignores the byte

ErrTxBufFull:	
		banksel PIE1			;select bank 1
		bsf		PIE1,TXIE	;enable transmit interrupt
		banksel PORTA			;select bank 0
		return 			;no save of data because buffer full

;----------------------------------------------
;Add a byte (from WREG) to the end of the receive buffer

PutRxBuffer:	
		banksel Flags			;select bank 0
		btfsc	Flags,RxBufFull	;check if buffer full
		goto	ErrRxBufFull	;and go handle error if full

		bankisel RxBuffer	;bank bit for indirect addressing
		movwf	BufferData	;save WREG into BufferData
		movf	RxEndPtr,W	;get EndPointer
		movwf	FSR		;and place into FSR
		movf	BufferData,W	;get BufferData
		movwf	INDF		;store in buffer

;test if buffer pointer needs to wrap around to beginning of buffer memory

		movlw	LOW RxBuffer+RX_BUF_LEN-1 ;get last address of buffer
		xorwf	RxEndPtr,W	;and compare with end pointer
		movlw	LOW RxBuffer	;load first address of buffer
		btfss	STATUS,Z	;check if pointer is at last address
		incf	RxEndPtr,W	;if not then increment pointer
		movwf	RxEndPtr	;store new end pointer value

;test if buffer is full

		subwf	RxStartPtr,W	;compare with start pointer
		btfsc	STATUS,Z	;check if the same
		bsf	Flags,RxBufFull	;if so then indicate buffer full
		bcf	Flags,RxBufEmpty ;buffer cannot be empty
		return

;error because attempting to store new data and the buffer is full
;can do special error handling here - this code simply ignores the byte

ErrRxBufFull:	return 			;no save of data because buffer full

;----------------------------------------------
;Remove and return (in WREG) the byte at the start of the transmit buffer

GetTxBuffer:	
		banksel Flags			;select bank 0
		btfsc	Flags,TxBufEmpty ;check if transmit buffer empty
		goto	ErrTxBufEmpty	;and go handle error if empty

		bankisel TxBuffer	;bank bit for indirect addressing
		movf	TxStartPtr,W	;get StartPointer
		movwf	FSR		;and place into FSR

;test if buffer pointer needs to wrap around to beginning of buffer memory

		movlw	LOW TxBuffer+TX_BUF_LEN-1 ;get last address of buffer
		xorwf	TxStartPtr,W	;and compare with start pointer
		movlw	LOW TxBuffer	;load first address of buffer
		btfss	STATUS,Z	;check if pointer is at last address
		incf	TxStartPtr,W	;if not then increment pointer
		movwf	TxStartPtr	;store new pointer value
		bcf	Flags,TxBufFull	;buffer cannot be full

;test if buffer is now empty

		xorwf	TxEndPtr,W	;compare start to end	
		btfsc	STATUS,Z	;check if the same
		bsf	Flags,TxBufEmpty ;if same then buffer will be empty
		movf	INDF,W		;get data from buffer

		return

;error because attempting to read data from an empty buffer
;can do special error handling here - this code simply returns zero

ErrTxBufEmpty:	
		retlw	0		;tried to read empty buffer

;----------------------------------------------
;Remove and return (in WREG) the byte at the start of the receive buffer

GetRxBuffer:	
		banksel Flags			;select bank 0
		btfsc	Flags,RxBufEmpty ;check if receive buffer empty
		goto	ErrRxBufEmpty	;and go handle error if empty

		banksel PIE1		
		bcf		PIE1,RCIE		;disable receive interrupt
		banksel PORTA			

		bankisel RxBuffer		;bank bit for indirect addressing
		movf	RxStartPtr,W	;get StartPointer
		movwf	FSR				;and place into FSR

;test if buffer pointer needs to wrap around to beginning of buffer memory

		movlw	LOW RxBuffer+RX_BUF_LEN-1 ;get last address of buffer
		xorwf	RxStartPtr,W	; and compare with start pointer
		movlw	LOW RxBuffer	;load first address of buffer
		btfss	STATUS,Z		;check if pointer is at last address
		incf	RxStartPtr,W	;if not then increment pointer
		movwf	RxStartPtr		;store new pointer value
		bcf		Flags,RxBufFull	;buffer cannot be full

;test if buffer is now empty

		xorwf	RxEndPtr,W		;compare start to end	
		btfsc	STATUS,Z		;check if the same
		bsf		Flags,RxBufEmpty ;if same then buffer will be empty
		movf	INDF,W			;get data from buffer

		banksel PIE1			
		bsf		PIE1,RCIE		;enable receive interrupt
		banksel PORTA			;select bank 0
		return

;error because attempting to read data from an empty buffer
;can do special error handling here - this code simply returns zero

ErrRxBufEmpty:	
		banksel PIE1			;select bank 1
		bsf		PIE1,RCIE	;enable receive interrupt
		banksel PORTA			;select bank 0
		retlw	0		;tried to read empty buffer

;----------------------------------------------------------------------------
;Move data from receive buffer to transmit buffer to echo the line back

CopyRxToTx:	
	GLOBAL	CopyRxToTx
		banksel Flags			;select bank 0
		bcf		Flags,ReceivedCR ;clear <CR> received indicator
Copy1:		
		btfsc	Flags,RxBufEmpty ;check if Rx buffer is empty
		return			;if so then return
		call	GetRxBuffer	;get data from receive buffer
		movwf	TempData	;save data
		call	PutTxBuffer	;put data in transmit buffer
		movf	TempData,W	;restore data
		xorlw	0x0d		;compare with <CR> 
		btfss	STATUS,Z	;check if the same
		goto	Copy1		;if not the same then move another byte
		return

;----------------------------------------------------------------------------

		END



