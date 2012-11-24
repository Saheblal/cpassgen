/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

#include <plib.h>            /* Include to use PIC32 peripheral libraries     */
#include <stdint.h>          /* For uint32_t definition                       */
#include <stdbool.h>         /* For true/false definition                     */
#include <time.h>
#include "user.h"            /* variables/params used by user.c               */
#include "system.h"         /* timer functions                              */
#include "graphics/StaticText.h"    /* Statictext for StartTerminal window. */

/******************************************************************************/
/* User Functions                                                             */
/******************************************************************************/

XCHAR TextLabel[20] = { 'S','t','a','r','t', 0};

/*InitStartTerminal: initialize the start terminal view to follow the start
 * advance for
 * initialization.
 * RETURN VALUE: terminal static text view.
 * INPUT VALUE: none.
 */

STATICTEXT *InitStartTerminal(void)
{
    SHORT left = 0, top = 0, right = 299, bottom = 199;
    int state = ST_DRAW | ST_FRAME | ST_CENTER_ALIGN;
    STATICTEXT* retval;
    retval = StCreate(ID_START_TEXT, left, top, right, bottom, state, TextLabel, _pDefaultGolScheme);
    return retval;
/*    if (retval)
    {
        if (StDraw(retval))
        {
//            START_TERMINAL_AVE[2] = IDENT[0] + 0x020;
            StSetText(retval, START_TERMINAL_AVE);
            StDraw(retval);
        }
        return retval;
    };
    return NULL;*/
};

/* TODO Initialize User Ports/Peripherals/Project here */

void InitApp(void)
{
    /* Setup analog functionality and port direction */

    // enable multi-vector interrupts
    INTEnableSystemMultiVectoredInt();

    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // STEP 2. configure Timer 1 using internal clock, 1:256 prescale

    OpenTimer1(T1_ON | T1_SOURCE_INT | T1_PS_1_1, T1_TICK);

    // set up the timer interrupt with a priority of 2
    ConfigIntTimer1(T1_INT_ON | T1_INT_PRIOR_2);
    
    /* Zero to DELAY_COUNTER for Delay procedure. */
    StartTimer();

    /* Initialize peripherals */

    DisplayBacklightConfig();

//#if defined WANT_GOL_INIT
    GOLInit();
//#endif

//    TouchInit(NULL,NULL,NULL,NULL);

    DisplayBacklightOn();

    SPIFlashInit();
    
// initialize the components for Resistive Touch Screen
//#if defined WANT_TOUCH_INIT
//    TouchInit(NULL,NULL,NULL,NULL);
//#endif
//    SDCARDInit();
//    MP3Init();

    /* PORT Init                                                            */
    /* PORTD 0-3 bits inputs.                                               */
    /* PORTA 0-1 bits outputs.                                              */

    /* TODO Must be disable the JTAG port, that we are to appropriate using */
    /* RA0, and RA1 ports.  */

    DDPCONbits.JTAGEN = 0;  /* JTAG debug disabled */
    /* TODO D port output now !!!! */
    TRISDbits.TRISD14 = TRISDbits.TRISD15 = 0;
        /* Port D 14, 15, pins pull up resistor enabled */
//    CNPUEbits.CNPUE20 = CNPUEbits.CNPUE21 = 1;
    TRISAbits.TRISA0 = TRISAbits.TRISA1 = 0;

}
