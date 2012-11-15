/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

#include <plib.h>            /* Include to use PIC32 peripheral libraries     */

/******************************************************************************/
/* Configuration Bits                                                         */
/*                                                                            */
/* Refer to 'C32 Configuration Settings' under the Help > Contents            */
/* > C32 Toolchain in MPLAB X IDE for available PIC32 Configurations.  For    */
/* additional information about what the hardware configurations mean in      */
/* terms of device operation, refer to the device datasheet 'Special Features'*/
/* chapter.                                                                   */
/*                                                                            */
/******************************************************************************/

/* Fill in your configuration bits here.  The general style is shown below.
The Debug Configuration bit is handline by MPLAB and should not be embedded
in the configuration macro.*/

/* TODO Fill in your configuration bits here.  The general style is below:
 * SYSCLK = 80 MHz (8MHz Crystal/ FPLLIDIV * FPLLMUL / FPLLODIV)
 * PBCLK = 40 MHz Primary Osc w/PLL (XT+,HS+,EC+PLL) WDT OFF
 * Other options are don't care
 *
 * TODO TIMER_ALT_CONFIG The alternate timer and oscillators config for MIKROE PIC32 board
 * If is'nt define the that restore the original MPLABX example oscillator configuration.
 */
#if defined (TIMER_ALT_CONFIG)
#pragma config FPLLMUL = MUL_20, FPLLIDIV = DIV_1, FPLLODIV = DIV_2, FWDTEN = OFF, FPBDIV = DIV_1
#else
#pragma config FPLLMUL = MUL_20, FPLLIDIV = DIV_2, FPLLODIV = DIV_1, FWDTEN = OFF, FPBDIV = DIV_8
#endif
#pragma config POSCMOD = HS, FNOSC = PRIPLL
