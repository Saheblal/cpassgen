

#include "MP3.h"

/* Initialize MP3 IC. Must be call during initialization process
 * before I/O operation, because here setting the port , and deselect CS line.
 */

void MP3Init()
{
    /* Output the MP3 CS I/O. */
    MP3_CS_SET_OUTPUT();
    /* Deactivate the MP3 IC. */
    MP3_CS_DEACTIVE();
}

