/******************************************************************************/
/* User Level #define Macros                                                  */
/******************************************************************************/

/* TODO Application specific user parameters used in user.c may go here */


#if !defined (_USER_H)
#define _USER_H
/******************************************************************************/
/* User Function Prototypes                                                    /
/******************************************************************************/

#include "system.h"
/* T1 TICK parameters for 1 msec timer
 * */
#define PB_DIV         		8
#define PRESCALE       		1
#define TOGGLES_PER_SEC		10000
#define T1_TICK       		(SYS_FREQ/PB_DIV/PRESCALE/TOGGLES_PER_SEC)

    // Definitions for backlight control pin
#define DisplayBacklightConfig()      TRISAbits.TRISA9  = 0
#define DisplayBacklightOn()          LATAbits.LATA9    = 1
#define DisplayBacklightOff()         LATAbits.LATA9    = 0


// TFT module connections
/*char TFT_DataPort at LATE;
sbit TFT_RST at LATC1_bit;
sbit TFT_BLED at LATD2_bit;
sbit TFT_RS at LATB15_bit;
sbit TFT_CS at LATF12_bit;
sbit TFT_RD at LATD5_bit;
sbit TFT_WR at LATD4_bit;
char TFT_DataPort_Direction at TRISE;
sbit TFT_RST_Direction at TRISC1_bit;
sbit TFT_BLED_Direction at TRISD2_bit;
sbit TFT_RS_Direction at TRISB15_bit;
sbit TFT_CS_Direction at TRISF12_bit;
sbit TFT_RD_Direction at TRISD5_bit;
sbit TFT_WR_Direction at TRISD4_bit;
// End TFT module connections

// Touch Panel module connections
sbit DriveX_Left at LATB13_bit;
sbit DriveX_Right at LATB11_bit;
sbit DriveY_Up at LATB12_bit;
sbit DriveY_Down at LATB10_bit;
sbit DriveX_Left_Direction at TRISB13_bit;
sbit DriveX_Right_Direction at TRISB11_bit;
sbit DriveY_Up_Direction at TRISB12_bit;
sbit DriveY_Down_Direction at TRISB10_bit;
// End Touch Panel module connections*/


/* PMP port setup features for PMPOpenport*/
#define CONTROL  (PMP_ON | PMP_IDLE_CON | PMP_MUX_OFF | PMP_READ_WRITE_EN | \
                 PMP_CS2_CS1_OFF | PMP_LATCH_POL_HI | PMP_WRITE_POL_LO | PMP_READ_POL_LO)

#define MODE     (PMP_IRQ_OFF | PMP_AUTO_ADDR_OFF | PMP_DATA_BUS_16 | PMP_MODE_MASTER2 | \
                 PMP_WAIT_BEG_3 | PMP_WAIT_MID_15 | PMP_WAIT_END_4 )

#define PORT     (PMP_PEN_OFF)

#define INT      (PMP_INT_OFF)

struct s_gimp_image {
  unsigned int 	 width;
  unsigned int 	 height;
  unsigned int 	 bytes_per_pixel; /* 2:RGB16, 3:RGB, 4:RGBA */
//  unsigned char	 pixel_data[320 * 240 * 2 + 1];
  unsigned char	 pixel_data[];
};

extern const struct s_gimp_image gimp_image;

/* TODO User level functions prototypes (i.e. InitApp) go here */

void InitApp(void);         /* I/O and Peripheral Initialization */

#endif