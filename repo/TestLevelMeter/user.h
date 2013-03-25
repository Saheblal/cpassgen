/******************************************************************************/
/* User Level #define Macros                                                  */
/******************************************************************************/

/* <Initialize variables in user.h and insert code for user algorithms.>
 * These are the LED display's in/out lines.
*/
#define H1_TRIS     TRISEbits.TRISE4
#define H1_LAT      LATEbits.LATE4
#define H1_PORT     PORTEbits.RE4

#define H2_TRIS     TRISEbits.TRISE5
#define H2_LAT      LATEbits.LATE5
#define H2_PORT     PORTEbits.RE5

#define H3_TRIS     TRISEbits.TRISE8
#define H3_LAT      LATEbits.LATE8
#define H3_PORT     PORTEbits.RE8

#define H4_TRIS     TRISCbits.TRISC13
#define H4_LAT      LATCbits.LATC13
#define H4_PORT     PORTCbits.RC13

#define V1_TRIS     TRISCbits.TRISC14
#define V1_LAT      LATCbits.LATC14
#define V1_PORT     PORTCbits.RC14

#define V2_TRIS     TRISDbits.TRISD2
#define V2_LAT      LATDbits.LATD2
#define V2_PORT     PORTDbits.RD2

#define V3_TRIS     TRISDbits.TRISD3
#define V3_LAT      LATDbits.LATD3
#define V3_PORT     PORTDbits.RD3

#define V4_TRIS     TRISFbits.TRISF0
#define V4_LAT      LATFbits.LATF0
#define V4_PORT     PORTFbits.RF0

#define V5_TRIS     TRISFbits.TRISF1
#define V5_LAT      LATFbits.LATF1
#define V5_PORT     PORTFbits.RF1

#define RF6_TRIS    TRISFbits.TRISF6
#define RF6_LAT     LATFbits.LATF6
#define RF6_PORT    PORTFbits.RF6

#define RB7_TRIS    TRISBbits.TRISB7
#define RB7_LAT     LATBbits.LATB7
#define RB7_PORT    PORTBbits.RB7

#define RB8_TRIS    TRISBbits.TRISB8
#define RB8_LAT     LATBbits.LATB8
#define RB8_PORT    PORTBbits.RB8

/* TODO Application specific user parameters used in user.c may go here */

/******************************************************************************/
/* User Function Prototypes                                                   */
/******************************************************************************/

/* TODO User level functions prototypes (i.e. InitApp) go here */

void InitApp(void); /* I/O and Peripheral Initialization */
