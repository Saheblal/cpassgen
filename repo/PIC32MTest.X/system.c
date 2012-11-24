/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

#include <plib.h>            /* Include to use PIC32 peripheral libraries     */
#include <stdint.h>          /* For uint32_t definition                       */
#include <stdbool.h>         /* For true/false definition                     */
#include "system.h"          /* variables/params used by system.c             */

/******************************************************************************/
/* System Level Functions                                                     */
/*                                                                            */
/* Custom oscillator configuration funtions, reset source evaluation          */
/* functions, and other non-peripheral microcontroller initialization         */
/* functions get placed in system.c                                           */
/*                                                                            */
/******************************************************************************/

/* <Initialize variables in system.h and put code for system algorithms here.>*/

/**************************TIMER procedures and functions *********************/

/* StartTimer start 10usec counter */
void StartTimer()
{
    DELAY_COUNTER_10USEC = 0;
};

/* Get 10usec timer value. */
uint GetTimer()
{
    return DELAY_COUNTER_10USEC;
};

WORD GetMillisec()
{
    return (DELAY_COUNTER_10USEC / 100);
}

uchar Delay10us(uint usec10)
{
    StartTimer();
    while (GetTimer() < usec10) ;
};

uchar DelayMs(uint MSec)
{
    StartTimer();
    while (GetTimer() < (MSec * 100));
};