/*********************************************************************
 *
 *	MIKROE PIC32MX hardware definition file.
 *
 *********************************************************************
 * FileName:        HWP_MIKROE_PIC32_GP_SK_16PMP.h
 * Processor:       PIC32
 *
 */

#ifndef __HARDWARE_PROFILE_H
    #define __HARDWARE_PROFILE_H

/*********************************************************************
* PIC Device Specific includes
*********************************************************************/
    #include "Compiler.h"

/*********************************************************************
* GetSystemClock() returns system clock frequency.
*
* GetPeripheralClock() returns peripheral clock frequency.
*
* GetInstructionClock() returns instruction clock frequency.
*
********************************************************************/

/*********************************************************************
* Macro: #define	GetSystemClock() 
*
* Overview: This macro returns the system clock frequency in Hertz.
*			* value is 8 MHz x 4 PLL for PIC24
*			* value is 8 MHz/2 x 18 PLL for PIC32
*
********************************************************************/

#define GetSystemClock()    (80000000ul)

/*********************************************************************
* Macro: #define	GetPeripheralClock() 
*
* Overview: This macro returns the peripheral clock frequency 
*			used in Hertz.
*			* value for PIC24 is <PRE>(GetSystemClock()/2) </PRE> 
*			* value for PIC32 is <PRE>(GetSystemClock()/(1<<OSCCONbits.PBDIV)) </PRE>
*
********************************************************************/

#define GetPeripheralClock()    (GetSystemClock() / (1 << OSCCONbits.PBDIV))

/*********************************************************************
* Macro: #define	GetInstructionClock() 
*
* Overview: This macro returns instruction clock frequency 
*			used in Hertz.
*			* value for PIC24 is <PRE>(GetSystemClock()/2) </PRE> 
*			* value for PIC32 is <PRE>(GetSystemClock()) </PRE> 
*
********************************************************************/

#define GetInstructionClock()   (GetSystemClock())

/* ################################################################## */
/*********************************************************************
* START OF GRAPHICS RELATED MACROS
********************************************************************/
/* ################################################################## */

/*********************************************************************
* AUTO GENERATED CODE 
********************************************************************/

//Auto Generated Code
#define MIKRO_BOARD
#define USE_16BIT_PMP
//#define PIC32_GP_SK
#define GFX_USE_DISPLAY_CONTROLLER_HX8347D
//End Auto Generated Code

/*********************************************************************
* END OF AUTO GENERATED CODE 
********************************************************************/

#if defined(MIKRO_BOARD) 
       #define      USE_M25P80                        // use the 8 Mbit SPI Serial Flash
       #define      USE_TOUCHSCREEN_RESISTIVE         // use 4-wire resistive touch screen driver
#endif


/*********************************************************************
* DISPLAY PARAMETERS 
*********************************************************************/
/*
    The following are the parameters required for the 
    different display drivers that is supported.
    When adding support to a new display controller or display panel,
    follow the parameterization of the driver for reusability of the
    driver.

    Display Parameter Macros Descriptions:
    
    1. DISP_ORIENTATION - defines the display rotation with
            respect to its native orientation. For example, if the display 
            has a resolution specifications that says 240x320 (QVGA), the
            display is natively in portrait mode. If the application
            uses the display in landscape mode (320x240), then the 
            orientation musts be defined as 90 or 180 degree rotation.
            The Graphics Library will calculate the actual pixel location
            to rotate the contents of the screen. So when users view the 
            display, the image on the screen will come out in the correct
            orientation.
            
            Valid values: 0, 90, 180 and 270
            Example: #define DISP_ORIENTATION 90

    2. DISP_HOR_RESOLUTION - defines the horizontal dimension in pixels. This 
            is the native horizontal dimension of the screen. In the example
            given in DISP_ORIENTATION, a 320x240 display will have DISP_HOR_RESOLUTION
            of 320.
            
            Valid Values: dependent on the display glass resolution used.
            Example: #define DISP_HOR_RESOLUTION 320 

    3. DISP_VER_RESOLUTION - defines the vertical dimension in pixels. This 
            is the native vertical dimension of the screen. In the example
            given in DISP_ORIENTATION, a 320x240 display will have DISP_VER_RESOLUTION
            of 240.
            
            Valid Values: dependent on the display glass resolution used.
            Example: #define DISP_VER_RESOLUTION 240 

    4. COLOR_DEPTH - (NOTE: Define this macro in the GraphicsConfig.h 
             This defines the vertical dimension in pixels. 
            
            Valid Values: 1, 4, 8, 16, 24 (note 24 bpp is only used if you are 
                          using a Display Driver that supports 24 bpp color depth.
            Example: #define COLOR_DEPTH 16 

    5. DISP_DATA_WIDTH - this defines the display controller physical interface 
            to the display panel. 

            Valid Values: 1, 4, 8, 16, 18, 24 
                          1, 4, 8 are usually used in MSTN and CSTN displays
                          16, 18 and 24 are usually used in TFT displays.
            Example: #define DISP_DATA_WIDTH 18 
    
    6. DISP_INV_LSHIFT - this indicates that the color data is sampled in the
            falling edge of the pixel clock. 

            Example: #define DISP_INV_LSHIFT - define this to sample the
                          color data in the falling edge of the pixel clock.
    
    7. DISP_HOR_PULSE_WIDTH - this defines the horizontal sync signal pulse width. 

            Valid Values: See display panel data sheet                           
            Example: #define DISP_HOR_PULSE_WIDTH 25 
  
    8. DISP_VER_PULSE_WIDTH - this defines the vertical sync signal pulse width. 

            Valid Values: See display panel data sheet                           
            Example: #define DISP_VER_PULSE_WIDTH 4
            
    9. DISP_HOR_BACK_PORCH - this defines the horizontal back porch. 
            DISP_HOR_BACK_PORCH + DISP_HOR_FRONT_PORCH + DISP_HOR_PULSE_WIDTH
            makes up the horizontal blanking period.

            Valid Values: See display panel data sheet                           
            Example: #define DISP_HOR_BACK_PORCH 5

    10. DISP_HOR_FRONT_PORCH - this defines the horizontal front porch. 
            DISP_HOR_BACK_PORCH + DISP_HOR_FRONT_PORCH + DISP_HOR_PULSE_WIDTH
            makes up the horizontal blanking period.

            Valid Values: See display panel data sheet                           
            Example: #define DISP_HOR_FRONT_PORCH 10

    11. DISP_VER_BACK_PORCH - this defines the vertical back porch. 
            DISP_VER_BACK_PORCH + DISP_VER_FRONT_PORCH + DISP_VER_PULSE_WIDTH
            makes up the horizontal blanking period.

            Valid Values: See display panel data sheet                           
            Example: #define DISP_VER_BACK_PORCH 0

    12. DISP_VER_FRONT_PORCH - this defines the horizontal front porch. 
            DISP_VER_BACK_PORCH + DISP_VER_FRONT_PORCH + DISP_VER_PULSE_WIDTH
            makes up the horizontal blanking period.

            Valid Values: See display panel data sheet                           
            Example: #define DISP_VER_FRONT_PORCH 2
            
    13. GFX_LCD_TYPE - this defines the type of display glass used. 
            
            Valid Values: Dependent on the display controller supported LCD types.
                          GFX_LCD_TFT  // Type TFT Display 
                          GFX_LCD_CSTN // Type Color STN Display 
                          GFX_LCD_MSTN // Type Mono STN Display 
                          GFX_LCD_OLED // Type OLED Display

            Example: #define GFX_LCD_TYPE GFX_LCD_TFT

    14. GFX_DISPLAYENABLE_ENABLE - this enables the use of the Display Enable Port 
            (GEN) when using the Microchip Graphics Module. The signal required when 
            using a display panel that supports DATA ENABLE Mode. DATA ENABLE Mode 
            is used when the display panel do not have sync (HSYNC and VSYNC) signals.
            
            Example: #define GFX_DISPLAYENABLE_ENABLE

    15. GFX_DISPLAYENABLE_POLARITY - this sets the polarity of the Display Enable Port 
            (GEN) when using the Microchip Graphics Module. 
            
            Valid Values: GFX_ACTIVE_HIGH, GFX_ACTIVE_LOW
            Example: #define GFX_DISPLAYENABLE_POLARITY GFX_ACTIVE_HIGH
            
    16. GFX_HSYNC_ENABLE - this enables the use of the Display Horizontal Synchronization 
            Port (HSYNC) when using the Microchip Graphics Module. The signal required when 
            using a display panel that supports SYNC Mode. SYNC Mode 
            is used when the display panel has sync (HSYNC and VSYNC) signals.
            
            Example: #define GFX_HSYNC_ENABLE

    17. GFX_HSYNC_POLARITY - this sets the polarity of the Display Horizontal Synchronization 
            Port (HSYNC)when using the Microchip Graphics Module. 
            
            Valid Values: GFX_ACTIVE_HIGH, GFX_ACTIVE_LOW
            Example: #define GFX_HSYNC_POLARITY GFX_ACTIVE_LOW

    18. GFX_VSYNC_ENABLE - this enables the use of the Display Vertical Synchronization 
            Port (VSYNC) when using the Microchip Graphics Module. The signal required when 
            using a display panel that supports SYNC Mode. SYNC Mode 
            is used when the display panel has sync (HSYNC and VSYNC) signals.
            
            Example: #define GFX_VSYNC_ENABLE

    19. GFX_VSYNC_POLARITY - this sets the polarity of the Display Vertical Synchronization
            Port (VSYNC)when using the Microchip Graphics Module. 
            
            Valid Values: GFX_ACTIVE_HIGH, GFX_ACTIVE_LOW
            Example: #define GFX_VSYNC_POLARITY GFX_ACTIVE_LOW

    20. GFX_DISPLAYPOWER_ENABLE - this enables the use of the Display Power Sequencer 
            Control Port (GPWR) when using the Microchip Graphics Module. The signal 
            can be used to control the display power circuitry. The Graphics Module
            can manage the powering up and powering down of the display since 
            power up and power down sequence in display panels is essential to 
            extend display life cycle.
            
            Example: #define GFX_DISPLAYPOWER_ENABLE
            
    21. GFX_DISPLAYPOWER_POLARITY - this sets the polarity of the Display Power Sequencer 
            Control Port (GPWR) when using the Microchip Graphics Module. 
            
            Valid Values: GFX_ACTIVE_HIGH, GFX_ACTIVE_LOW
            Example: #define GFX_DISPLAYPOWER_POLARITY GFX_ACTIVE_HIGH
            
    22. GFX_CLOCK_POLARITY - this sets the polarity of the Display Glass Clock Port (GCLK) 
            when using the Microchip Graphics Module. 
            
            Valid Values: GFX_ACTIVE_HIGH, GFX_ACTIVE_LOW
            Example: #define GFX_CLOCK_POLARITY GFX_ACTIVE_HIGH
            
    
    There are two major types of controllers enumerated here:
    1. Controllers in Smart Displays - these are display modules that have  
       built in display controller. Interface to the PIC device(s) 
       are usually through parallel interface or serial interface.
       
       Required parameters:
       #define DISP_ORIENTATION 
       #define DISP_HOR_RESOLUTION 
       #define DISP_VER_RESOLUTION 
       
    2. Controller that drives the RGB Glass directly - these are display 
       controllers that comes in a separate package or built into the
       microcontrollers.
    
       Required parameters:
       #define DISP_ORIENTATION 
       #define DISP_HOR_RESOLUTION 
       #define DISP_VER_RESOLUTION 
       #define DISP_DATA_WIDTH			
       #define DISP_HOR_PULSE_WIDTH    
       #define DISP_HOR_BACK_PORCH     
       #define DISP_HOR_FRONT_PORCH    
       #define DISP_VER_PULSE_WIDTH    
       #define DISP_VER_BACK_PORCH     
       #define DISP_VER_FRONT_PORCH    

       Optional parameters:       
       #define DISP_INV_LSHIFT

       When using Microchip Graphics Module (mchpGfxDrv) required parameters:
       #define GFX_DISPLAYENABLE_ENABLE
       #define GFX_DISPLAYENABLE_POLARITY          
       
       or 
       
       #define GFX_HSYNC_ENABLE
       #define GFX_VSYNC_ENABLE
       #define GFX_HSYNC_POLARITY                  
       #define GFX_VSYNC_POLARITY                  

       #define GFX_CLOCK_POLARITY                  

       When using Microchip Graphics Module (mchpGfxDrv) Optional parameters:       
       #define GFX_DISPLAYPOWER_ENABLE
       #define GFX_DISPLAYPOWER_POLARITY           
      
    
*/

// Using HX8347D Display Controller
#if defined(GFX_USE_DISPLAY_CONTROLLER_HX8347D)
    #define DISP_ORIENTATION    90
    #define DISP_HOR_RESOLUTION 240
    #define DISP_VER_RESOLUTION 320
#endif

#define GFX_USE_TCON_CUSTOM

/*********************************************************************
* DISPLAY PARALLEL INTERFACE 
*********************************************************************/
/*
   Select the correct Parallel Master Port Interface Driver.
   This selection is valid only for parallel interface. When using
   display drivers that uses serial interface, this portion should be
   commented out or removed.
*/
#define USE_GFX_PMP

/*********************************************************************
* PARALLEL MASTER PORT INTERFACE TIMING 
*********************************************************************/
	// When using the Parallel Master Port (or Enhanced Parallel Master Port) the 
	// PMP timing must be defined for the following:
	// PMP_DATA_SETUP_TIME or EPMPCSx_DATA_SETUP (for DWAITB) 
	// PMP_DATA_WAIT_TIME or EPMPCSx_DATA_WAIT_TIME (for DWAITM) 
	// and PMP_DATA_HOLD_TIME or EPMPCSx_DATA_HOLD_TIME (for DWAITE)
    // where x is 1 or 2 (EPMP has 2 chip selects)
	// All values are timing parameters in ns.
	// The timing is dependent on the display controller sampling period if 
	// interfacing with the display controller or device AC timing requirements
	// if interfacing with a device (such as SRAM or Parallel Flash memory).
	// Refer to your specific display controller or device to determine the 
	// optimum (fastest) timing requirement for your interface. 

#define PMP_DATA_SETUP_TIME                (18)    
#define PMP_DATA_WAIT_TIME                 (82)  // See HX8347 data sheet for details     
#define PMP_DATA_HOLD_TIME                 (0)    

/*********************************************************************
* HARDWARE PROFILE FOR DISPLAY CONTROLLER INTERFACE
*********************************************************************/
        // default setting is logic low  
#define BACKLIGHT_ENABLE_LEVEL      0
#define BACKLIGHT_DISABLE_LEVEL     1

typedef enum
{
    ANSEL_DIGITAL = 0,
    ANSEL_ANALOG = 1
}ANSEL_BIT_STATE;
    
    
    // Definitions for reset pin
#define DisplayResetConfig()        TRISCbits.TRISC1 = 0    
#define DisplayResetEnable()        LATCbits.LATC1 = 0
#define DisplayResetDisable()       LATCbits.LATC1 = 1

    // Definitions for RS pin
#define DisplayCmdDataConfig()      TRISBbits.TRISB15 = 0
#define DisplaySetCommand()         LATBbits.LATB15 = 0
#define DisplaySetData()            LATBbits.LATB15 = 1

    // Definitions for CS pin
#define DisplayConfig()             TRISFbits.TRISF12 = 0             
#define DisplayEnable()             LATFbits.LATF12 = 0
#define DisplayDisable()            LATFbits.LATF12 = 1

    // Definitions for FLASH CS pin
#define DisplayFlashConfig()       
#define DisplayFlashEnable()       
#define DisplayFlashDisable()      

    // Definitions for POWER ON pin
#define DisplayPowerConfig()       
#define DisplayPowerOn()           
#define DisplayPowerOff()          

    // Definitions for backlight control pin
#define DisplayBacklightConfig()      TRISAbits.TRISA9  = 0
#define DisplayBacklightOn()          LATAbits.LATA9    = 1
#define DisplayBacklightOff()         LATAbits.LATA9    = 0

// end of #elif defined (MIKRO_BOARD)

/*********************************************************************
* HARDWARE PROFILE FOR THE RESISTIVE TOUCHSCREEN 
*********************************************************************/
/*
	These are the hardware settings for the 4-wire resistive
	touch screen. There are two analog inputs and two digital I/Os
	needed. 
	
	This portion is divided into 3 components
	1. IO and ADC channels settings - sets up the IO pins used and the
	   ADC channel selected to evaluate the screen touch. 
	2. Touch Screen X and Y orientation settings - sets up the
	   x and y directions. This is dependent on how the resistive
	   touch signals (X-, Y-, X+, and Y+) are wired up to the 
	   IOs and ADC signals with respect to the orientation of the
	   screen. Based on these factors, we can control the calculation
	   of the touch by swapping x and/or y and flipping the x and/or y 
	   directions.
	3. Touch Screen Non-Volatile Memory Storage Macros - this defines
	   the non-volatile memory read, write and sector erase functions
	   to be used when reading or storing calibration values.    
	
	The resistive touch screen driver assumes the following: 
	1. X+ and Y+ are mapped to the A/D inputs
	2. X- and Y- are mapped to the pure digital I/Os
*/

#if defined (USE_TOUCHSCREEN_RESISTIVE)

	/*********************************************************************
	* Resistive Touch Screen A/D and I/O Specific Macros 
	*********************************************************************/
#define TOUCH_ADC_INPUT_SEL   AD1CHS

	// ADC Sample Start 
#define TOUCH_ADC_START   AD1CON1bits.SAMP 

	// ADC Status
#define TOUCH_ADC_DONE   AD1CON1bits.DONE

#define ADC_XPOS    ADC_CH0_POS_SAMPLEA_AN11
#define ADC_YPOS    ADC_CH0_POS_SAMPLEA_AN10

	        // X port definitions
#define ResistiveTouchScreen_XPlus_Drive_High()         LATBbits.LATB13   = 1
#define ResistiveTouchScreen_XPlus_Drive_Low()          LATBbits.LATB13   = 0
#define ResistiveTouchScreen_XPlus_Config_As_Input()    TRISBbits.TRISB13 = 1
#define ResistiveTouchScreen_XPlus_Config_As_Output()   TRISBbits.TRISB13 = 0

#define ResistiveTouchScreen_XMinus_Drive_High()        LATBbits.LATB11   = 1
#define ResistiveTouchScreen_XMinus_Drive_Low()         LATBbits.LATB11   = 0
#define ResistiveTouchScreen_XMinus_Config_As_Input()   TRISBbits.TRISB11 = 1
#define ResistiveTouchScreen_XMinus_Config_As_Output()  TRISBbits.TRISB11 = 0

        	// Y port definitions
#define ResistiveTouchScreen_YPlus_Drive_High()         LATBbits.LATB12   = 1
#define ResistiveTouchScreen_YPlus_Drive_Low()          LATBbits.LATB12   = 0
#define ResistiveTouchScreen_YPlus_Config_As_Input()    TRISBbits.TRISB12 = 1
#define ResistiveTouchScreen_YPlus_Config_As_Output()   TRISBbits.TRISB12 = 0

#define ResistiveTouchScreen_YMinus_Drive_High()        LATBbits.LATB10   = 1
#define ResistiveTouchScreen_YMinus_Drive_Low()         LATBbits.LATB10   = 0
#define ResistiveTouchScreen_YMinus_Config_As_Input()   TRISBbits.TRISB10 = 1
#define ResistiveTouchScreen_YMinus_Config_As_Output()  TRISBbits.TRISB10 = 0

	/*********************************************************************
	* Touch Screen X and Y orientation
	*********************************************************************/
	/*********************************************************************
	Description:
		The usage of the resistive touch screen will be affected 
		by the way the hardware is mapped to the A/D channels that
		samples the touch. Since resistive touch is basically a 
		measurement of X and Y coordinates the following are macros
		that can modify the touch algorithm when sampling the 
		touch.
		TOUCHSCREEN_RESISTIVE_FLIP_X - will flip the x direction. 	
		TOUCHSCREEN_RESISTIVE_FLIP_Y - will flip the y direction.
		TOUCHSCREEN_RESISTIVE_SWAP_XY - will swap the x and y sampling.
		
		As long as the (X-,Y-) and (X+,Y+) are used consistently,
		and connected properly in hardware, the macros above
		can provide options to the user to align the touch screen
		to the screen orientation.

        Another macro that may affect the way the x and y measurement 
        are the following:
        TOUCHSCREEN_RESISTIVE_PRESS_THRESHOLD - determines how light the 
            touch on the screen. The smaller the  value the lighter the 
            touch. Valid range of values: 0-0x03ff
        TOUCHSCREEN_RESISTIVE_CALIBRATION_SCALE_FACTOR - this is the scale
            factor used to calculate the touch coefficients. The equation 
            to calculate the scale factor is:
               (1 << TOUCHSCREEN_RESISTIVE_CALIBRATION_SCALE_FACTOR).
            Valid values: 0 - 15 (most resistive touch screens will work 
                                  in the range of 5 - 7)
    */
#define TOUCHSCREEN_RESISTIVE_PRESS_THRESHOLD           500
#define TOUCHSCREEN_RESISTIVE_CALIBRATION_SCALE_FACTOR  6
	
	/*********************************************************************
	* Touch Screen Non-Volatile Memory Storage Macros
	*********************************************************************/

#define ADDRESS_RESISTIVE_TOUCH_VERSION	(unsigned long)0xFFFEE
#define ADDRESS_RESISTIVE_TOUCH_BUF   (unsigned long)0xFFFF0
#define ADDRESS_RESISTIVE_TOUCH_ULX   (unsigned long)0xFFFF0
#define ADDRESS_RESISTIVE_TOUCH_ULY   (unsigned long)0xFFFF2
#define ADDRESS_RESISTIVE_TOUCH_URX   (unsigned long)0xFFFF3
#define ADDRESS_RESISTIVE_TOUCH_URY   (unsigned long)0xFFFF4
#define ADDRESS_RESISTIVE_TOUCH_LLX   (unsigned long)0xFFFF5
#define ADDRESS_RESISTIVE_TOUCH_LLY   (unsigned long)0xFFFF6
#define ADDRESS_RESISTIVE_TOUCH_LRX   (unsigned long)0xFFFF7
#define ADDRESS_RESISTIVE_TOUCH_LRY   (unsigned long)0xFFFF8

       // define the functions to call for the non-volatile memory
        // check out touch screen module for definitions of the following function pointers
        // used: NVM_READ_FUNC, NVM_WRITE_FUNC & NVM_SECTORERASE_FUNC
/*#define NVMSectorErase              ((NVM_SECTORERASE_FUNC)&SST25SectorErase)
#define NVMWrite                    ((NVM_WRITE_FUNC)&SST25WriteWord)
#define NVMRead                     ((NVM_READ_FUNC)&SST25ReadWord)*/

/*********************************************************************
* HARDWARE PROFILE FOR THE SPI FLASH MEMORY
*********************************************************************/
/*
	These are the hardware settings for the SPI peripherals used.
*/

/*#define MCHP25LC256_CS_TRIS  TRISDbits.TRISD12
#define MCHP25LC256_CS_LAT   LATDbits.LATD12*/

	/*********************************************************************
	* SPI Flash Memory on MIKRO_BOARD
	*********************************************************************/
	// Set up the signals used to communicate to the SPI Flash device 

/* Define the M25P80 flash mem's SPI channel number (SPI2) */
#define FLASH_MEM_SPI_CHANNEL 2


/* Define wired chip select line of flash memory, and its tris bits. */
//#define FLASH_MEM_CS_TRIS   TRISCbits.TRISC2
//#define FLASH_MEM_CS_LAT    LATCbits.LATC2
/*#define SST25_SCK_TRIS  TRISGbits.TRISG6
#define SST25_SDO_TRIS  TRISGbits.TRISG8
#define SST25_SDI_TRIS  TRISGbits.TRISG7*/

/*********************************************************************
* IOS FOR THE SWITCHES (SIDE BUTTONS)
*********************************************************************/
typedef enum
{
    HW_BUTTON_PRESS = 0,
    HW_BUTTON_RELEASE = 1
}HW_BUTTON_STATE;

#define HardwareButtonInit()
#define GetHWButtonProgram()        (HW_BUTTON_RELEASE)
#define GetHWButtonScanDown()       (HW_BUTTON_RELEASE)
#define GetHWButtonScanUp()         (HW_BUTTON_RELEASE)
#define GetHWButtonCR()             (HW_BUTTON_RELEASE)
#define GetHWButtonFocus()          (HW_BUTTON_RELEASE)


/*********************************************************************
* IOS FOR THE UART
*********************************************************************/
#define TX_TRIS TRISFbits.TRISF5
#define RX_TRIS TRISFbits.TRISF4

/*********************************************************************
* RTCC DEFAULT INITIALIZATION (these are values to initialize the RTCC
*********************************************************************/
#define RTCC_DEFAULT_DAY        13      // 13th
#define RTCC_DEFAULT_MONTH      2       // February
#define RTCC_DEFAULT_YEAR       12      // 2012
#define RTCC_DEFAULT_WEEKDAY    1       // Monday
#define RTCC_DEFAULT_HOUR       10      // 10:10:01
#define RTCC_DEFAULT_MINUTE     10
#define RTCC_DEFAULT_SECOND     1

#endif
#endif // __HARDWARE_PROFILE_H


