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

#define COUNTER 10

int phase = 0;

void NextPhase()
{
    SetAllLEDforInput();
    if ((phase++) == 10)
        phase = 0;
//    if (phase == 1)
//        L1_ON(GREEN);
}


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

        LED_ON(GREEN, 1);
        for (i = 0; i < COUNTER; i++)
        {
            V5_LAT = 0;
        }
        SetAllLEDOff();
//        NextPhase();
        for (i = 0; i < (COUNTER * 6); i++)
        {
            V5_LAT = 0;
        }
    }
}
