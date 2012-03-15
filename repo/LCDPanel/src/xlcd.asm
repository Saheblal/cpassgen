

	ERRORLEVEL 1, -302, -205
	
	#define     XLCD_Source
	#include    "xlcd.inc"
   
    #define     _ADD_PROC_INC_FILE
	#define     _GEN_MODULE_ERROR
    #include    "P16xxx.inc"			
    #include    "P18xxx.inc"
	
	;valriables defenitions(loacal _v, global v)
    UDATA	
_vXLCDreg1      res 1
_vXLCDreg2      res 1
_vXLCDreg3      res 1			
_vXLCDreg4	res	1
_vXLCDtemp1     res 1
_vXLCDtemp2     res 1   ;used in XLCDDelay
_vXLCDStatus    res 1	
;***********************************************;

	#ifdef  _PIC18xxx			
    include "18XLCD.asm"			
	#endif					
						
	#ifdef  _PIC16xxx			
    include "16XLCD.asm"			
	#endif					
						
						
;***********************************************;
    end
