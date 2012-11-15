/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

#include <plib.h>            /* Include to use PIC32 peripheral libraries     */
#include <stdint.h>          /* For uint32_t definition                       */
#include <stdbool.h>         /* For true/false definition                     */
#include <time.h>
#include "user.h"            /* variables/params used by user.c               */
#include "system.h"         /* timer functions                              */

/******************************************************************************/
/* User Functions                                                             */
/******************************************************************************/

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

}
