

#include "SDCard.h"

/* Initialize SDCARD memory. Must be call during initialization process
 * before I/O operation, because here setting the port , and deselect CS line.
 */

void SDCARDInit()
{
    /* Output the SDCARD CS I/O. */
    SDCARD_CS_SET_OUTPUT();
    /* Deactivate the SDCARD IC. */
    SDCARD_CS_DEACTIVE();
}

