
#if !defined (_SYSTEM_H)
#define _SYSTEM_H

/******************************************************************************/
/* System Level #define Macros                                                */
/******************************************************************************/

typedef unsigned int uint;
typedef unsigned char uchar;

/* TODO Define system operating frequency */

/* Microcontroller MIPs (FCY) */
#define SYS_FREQ     80000000L
#define FCY          SYS_FREQ

/******************************************************************************/
/* System Function Prototypes                                                 */
/******************************************************************************/

extern uint DELAY_COUNTER_10USEC;
extern uint DELAY_COUNTER_MSEC;

/* Custom oscillator configuration funtions, reset source evaluation
functions, and other non-peripheral microcontroller initialization functions
go here. */

#endif
