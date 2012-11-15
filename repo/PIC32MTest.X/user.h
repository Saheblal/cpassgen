/******************************************************************************/
/* User Level #define Macros                                                  */
/******************************************************************************/

#include "system.h"

/* T1 TICK parameters for 1 msec timer
 * */
#define PB_DIV         		8
#define PRESCALE       		1
#define TOGGLES_PER_SEC		10000
#define T1_TICK       		(SYS_FREQ/PB_DIV/PRESCALE/TOGGLES_PER_SEC)

/* TODO Application specific user parameters used in user.c may go here */

    // Definitions for backlight control pin
#define DisplayBacklightConfig()      TRISAbits.TRISA9  = 0
#define DisplayBacklightOn()          LATAbits.LATA9    = 1
#define DisplayBacklightOff()         LATAbits.LATA9    = 0

/******************************************************************************/
/* User Function Prototypes                                                    /
/******************************************************************************/

/* TODO User level functions prototypes (i.e. InitApp) go here */

void InitApp(void);         /* I/O and Peripheral Initialization */


