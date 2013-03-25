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

/******************************************************************************
 * SetLEDDISPforOutput() Sets the all LED lines for output the LED display. This
 * is allowed to LED display control.
 ******************************************************************************/

void SetLEDDISPforOutput()
{
    /*
     * Set LED-DISPLAY lines for outputs to control LEDs
     *
     */
    V1_TRIS = V2_TRIS = V3_TRIS = V4_TRIS = V5_TRIS = 0;
    H1_TRIS = H2_TRIS = H3_TRIS = H4_TRIS = 0;
    /* Clears all LED ports
     *
     */
    V1_LAT = V2_LAT = V3_LAT = V4_LAT = V5_LAT = 0;
    H1_LAT = H2_LAT = H3_LAT = H4_LAT = 0;

}

/******************************************************************************
 * SetDIPSWITCHInputs() Sets the LED-DISP device input output lines to DIP-SWITCH
 * states reading.
 ******************************************************************************/

void SetDIPSWITCHInputs()
{
   /* H1-to H4 lines to inputs.*/
    H1_TRIS = H2_TRIS = H3_TRIS = H4_TRIS = 1;
   /* V1-to V4 lines to inputs. */
    V1_TRIS = V2_TRIS = V3_TRIS = V4_TRIS = V5_TRIS = 1;

}

/* _TODO Initialize User Ports/Peripherals/Project here */

void InitApp(void)
{

    /* Initialize peripherals
     * Set LED-DISPLAY bits to output
     */

    /* Setup analog functionality and port direction */
}

