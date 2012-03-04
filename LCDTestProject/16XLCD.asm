;*******************************************************************************
;*  This implements a generic library functionality to support 	
;*  using External LCD module to support PIC16 family
;*******************************************************************************
;* FileName             :16XLCD.asm
;* Dependencies         :P16xxx.inc
;*                       XLCD.Def
;* Processor            :PIC16xxxx
;* Assembler            :MPASMWIN 02.70.02 or higher
;* Linker               :MPLINK 2.33.00 or higher
;* Company              :Microchip Technology, Inc.
;*									
;* Software License Agreement		
;*									
;* The software supplied herewith by Microchip Technology Incorporated
;* (the "Company") for its PICmicro® Microcontroller is intended and
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
;*									
;* ANY SPECIAL DESCRIPTION THAT MIGHT BE USEFUL FOR THIS FILE.
;*									
;* Author               Date            Comment				
;*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;
;* Naveen Raj        April xx, 2003    Initial Release (V1.0)										
;***********************************************************************;

#include xlcd.inc

XLCDCODE    CODE	
;*********************************************************************
; Function          :XLCDInit
; PreCondition      :None							
; Overview          :This routine is used for LCD Module Initialization	
;                    (will be blocking  irrespective of the selection)					
; Input             :MpAM options							
; Output            :None																
; Side Effects      :Bank selection bits and W are changed	
; Stack requirement :3 level deep
; Machine cycle     :depended on MpAM option					
;*********************************************************************					
XLCDInit:
    GLOBAL  XLCDInit
;error combinations
    #if XLCDBLOCKING == 0 ;non blocking
        #if XLCDMODE == 1 ;delay    
        error "Mode cannot be delay if NONBLOCKING in MpAM option"    
        #endif
    #endif
    #if XLCDRWPIN == 10 ;grounded
        #if XLCDMODE == 0 ;Read BF   
        error "Read BF mode not possible(No read is possible with RW pin grounded) "    
        #endif
    #endif    
        call    XLCDDelay5ms    ;15ms delay
        call    XLCDDelay5ms
        call    XLCDDelay5ms 
        
        BANKSEL _vXLCDStatus
        bsf     _vXLCDStatus,0              ;bit set in XLCDInit routine and cleared when returned   

;*********************************************************************    
;DATA port initialization
;*********************************************************************
;if 8 bit interface for datatransmission is selected
;----------------------------------------------------------------------
    #if  XLCDINTERFACE   == 8
            BANKSEL TRISA           ;only lower nibble can be selected
            movlw   0x00
            movwf   XLCDDATAPORT    ;make port output
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
;      =1 , 5x10
 
        BANKSEL _vXLCDreg3                  ;used to store function set status of LCD command
        movlw   B'00100000'                 ;function set command(if single line 5x8)
        movwf   _vXLCDreg3
        
    #if XLCDINTERFACE == 8
        bsf     _vXLCDreg3,4                ; for 8 bit interface
    #endif
    #if XLCDLINE == 1
        bsf     _vXLCDreg3,3                ;if 2 line
    #endif
    #if XLCDFONT == 1
        bsf     _vXLCDreg3,2                ;if 5x10
    #endif
                                      
        movf    _vXLCDreg3,w
        call    XLCDCommand
                    
        movlw   B'00001000'                 ;Display off    
        call    XLCDCommand
      
        movlw   B'00000001'                 ;Display clear
        call    XLCDCommand
        
;----------------------------------------------------------------------------------
;Eentry mode setting
;Entry mode command " 0 0 0 0 0 1 ID S"
;if ID = 0 no increment( during write and read operation)
;if S =0 no shift  
;----------------------------------------------------------------------------------    
        movlw   B'00000100'                 ;entry mode setting
        BANKSEL _vXLCDreg3
        movwf   _vXLCDreg3
    #if XLCDENTRYID == 1                    ;if yes ID=1
        bsf     _vXLCDreg3,1                ;cursor shift with read and write
    #endif
    #if XLCDENTRYSHIFT == 1                 ;if yes S=1
        bsf     _vXLCDreg3,0                ;display shift with read and write
    #endif 
        movf    _vXLCDreg3,w       
        call    XLCDCommand

;----------------------------------------------------------------------------------
;function set command " 0 0 0 0 1 D C B "
;D=1 on
;C=1 cursor on
;B=1 blink  on 
;----------------------------------------------------------------------------------       
        movlw   B'00001111'                 ;Display on,off
        BANKSEL _vXLCDreg3
        movwf   _vXLCDreg3
    #if XLCDDISPLAYON == 0                  ;if no D=0
        bcf     _vXLCDreg3,2                ;off display
    #endif
    #if XLCDCURSORON == 0                   ;if no C=0
        bcf     _vXLCDreg3,1                ;off cursor
    #endif 
    #if XLCDBLINKON  == 0                   ;if no B=0
        bcf     _vXLCDreg3,0                ;off blink
    #endif
        movf    _vXLCDreg3,w       
        call    XLCDCommand
        
        
    #if XLCDBLOCKING == 0                   ;this call of read busy is required because if the busy
    call    XLCDIsBusy                      ;flag is not free the first data put can get missed
    #endif                                  ;but in BLOCKING mode read busy is checked first before
                                            ;before executing the command so need not be called

        
    BANKSEL _vXLCDStatus
    bcf     _vXLCDStatus,0                  ;bit set in XLCDInit routine and cleared when returned    
                                            ;this flag used to check in XLCDCommand
    return                                  ;end of initialisation
    
;*********************************************************************
; Function          :XLCDCommand	
; PreCondition      :None 							
; Overview          :It sends the clocking signal and command to LCD						
; Input             :Instruction loaded in w reg							
; Output            :None																
; Side Effects      :Bank selection bits and W are changed	
; Stack requirement :1 or two depended on MpAM option
; Machine cycle     :Depended on MpAM options 					
;*********************************************************************
XLCDCommand:
    GLOBAL  XLCDCommand
    BANKSEL _vXLCDreg3
    movwf   _vXLCDreg3              ;tempstorage
    
    
    
    BANKSEL _vXLCDStatus
    btfsc   _vXLCDStatus,0          ;checking if called from XLCDInit
    goto    _XLCDCommandInit        ;goes here only if called from XLCDInit    
    goto    _XLCDCommandMode        ;goes here every time after initialization                        

_XLCDCommandInit                    ;this part of the code is executed only
        #if XLCDMODE ==1            ;in XLCDInit function and is always a bolcking 
        call    XLCDDelay           ;as XLCDInit is BLOCKING
        #endif
        #if XLCDMODE ==0 
        call    XLCDIsBusy
        #endif
        goto    _XLCDCommandStart
        
_XLCDCommandMode                    ;comes here everytime after XLCDInit is over

    #if XLCDBLOCKING == 1 ;if yes
        #if XLCDMODE ==1 
        call    XLCDDelay
        #endif
        #if XLCDMODE ==0 
        call    XLCDIsBusy
        #endif
    #endif
      

_XLCDCommandStart      
    #if XLCDINTERFACE == 4                  
  
        #if XLCDNIBBLESEL == 0              ;lower(send upper nibble first)
        
        BANKSEL XLCDDATAPORT
        bcf     XLCDRSPORT,XLCDRSPIN
        bcf     XLCDENPORT,XLCDENPIN
        
        #if     XLCDRWPIN !=10              ;need not do if LCD RW pin is grounded
        bcf     XLCDRWPORT,XLCDRWPIN
        #endif

        BANKSEL XLCDDATAPORT
        movlw   0xf0
        andwf   XLCDDATAPORT,f            
        BANKSEL _vXLCDreg3
        swapf   _vXLCDreg3,w                          
        andlw   0x0f
        BANKSEL XLCDDATAPORT
        iorwf   XLCDDATAPORT,f
        bsf     XLCDENPORT,XLCDENPIN    ;clock
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
        bcf     XLCDENPORT,XLCDENPIN

         
        BANKSEL XLCDDATAPORT
        movlw   0xf0
        andwf   XLCDDATAPORT,f  
        BANKSEL _vXLCDreg3
        movf    _vXLCDreg3,w
        andlw   0x0f
        BANKSEL XLCDDATAPORT
        iorwf   XLCDDATAPORT,f
        bsf     XLCDENPORT,XLCDENPIN    ;clock   
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
        bcf     XLCDENPORT,XLCDENPIN
             
        #endif                          ;if nibblesel == 0
    
    
    
        
        #if XLCDNIBBLESEL == 1          ;upper(send upper nibble first)
        
        BANKSEL XLCDDATAPORT
        bcf     XLCDRSPORT,XLCDRSPIN
        bcf     XLCDENPORT,XLCDENPIN
        
        #if     XLCDRWPIN !=10              ;need not do if LCD RW pin is grounded
        bcf     XLCDRWPORT,XLCDRWPIN
        #endif
    
        BANKSEL XLCDDATAPORT
        movlw   0x0F
        andwf   XLCDDATAPORT,f  
        BANKSEL _vXLCDreg3
        movf    _vXLCDreg3,w                          
        andlw   0xF0                    ;upper nibble sent first
        BANKSEL XLCDDATAPORT
        iorwf   XLCDDATAPORT,f
        bsf     XLCDENPORT,XLCDENPIN    ;clock
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
        bcf     XLCDENPORT,XLCDENPIN
        
        BANKSEL XLCDDATAPORT
        movlw   0x0F
        andwf   XLCDDATAPORT,f  
        BANKSEL _vXLCDreg3
        swapf   _vXLCDreg3,w
        andlw   0xf0
        BANKSEL XLCDDATAPORT
        iorwf   XLCDDATAPORT,f
        bsf     XLCDENPORT,XLCDENPIN    ;clock
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
        bcf     XLCDENPORT,XLCDENPIN 
                       
        #endif                          ;if nibblesel ==1
    #endif                              ;if Interface ==4
 ;---------------------------------------   
    
    #if XLCDINTERFACE == 8 
        BANKSEL XLCDDATAPORT
        bcf     XLCDRSPORT,XLCDRSPIN
        bcf     XLCDENPORT,XLCDENPIN
        
        #if     XLCDRWPIN !=10              ;need not do if LCD RW pin is grounded
        bcf     XLCDRWPORT,XLCDRWPIN
        #endif

        BANKSEL _vXLCDreg3
        movf    _vXLCDreg3,w
        BANKSEL XLCDDATAPORT
        movwf   XLCDDATAPORT
        bsf     XLCDENPORT,XLCDENPIN    ;clock        
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif        
        bcf     XLCDENPORT,XLCDENPIN 
    #endif                              ;if Interface ==8  


    return                          ;return from XLCDCommand              
    
;*********************************************************************
; Function          :XLCDPut
; PreCondition      :None					
; Overview          :Writes content to LCD						
; Input             :W register content							
; Output            :None																
; Side Effects      :Bank selection bits and W are changed	
; Stack requirement :2 or 1 depended on MpAM option
; Machince cycle    :depended on MpAM option				
;*********************************************************************   
XLCDPut:
    GLOBAL  XLCDPut

    BANKSEL _vXLCDreg3
    movwf   _vXLCDreg3

    #if XLCDBLOCKING == 1 ;if yes
        #if XLCDMODE ==1 
        call    XLCDDelay
        #endif
        #if XLCDMODE ==0 
        call    XLCDIsBusy
        #endif
    #endif    

    BANKSEL XLCDDATAPORT   
    #if     XLCDRWPIN !=10              ;need not do if LCD RW pin is grounded
    bcf     XLCDRWPORT,XLCDRWPIN
    #endif    
    bsf     XLCDRSPORT,XLCDRSPIN
    bcf     XLCDENPORT,XLCDENPIN
    
    #if  XLCDINTERFACE == 8
        BANKSEL _vXLCDreg3              ;clear port
        movf   _vXLCDreg3,w
        BANKSEL XLCDDATAPORT
        movwf   XLCDDATAPORT
        bsf     XLCDENPORT,XLCDENPIN
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
        bcf     XLCDENPORT,XLCDENPIN
    #endif
    
    
    #if  XLCDINTERFACE == 4
        
        #if  XLCDNIBBLESEL == 0      ;lower nibble(upper nibble to be clocked
        
        movlw   0xF0
        andwf   XLCDDATAPORT,f            ;clear port
        BANKSEL _vXLCDreg3
        swapf   _vXLCDreg3,w
        andlw   0x0F
        BANKSEL XLCDDATAPORT
        iorwf   XLCDDATAPORT,f
        bsf     XLCDENPORT,XLCDENPIN
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
        bcf     XLCDENPORT,XLCDENPIN
        
        movlw   0xF0                    ;clear port
        andwf   XLCDDATAPORT,f
        BANKSEL _vXLCDreg3
        movf    _vXLCDreg3,w
        andlw   0x0F
        BANKSEL XLCDDATAPORT
        iorwf   XLCDDATAPORT,f
        bsf     XLCDENPORT,XLCDENPIN
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
        bcf     XLCDENPORT,XLCDENPIN
 
        #endif 
        
        
        
        
        #if  XLCDNIBBLESEL == 1      ; upper(upper nibble first)
        
        movlw   0x0F                    ;clear port
        andwf   XLCDDATAPORT,f
        BANKSEL _vXLCDreg3
        movf    _vXLCDreg3,w
        andlw   0xF0
        BANKSEL XLCDDATAPORT
        iorwf   XLCDDATAPORT,f
        bsf     XLCDENPORT,XLCDENPIN
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
        bcf     XLCDENPORT,XLCDENPIN
 
        
        movlw   0x0F                    ;clear port
        andwf   XLCDDATAPORT,f
        BANKSEL _vXLCDreg3
        swapf    _vXLCDreg3,w
        andlw   0xF0
        BANKSEL XLCDDATAPORT
        iorwf   XLCDDATAPORT,f
        bsf     XLCDENPORT,XLCDENPIN
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
        bcf     XLCDENPORT,XLCDENPIN
          
        #endif                          ;for nibblesel    

    #endif                              ;for interface

    return  				
	
;*********************************************************************
    #if XLCDRWPIN !=10 ;need not compile if RW pin is grounded	

;*********************************************************************
; Function          :XLCDIsBusy
; PreCondition      :None							
; Overview          :Reads the BF Flag(called before or after every 
;                   :command)						
; Input             :None							
; Output            :None																
; Side Effects      :Bank selection bits and W are changed	
; Stack requirement :1 level deep
; Machince cycle    :depended on LCD Module					
;*********************************************************************   
XLCDIsBusy:
    GLOBAL  XLCDIsBusy
    
    
    BANKSEL XLCDDATAPORT
_XLCDReadBusyRepeat
    #if     XLCDRWPIN !=10              ;need not do if LCD RW pin is grounded
    bsf     XLCDRWPORT,XLCDRWPIN 
    #endif   
    bcf     XLCDRSPORT,XLCDRSPIN
    bcf     XLCDENPORT,XLCDENPIN
    
    #if  XLCDINTERFACE == 8
    
    BANKSEL TRISA
    movlw   0xFF
    movwf    XLCDDATAPORT                   ;make 8 bit port input
    
    BANKSEL XLCDDATAPORT
    bsf     XLCDENPORT,XLCDENPIN
        #if CLOCK_FREQ >= .15000000         ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
;    bcf     XLCDENPORT,XLCDENPIN
    nop
    movf    XLCDDATAPORT,w
    bcf     XLCDENPORT,XLCDENPIN
    BANKSEL _vXLCDtemp1
    movwf   _vXLCDtemp1
       
    BANKSEL TRISA
    clrf   XLCDDATAPORT                     ;make 8 bit port output  
    #endif
    
  
    
    #if  XLCDINTERFACE == 4
        #if XLCDNIBBLESEL ==0
        
            BANKSEL TRISA
            movlw   0x0F
            iorwf    XLCDDATAPORT,f         ;make lower nibbles as inputs
                
            BANKSEL XLCDDATAPORT
            bsf     XLCDENPORT,XLCDENPIN
                #if CLOCK_FREQ >= .15000000 ;need a min time for 230ns for clock
                nop
                nop
                nop
                #endif
            ;bcf     XLCDENPORT,XLCDENPIN 
            nop
            swapf    XLCDDATAPORT,w         ;upper nibble is read first
            andlw   0xF0
            bcf     XLCDENPORT,XLCDENPIN
            BANKSEL _vXLCDtemp1
            movwf   _vXLCDtemp1             ;upper nibble is stored in temp1
        
           
            BANKSEL XLCDDATAPORT
            bsf     XLCDENPORT,XLCDENPIN
                #if CLOCK_FREQ >= .15000000 ;need a min time for 230ns for clock
                nop
                nop
                nop
                #endif
            ;bcf     XLCDENPORT,XLCDENPIN 
            nop
            movf    XLCDDATAPORT,w          ;lower nibble is read 
            andlw   0x0F
            bcf     XLCDENPORT,XLCDENPIN
            BANKSEL _vXLCDtemp1
            iorwf   _vXLCDtemp1,f           ;upper nibble is stored in temp1


            BANKSEL TRISA
            movlw   0xF0
            andwf    XLCDDATAPORT           ;make lower nibble output
          
        #endif
        
        #if XLCDNIBBLESEL == 1
            BANKSEL TRISA
            movlw   0xF0
            iorwf    XLCDDATAPORT,f         ;make upper nibble as inputs
        
        
            BANKSEL XLCDDATAPORT
            bsf     XLCDENPORT,XLCDENPIN
                #if CLOCK_FREQ >= .15000000 ;need a min time for 230ns for clock
                nop
                nop
                nop
                #endif
            ;bcf     XLCDENPORT,XLCDENPIN 
            nop
            movf    XLCDDATAPORT,w          ;upper nibble is read first
            andlw   0xF0
            bcf     XLCDENPORT,XLCDENPIN
            BANKSEL _vXLCDtemp1
            movwf   _vXLCDtemp1             ;upper nibble is stored in temp1
        
           
            BANKSEL XLCDDATAPORT
            bsf     XLCDENPORT,XLCDENPIN
                #if CLOCK_FREQ >= .15000000 ;need a min time for 230ns for clock
                nop
                nop
                nop
                #endif
            ;bcf     XLCDENPORT,XLCDENPIN 
            nop
            swapf    XLCDDATAPORT,w         ;lower nibble is read 
            andlw   0x0F
            bcf     XLCDENPORT,XLCDENPIN
            BANKSEL _vXLCDtemp1
            iorwf   _vXLCDtemp1,f           ;upper nibble is stored in temp1


            BANKSEL TRISA
            movlw   0x0F
            andwf   XLCDDATAPORT,f          ;make upper nibble output

        #endif    
            

    #endif


    BANKSEL _vXLCDStatus
    btfsc   _vXLCDStatus,0                  ;to check if called from Init routine
    goto    _XLCDIsBusyInitret              ;if yes goto XLCDIsBusyInitret
    
     
    #if XLCDBLOCKING == 1                   ;Blocking         
    BANKSEL _vXLCDtemp1
    btfsc   _vXLCDtemp1,7
    goto    _XLCDReadBusyRepeat             ;will be looping here till the busy Flag Clears        
    #endif

    #if XLCDBLOCKING == 0                   ;nonblocking return with 1 in W         
    BANKSEL _vXLCDtemp1
    movlw   0x00                            ;return zero if not busy
    btfsc   _vXLCDtemp1,7
    movlw   0x01                            ;return 1 if busy       
    #endif
        
    return
    



_XLCDIsBusyInitret                          ;this section of the code is executed only    
    BANKSEL _vXLCDtemp1                     ;during the XLCDInit part
    btfsc   _vXLCDtemp1,7                   ;it will a blocking function always
    goto    _XLCDReadBusyRepeat             ;will be looping here till the busy Flag Clears        
    return
    
;*********************************************************************
; Function          :XLCDReadData
; PreCondition      :None							
; Overview          :Reads data from DDRAM present address						
; Input             :None							
; Output            :out put in W reg																
; Side Effects      :Bank selection bits and W are changed	
; Stack requirement :1 or 2  level deep depended on MpAM option
; Machince cycle    :depended on MpAM option					
;*********************************************************************    
XLCDReadData:
    GLOBAL  XLCDReadData

    #if XLCDBLOCKING == 1               ;if yes
        #if XLCDMODE ==1 
        call    XLCDDelay
        #endif
        #if XLCDMODE ==0 
        call    XLCDIsBusy
        #endif
    #endif         
    
    
    BANKSEL XLCDDATAPORT
    #if     XLCDRWPIN !=10              ;need not do if LCD RW pin is grounded
    bsf     XLCDRWPORT,XLCDRWPIN
    #endif    
    bsf     XLCDRSPORT,XLCDRSPIN
    bcf     XLCDENPORT,XLCDENPIN
    
    #if  XLCDINTERFACE == 8

    BANKSEL TRISA
    movlw   0xFF
    movwf    XLCDDATAPORT               ;make 8 bit port input
    BANKSEL XLCDDATAPORT
    bsf     XLCDENPORT,XLCDENPIN
        #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
        nop
        nop
        nop
        #endif
    ;bcf     XLCDENPORT,XLCDENPIN
    nop
    nop
    movf    XLCDDATAPORT,w
    bcf     XLCDENPORT,XLCDENPIN
    BANKSEL _vXLCDtemp1
    movwf   _vXLCDtemp1
        
    BANKSEL TRISA
    clrf   XLCDDATAPORT                 ;make port output  
    #endif
    
    
    
    #if  XLCDINTERFACE == 4
        #if XLCDNIBBLESEL ==0
        
            BANKSEL TRISA
            movlw   0x0F
            iorwf    XLCDDATAPORT,f             ;make pin as inputs
        
        
            BANKSEL XLCDDATAPORT
            bsf     XLCDENPORT,XLCDENPIN
                #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
                nop
                nop
                nop
                #endif
            ;bcf     XLCDENPORT,XLCDENPIN 
            nop
            nop
            swapf    XLCDDATAPORT,w             ;upper nibble is read first
            andlw   0xF0
            bcf     XLCDENPORT,XLCDENPIN
            BANKSEL _vXLCDtemp1
            movwf   _vXLCDtemp1                 ;upper nibble is stored in temp1
        
           
            BANKSEL XLCDDATAPORT
            bsf     XLCDENPORT,XLCDENPIN
                #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
                nop
                nop
                nop
                #endif
            ;bcf     XLCDENPORT,XLCDENPIN
            nop
            nop 
            movf    XLCDDATAPORT,w              ;lower nibble is read 
            andlw   0x0F
            bcf     XLCDENPORT,XLCDENPIN
            BANKSEL _vXLCDtemp1
            iorwf   _vXLCDtemp1,f               ;upper nibble is stored in temp1

  
            BANKSEL TRISA
            movlw   0xF0
            andwf    XLCDDATAPORT,f             ;make port output
          
        #endif
        
        #if XLCDNIBBLESEL == 1
       
            BANKSEL TRISA
            movlw   0xF0
            iorwf    XLCDDATAPORT,f             ;make upper nibbles as inputs
        
        
            BANKSEL XLCDDATAPORT
            bsf     XLCDENPORT,XLCDENPIN
                #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
                nop
                nop
                nop
                #endif
            ;bcf     XLCDENPORT,XLCDENPIN 
            nop
            nop
            movf    XLCDDATAPORT,w              ;upper nibble is read first
            andlw   0xF0
            bcf     XLCDENPORT,XLCDENPIN
            BANKSEL _vXLCDtemp1
            movwf   _vXLCDtemp1                 ;upper nibble is stored in temp1
        
           
            BANKSEL XLCDDATAPORT
            bsf     XLCDENPORT,XLCDENPIN
                #if CLOCK_FREQ >= .15000000     ;need a min time for 230ns for clock
                nop
                nop
                nop
                #endif
            ;bcf     XLCDENPORT,XLCDENPIN
            nop
            nop 
            swapf    XLCDDATAPORT,w             ;lower nibble is read 
            andlw   0x0F
            bcf     XLCDENPORT,XLCDENPIN
            BANKSEL _vXLCDtemp1
            iorwf   _vXLCDtemp1,f               ;upper nibble is stored in temp1

    
            BANKSEL TRISA
            movlw   0x0F
            andwf    XLCDDATAPORT,f             ;restore the old TRIS status

        #endif    
            

    #endif   
    
    BANKSEL _vXLCDtemp1
    movf    _vXLCDtemp1,w

    return    
;********************************************************************
    #endif          ;if RWPIN grounded    

;*********************************************************************
; Function          :XLCDCommandInit4bit														
; PreCondition      :None																
; Overview          :used only in 4 bit initialization			      							
; Input             :None
; Output            :none															
; Side Effects      :Bank selection bits  are changed									
; Stack requirement :1 level deep
; Machine cycle     :(used in XLCDInit only)													
;*********************************************************************
XLCDCommandInit4bit:
    GLOBAL  XLCDCommandInit4bit
    BANKSEL _vXLCDreg1
    movwf   _vXLCDreg1
    #if XLCDNIBBLESEL   == 0
        BANKSEL XLCDDATAPORT
        movlw   0xF0                ;make present port content zero
        andwf   XLCDDATAPORT,f      ;by anding F0(when lower)with DATAPORT
        BANKSEL _vXLCDreg1
        movf    _vXLCDreg1,w
        BANKSEL XLCDDATAPORT            
        iorwf   XLCDDATAPORT,f 
    #endif
    #if XLCDNIBBLESEL   == 1
        swapf   _vXLCDreg1,f
        BANKSEL XLCDDATAPORT
        movlw   0x0F
        andwf   XLCDDATAPORT,f
        BANKSEL _vXLCDreg1
        movf    _vXLCDreg1,w
        BANKSEL XLCDDATAPORT
        iorwf   XLCDDATAPORT,F
    #endif
        BANKSEL XLCDDATAPORT
        bsf XLCDENPORT,XLCDENPIN
        nop
        nop
        nop
        bcf XLCDENPORT,XLCDENPIN
    
    return
;*********************************************************************
; Function          :XLCDL1home														
; PreCondition      :None																
; Overview          :used to point to 00 address in DDRam			      							
; Input             :None
; Output            :none															
; Side Effects      :Bank selection bits  are changed									
; Stack requirement :2 or 3 level deep depended on MpAM option
; Machine cycle     :depended on MpAM option													
;*********************************************************************
XLCDL1home:
    GLOBAL  XLCDL1home
    movlw   B'10000000'
    call    XLCDCommand
    return
;*********************************************************************
; Function          :XLCDL2home														
; PreCondition      :None																
; Overview          :used to point to 40H address in DDRam(second line)			      							
; Input             :None
; Output            :none															
; Side Effects      :Bank selection bits  are changed									
; Stack requirement :2 or 3 level deep depended on MpAM option
; Machine cycle     :depended on MpAM option 													
;*********************************************************************
XLCDL2home:
    GLOBAL  XLCDL2home
    movlw   B'11000000'
    call    XLCDCommand
    return
;*********************************************************************
; Function          :XLCDLClear														
; PreCondition      :None																
; Overview          :Clear DDram point to 00 address 			      							
; Input             :None
; Output            :none															
; Side Effects      :Bank selection bits  are changed									
; Stack requirement :2 or 3 level deep depended on MpAM option
; Machine cycle     :depended on MpAM option 													
;*********************************************************************
XLCDClear:
    GLOBAL  XLCDClear
    movlw   B'00000001'
    call    XLCDCommand
    return
;*********************************************************************
; Function          :XLCDReturnHome													
; PreCondition      :None																
; Overview          :Clear DDram point to 00 address 			      							
; Input             :None
; Output            :none															
; Side Effects      :Bank selection bits  are changed									
; Stack requirement :2 or 3 level deep depended on MpAM option
; Machine cycle     :depended on MpAM option													
;*********************************************************************
XLCDReturnHome:
    GLOBAL  XLCDReturnHome
    movlw   B'00000010'
    call    XLCDCommand
    return    

;*********************************************************************
; Function          :XLCDDelay5ms															
; PreCondition      :None																
; Overview          :(delay will be more in frequencies below 1MHz)
;                   :(will hold good for the range of 1MHz to 40MHz)				      							
; Input             :None
; Output            :give 5ms delay															
; Side Effects      :Bank selection bits and W are changed									
; Stack requirement :1 level deep													
;*********************************************************************
XLCDDelay5ms:
    GLOBAL  XLCDDelay5ms
    BANKSEL _vXLCDreg1
	clrf 	_vXLCDreg1
	clrf	_vXLCDreg2

#if	CLOCK_FREQ	>=.1000000	
;-----------------------------------------------------------------------
_n1= (((CLOCK_FREQ/.4)*.5)/.1000)/(.256*.3)
_n2= (((CLOCK_FREQ/.4)*.5)/.1000)%(.256*.3)	;getting the fractional value 
_n2=(_n2*.10)/(.256*.3)						;and if it is greater that .5
#if	_n2 >= 5								;increment the counter by 1 to
_n1=_n1+1								;get a better approximation
#endif
;-----------------------------------------------------------------------	
	movlw	_n1
	movwf	_vXLCDreg2	
_Loop5ms1
	decfsz	_vXLCDreg1,f
	goto	$-1
	decfsz	_vXLCDreg2,f
	goto	_Loop5ms1
	return
#endif
#if	CLOCK_FREQ	<.1000000	;below 1000KZ the delay increases with lower clock

	movlw	0x01
	movwf	_vXLCDreg2
_Loop5ms2	
	nop
	decfsz	_vXLCDreg1,f
	goto	_Loop5ms2
	decfsz	_vXLCDreg2,f
	goto	_Loop5ms2
	return
#endif    
;*********************************************************************
; Function          :XLCDDelay100us															
; PreCondition      :None																
; Overview          :(delay will be more in frequencies below 1MHz)
;                    (will hold good for the range of 1MHz to 40MHz)			      							
; Input             :None
; Output            :give 100ms delay															
; Side Effects      :Bank selection bits and W are changed									
; Stack requirement :1 level deep
; Machince cycle    :-----													
;*********************************************************************
XLCDDelay100us:
    GLOBAL  XLCDDelay100us
    BANKSEL _vXLCDreg1					
#if	CLOCK_FREQ	<= .30000000            ;if clock is below 1Mz delay will be more                   
_n3=((((((CLOCK_FREQ/.4)*.100))/.1000000))-.4)/.3
	
	movlw	_n3
	movwf	_vXLCDreg1
	
	decfsz	_vXLCDreg1,f
	goto	$-1
	return
#endif
#if	CLOCK_FREQ	> .3100000              ;for frequency above 30MHz
_n3=((((CLOCK_FREQ/.4)*.100))/.1000000)/.3
	
	movlw	0x02
	movwf	_vXLCDreg1
	
	movlw	LOW		_n3
	movwf	_vXLCDreg2
_Loop100us
	decfsz	_vXLCDreg2,f
	goto	$-1
	decfsz	_vXLCDreg1,f
	goto	_Loop100us
	return
#endif

;*********************************************************************
; Function          :XLCDDelay														
; PreCondition      :None																
; Overview          :Delay between commands			      							
; Input             :None
; Output            :none															
; Side Effects      :Bank selection bits  are changed									
; Stack requirement :1 level deep
; Machine cycle     :depended on MpAm option													
;*********************************************************************

    #if XLCDMODE ==1    ; if delay mode
XLCDDelay:
    GLOBAL  XLCDDelay
    BANKSEL _vXLCDtemp2
    movlw   XLCDDELAY +1
    movwf   _vXLCDtemp2


_XLCDDelayLoop
    BANKSEL _vXLCDtemp2
    decfsz   _vXLCDtemp2,f
    goto    XLCDLoopStart
    return
    
    
    
XLCDLoopStart				
#if	CLOCK_FREQ	<= .30000000
_temp3=((((((CLOCK_FREQ/.4)*.100))/.1000000))-.4)/.3
    BANKSEL _vXLCDreg1	
	movlw	_temp3
	movwf	_vXLCDreg1
	
	decfsz	_vXLCDreg1,f
	goto	$-1
	goto    _XLCDDelayLoop
#endif
#if	CLOCK_FREQ	> .3100000
_temp3=((((CLOCK_FREQ/.4)*.100))/.1000000)/.3
	BANKSEL _vXLCDreg1
	movlw	0x02
	movwf	_vXLCDreg1
	
	movlw	LOW		_temp3
	movwf	_vXLCDreg2
_XLCDDelayLoop1
	decfsz	_vXLCDreg2,f
	goto	$-1
	decfsz	_vXLCDreg1,f
	goto	_XLCDDelayLoop1
	goto    _XLCDDelayLoop
#endif
    #endif   ; if delay mode
;*********************************************************************
;****************************************************************************
; Function:     XLCDSendMsg
; PreCondition: System initialized
; Overview:
;               This procedure puts a message in the LCD, reading the string
;               until finding a \0.
; Input:        Pointer to start address in EEADRH:EEADR
; Output:
; Side Effects: Databank changed
; Stack requirement:
;****************************************************************************

XLCDSendMsg:
GLOBAL  XLCDSendMsg
        BANKSEL EECON1
        bsf     EECON1,EEPGD

SendNxtChar
        BANKSEL EECON1
        bsf     EECON1, RD

		NOP
		NOP

        BANKSEL EEDATA
        movf   	EEDATA, W

        btfsc   STATUS,Z
        return

        call    XLCDPut
        
        BANKSEL EEADR
        incfsz  EEADR
        goto    SendNxtChar
        incf    EEADRH
        goto    SendNxtChar 
;*********************************************************************
;    end
;*********************************************************************

;****************************************************************************
; Function:     XLCDSendMsgRAM
; PreCondition: System initialized
; Overview:
;               This procedure puts a message in the LCD, reading the string
;               until finding a \0.
; Input:        Pointer to start address in W reg.
; Output:
; Side Effects: Databank changed
; Stack requirement:
;****************************************************************************

XLCDSendMsgRAM:
GLOBAL  XLCDSendMsgRAM
		
		movwf	FSR

SendNxtChar_001

		
		movfw	INDF

        btfsc   STATUS,Z
        return

        call    XLCDPut

		incfsz	FSR        
		goto	SendNxtChar_001
		return

;*********************************************************************
;****************************************************************************
; Function:     SetCursorPos
; PreCondition: System initialized
; Overview:
;               This procedure positioning the LCD cursor
; Input:        The new cursor position on w reg
; Output:
; Side Effects: Databank changed
; Stack requirement:
;****************************************************************************

XLCDSetCursorPos:
GLOBAL  XLCDSetCursorPos

	iorlw	B'10000000'
    call    XLCDCommand
    return
;*********************************************************************
;    end
;*********************************************************************

