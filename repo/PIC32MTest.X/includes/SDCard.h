
#ifndef _SDCARD_H
#define _SDCARD_H

#include "Configs/HWP_MIKROE_PIC32_GP_SK_16PMP.h"
#include <plib.h>

/*From hardwareconfig ..............*/

#define SDCARD_CS_TRIS  TRISGbits.TRISG9
#define SDCARD_CS_LAT   LATGbits.LATG9

/************************************************************************
* Macro: ADCARD_CS_OUTPUT()
* Set output to SDCARD chip select pin.
************************************************************************/

#define SDCARD_CS_SET_OUTPUT() SDCARD_CS_TRIS = 0;

/************************************************************************
* Macro: SDCARD_CS_ACTIVE()
* Activate SDCARD chip with to select to its CS pin pull down.
************************************************************************/

#define SDCARD_CS_ACTIVE()    SDCARD_CS_LAT = 0;

/************************************************************************
* Macro: SDCARD_CS_DEACTIVE()
* Deactivate SDCARD chip with to select to its CS pin pull down.
************************************************************************/

#define SDCARD_CS_DEACTIVE()   SDCARD_CS_LAT = 1;

/************************************************************************
* SDCARD Commands
************************************************************************/

void    SDCARDInit();
#endif