/******************************************************************************/
/* System Level #define Macros                                                */
/******************************************************************************/

#ifndef _SYSTEM_H
#define _SYSTEM_H

typedef unsigned int uint;
typedef unsigned char uchar;

/* TODO Define system operating frequency */

/* Microcontroller MIPs (FCY) */
#define SYS_FREQ     80000000L
#define FCY          SYS_FREQ

extern uint DELAY_COUNTER_10USEC;
extern uint DELAY_COUNTER_MSEC;

/******************************************************************************/
/* System Function Prototypes                                                 */
/******************************************************************************/

/* Custom oscillator configuration funtions, reset source evaluation
functions, and other non-peripheral microcontroller initialization functions
go here. */

/* StartTimer start 10usec counter 

void StartTimer();

/* Get 10usec timer value. 

uint GetTimer();*/

/* */

uchar Delay10us(uint);
uchar DelayMs(uint);

#endif