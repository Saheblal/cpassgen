
#ifndef _MP3_H
#define _MP3_H

#include "Configs/HWP_MIKROE_PIC32_GP_SK_16PMP.h"
#include <plib.h>

/*From hardwareconfig ..............*/

#define MP3_CS_TRIS  TRISGbits.TRISG15
#define MP3_CS_LAT   LATGbits.LATG15

/************************************************************************
* Macro: MP3_CS_OUTPUT()
* Set output to MP3 chip select pin.
************************************************************************/

#define MP3_CS_SET_OUTPUT() MP3_CS_TRIS = 0;

/************************************************************************
* Macro: MP3_CS_ACTIVE()
* Activate MP3 chip with to select to its CS pin pull down.
************************************************************************/

#define MP3_CS_ACTIVE()    MP3_CS_LAT = 0;

/************************************************************************
* Macro: MP3_CS_DEACTIVE()
* Deactivate MP3 chip with to select to its CS pin pull down.
************************************************************************/

#define MP3_CS_DEACTIVE()   MP3_CS_LAT = 1;

/************************************************************************
* MP3 Commands
************************************************************************/

void    MP3Init();
#endif