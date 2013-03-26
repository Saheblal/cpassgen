/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

#include <p30Fxxxx.h>        /* Device header file                            */
#include <stdint.h>          /* For uint32_t definition                       */
#include <stdbool.h>         /* For true/false definition                     */

#include "user.h"            /* variables/params used by user.c               */

/******************************************************************************/
/* User Functions                                                             */
/******************************************************************************/

/* Array of LED ports. These array contains the LED portaddress, and bitnumbers.
 * 
 */
LED_PORT LED_PORTS[10]= {{&LATE, 5, &LATD, 3}};

/******************************************************************************
 * SetAllLEDOff() Off the all LED's id the LED display. Make LOW all lines of
 * LED display.
 ******************************************************************************/

void SetAllLEDOff()
{
    V1_LAT = V2_LAT = V3_LAT = V4_LAT = V5_LAT = 0;
    H1_LAT = H2_LAT = H3_LAT = H4_LAT = 0;
}

/******************************************************************************
 * SetAllLEDforInput() Sets the all LED lines for input that LED's time shared
 * control.
 ******************************************************************************/

void SetAllLEDforInput()
{
    V1_TRIS = V2_TRIS = V3_TRIS = V4_TRIS = V5_TRIS = 1;
    H1_TRIS = H2_TRIS = H3_TRIS = H4_TRIS = 1;
}

/******************************************************************************
 * SetLEDDISPforOutput() Sets the all LED lines for output the LED display. This
 * is allowed to LED display control.
 ******************************************************************************/

void SetLEDDISPforOutput()
{
    V1_TRIS = V2_TRIS = V3_TRIS = V4_TRIS = V5_TRIS = 0;
    H1_TRIS = H2_TRIS = H3_TRIS = H4_TRIS = 0;

    SetAllLEDOff();
}

/******************************************************************************
 * PORTSET(volatile unsigned int* ADDRESS, int number) Set the number'th bit of
 * ADDRESS whitch flags a PORT special function register
 ******************************************************************************/

void PORTSET(volatile unsigned int* ADDRESS, int number)
{   int ordata;
    ordata = 1 << number;
    *ADDRESS |= ordata;
}

/******************************************************************************
 * PORTSET(volatile unsigned int* ADDRESS, int number) Reset the number'th bit of
 * ADDRESS whitch flags a PORT special function register
 ******************************************************************************/

void PORTRES(volatile unsigned int* ADDRESS, int number)
{   int anddata = 0;
    anddata = ~(1 << number);
    *ADDRESS &= anddata;
}

void LED_ON(enum e_LED_COLOR color, int number)
{
    SetAllLEDforInput();
    PORTRES(&TRISD, 3);
    PORTRES(&TRISE, 5);     // Output lines in indexed way.
//    V3_TRIS = H2_TRIS = 0;  // Output the appropriate lines.
    if (color == GREEN) {
        PORTSET(&LATE, 5);
        PORTRES(&LATD, 3);
//        H2_LAT = 1; V3_LAT = 0;
        }
    else { 
        PORTRES(&LATE, 5);
        PORTSET(&LATD, 3);            
//        H2_LAT = 0; V3_LAT = 1;
    }
}

void PORTSET_USER(int* ADDRESS, int number)
{   int ordata;
    ordata = 1 << number;
    *ADDRESS |= ordata;
}

void PORTRES_USER(int* ADDRESS, int number)
{

}


/* _TODO Initialize User Ports/Peripherals/Project here */

void InitApp(void)
{

    /* Initialize peripherals
     * Set LED-DISPLAY bits to output
     */
//    SetLEDDISPforOutput();
    /* Setup analog functionality and port direction */
}

