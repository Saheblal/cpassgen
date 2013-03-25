/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

#include <p30Fxxxx.h>      /* Device header file                              */
#include <stdint.h>        /* Includes uint16_t definition                    */
#include <stdbool.h>       /* Includes true/false definition                  */

#include "system.h"        /* System funct/params, like osc/peripheral config */
#include "user.h"          /* User funct/params, such as InitApp              */

/******************************************************************************/
/* Global Variable Declaration                                                */
/******************************************************************************/

/* i.e. uint16_t <variable_name>; */

/******************************************************************************/
/* Main Program                                                               */
/******************************************************************************/

#define COUNTER 1000

int16_t main(void)
{

    int i;

    /* Configure the oscillator for the device */
    ConfigureOscillator();

    /* Initialize IO ports and peripherals */
    InitApp();

    /* TODO <INSERT USER APPLICATION CODE HERE> */

    while(1)
    {
        H1_LAT = 1;
        for (i = 0; i < COUNTER; i++)
        {
            V5_LAT = 0;
        }
        H1_LAT = 0;
        for (i = 0; i < (COUNTER * 10); i++)
        {
            V5_LAT = 0;
        }
    }
}
