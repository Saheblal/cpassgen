


;----------------------------------------------------------------------------
;Constants

SPBRG_VAL	EQU	.96		;set baud rate 9600 for 15Mhz clock
TX_BUF_LEN	EQU	.20		;length of transmit circular buffer
RX_BUF_LEN	EQU	TX_BUF_LEN	;length of receive circular buffer

;----------------------------------------------------------------------------
;Bit Definitions

TxBufFull	EQU	0		;bit indicates Tx buffer is full
TxBufEmpty	EQU	1		;bit indicates Tx buffer is empty
RxBufFull	EQU	2		;bit indicates Rx buffer is full
RxBufEmpty	EQU	3		;bit indicates Rx buffer is empty
ReceivedCR	EQU	4		;bit indicates <CR> character received
ON_BIT		EQU 0


	ifndef	__UART_CODE

	EXTERN	InterruptCode
	EXTERN	SetupSerial
	EXTERN	StopSerial
	EXTERN	CopyRxToTx
	EXTERN	PutTxBuffer
	EXTERN	SetupTimer1
;	EXTERN	Buttons
	EXTERN	TIMER_ON

	else
	#undefine	__UART_CODE
	endif

