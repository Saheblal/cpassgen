

#include "dtime.h"
#include "xlcd.h"


int XLCDInit()
{
    int result;
    #if XLCDBLOCKING = 0            //;non blocking
        #if XLCDMODE = 1            //;delay
        #warning "Mode cannot be delay if NONBLOCKING in MpAM option"
        #endif
    #endif
    #if XLCDRWPIN = 10             // ;grounded
        #if XLCDMODE == 0 ;Read BF
        #warning "Read BF mode not possible(No read is possible with RW pin grounded) "
        #endif
    #endif
    Delay(15);      /* 15 msec delay */

//        BANKSEL _vXLCDStatus
//        bsf     _vXLCDStatus,0              ;bit set in XLCDInit routine and cleared when returned

/**********************************************************************
DATA port initialization
*********************************************************************
if 8 bit interface for datatransmission is selected
----------------------------------------------------------------------*/
    #if  XLCDINTERFACE   = 8
                            //  only lower nibble can be selected
            BANKSEL TRISA  
            movlw   0x00
    XLCDDATAPORT     ;make port output
    #endif
;----------------------------------------------------------------------
;if 4 bit interface for datatransmission is selected
;----------------------------------------------------------------------
    #if  XLCDINTERFACE   == 4

;if Lower nibble selected

        #if XLCDNIBBLESEL   == 0    ;lower

            BANKSEL TRISA
            movlw   0xF0
            andwf   XLCDDATAPORT,f  ;make lower nibble output
         #endif

;if upper nibble selected

         #if XLCDNIBBLESEL   == 1   ;Upper

            BANKSEL TRISA
            movlw   0x0F
            andwf   XLCDDATAPORT,f  ;make upper nibble output
         #endif

    #endif
;----------------------------------------------------------------------------------
;Control port initialization
;----------------------------------------------------------------------------------
        BANKSEL TRISA
        bcf     XLCDRSPORT,XLCDRSPIN    ;TRIS of RSpin made output
        bcf     XLCDENPORT,XLCDENPIN    ;TRIS of Enpin made output
        #if     XLCDRWPIN   !=10        ;need not select if this pin in LCD is grounded
        bcf     XLCDRWPORT,XLCDRWPIN    ;TRIS of RWpin made output
        #endif



        BANKSEL XLCDRSPORT
        bcf     XLCDRSPORT,XLCDRSPIN
        bcf	    XLCDENPORT,XLCDENPIN
        #if XLCDRWPIN !=10              ;if RW pin LCD grounded
        bcf     XLCDRWPORT,XLCDRWPIN
        #endif


;----------------------------------------------------------------------------------
;initialisation by instruction for 4 bit mode
;----------------------------------------------------------------------------------
    #if     XLCDINTERFACE   == 4            ;for 4 bit data transmission
        #if XLCDNIBBLESEL == 1        ;for higher nibble
            #if XLCDDATAPORT == PORTA
            error "Not possible with upper nibble if PORTA selected as DATAPORT in MPAM"
            #endif
        #endif


        movlw   B'00000011'
        call    XLCDCommandInit4bit         ;used only in struction by initialisation in 4 bit mode

        call    XLCDDelay5ms
        movlw   B'00000011'
        call    XLCDCommandInit4bit         ;used only in struction by initialisation in 4 bit mode

        ;call    XLCDDelay100us
        call    XLCDDelay5ms
        movlw   B'00000011'
        call    XLCDCommandInit4bit         ;used only in struction by initialisation in 4 bit mode

        call    XLCDDelay5ms
        movlw   B'00000010'
        call    XLCDCommandInit4bit         ;used only in struction by initialisation in 4 bit mode
    #endif  ;last
;----------------------------------------------------------------------------------
;initialisation by instruction for 8 bit mode
;----------------------------------------------------------------------------------
    #if     XLCDINTERFACE   == 8
        #if XLCDDATAPORT    == PORTA
        error "Not  PORTA selected as DATAPORT in MPAM IN 8 BIT INTERFACE"
        #endif

        BANKSEL XLCDDATAPORT
        movlw   0x30
        movwf   XLCDDATAPORT
        bsf     XLCDENPORT,XLCDENPIN
        nop
        nop
        nop
        bcf     XLCDENPORT,XLCDENPIN
        call    XLCDDelay5ms

        BANKSEL XLCDDATAPORT
        movlw   0x30
        movwf   XLCDDATAPORT
;        movwf   XLCDDATAPORT
        bsf     XLCDENPORT,XLCDENPIN
        nop
        nop
        nop
        bcf     XLCDENPORT,XLCDENPIN
        call    XLCDDelay100us

        BANKSEL XLCDDATAPORT
        movlw   0x30
        movwf   XLCDDATAPORT
;        movwf   XLCDDATAPORT
        bsf     XLCDENPORT,XLCDENPIN
        nop
        nop
        nop
        bcf     XLCDENPORT,XLCDENPIN
    #endif  ;last
;----------------------------------------------------------------------------------
;intialisation by command is finised( blocking non blocking by reading
;back the busy possible from here)
;common for both 8 and 4 bit transmission
;----------------------------------------------------------------------------------
;Function command "0 0 1 DL N F x x "
;if DL =0 , 4 bit
;      =1 , 8 bit
;if N  =0 , 1 line
;      =1 , 2 line
;if F  =0 , 5x8


