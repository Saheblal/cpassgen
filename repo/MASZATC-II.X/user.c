/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

#include <htc.h>            /* HiTech General Includes */
#include <stdint.h>         /* For uint8_t definition */
#include <stdbool.h>        /* For true/false definition */

#include "user.h"

/******************************************************************************/
/* User Functions                                                             */
/******************************************************************************/

/* <Initialize variables in user.h and insert code for user algorithms.> */

char* PrintBin(char* buffer, unsigned char data)
{   int i; int ccode;
    for (i = 0; i < 8; i++)
    {
        if (data & 0x080) ccode = 1;
        else ccode = 0;
        buffer[i] = 0b00110000 + ccode;// + ((data && 0x80) >> 8);
        data <<= 1;
    }
    buffer [i+1] = '\0';
    return buffer;
}

void InitApp(void)
{
    /* TODO Initialize User Ports/Peripherals/Project here */

    /* Setup analog functionality and port direction */

    ADCON1bits.PCFG = 0b0110;

    /* Initialize peripherals */

    TRISAbits.TRISA4 = 0;
    TRISAbits.TRISA5 = 0;
    
    LCDInit();
    
    /* Enable interrupts */
}

