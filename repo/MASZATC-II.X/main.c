/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

#include <htc.h>           /* Global Header File */
#include <stdint.h>        /* For uint8_t definition */
#include <stdbool.h>       /* For true/false definition */

#include "system.h"        /* System funct/params, like osc/peripheral config */
#include "user.h"          /* User funct/params, such as InitApp */
#include "xlcd.h"
#include "dtime.h"
//#include "main.h"

/******************************************************************************/
/* User Global Variable Declaration                                           */
/******************************************************************************/

struct Struct_Buttons Buttons;

/* i.e. uint8_t <variable_name>; */

unsigned char InButton()
{   unsigned char OLD_TRISD, OLD_PORTD;
    unsigned char result_high, result_low;
    OLD_TRISD = TRISD;
    OLD_PORTD = PORTD;
    TRISD = 0b11001111;
    PORTDbits.RD4 = 1;
    PORTDbits.RD5 = 0;
    result_high = (PORTD & 0x0F) << 4;
    PORTDbits.RD4 = 0;
    PORTDbits.RD5 = 1;
    result_low = PORTD & 0x0F;
    PORTD = OLD_PORTD;
    TRISD = OLD_TRISD;
    return (result_high | result_low);
};


char txt[] = "This is a text.\0";

/******************************************************************************/
/* Main Program                                                               */
/******************************************************************************/

uint8_t main(void)
{   unsigned char inbutton, old_inbutton;
    char bbuffer[10];
    /* Configur;e the oscillator for the device */
    ConfigureOscillator();

    /* Initialize I/O and Peripherals for application */
    InitApp();


    /* Global interrupt enabled */

    INTCONbits.GIE = 1;

    old_inbutton = 0x01;
    while(1)
    {
        inbutton = InButton();
/*        if (inbutton & 0x01)
        {
            T1CONbits.TMR1ON = 1;
        }else
        {
            T1CONbits.TMR1ON = 0;
        };*/

        inbutton = int_counter;
        if (inbutton != old_inbutton)
        {
//            LCDClear();
            CursorHome();
            PrintBin(bbuffer, inbutton);
            LCDWrite(bbuffer);
//            LCDWrite(txt);
//            PORTB = inbutton;
            old_inbutton = inbutton;
        }
    }
    return 0;
}

