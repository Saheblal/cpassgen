
#include "system.h"
#include "dtime.h"

/* delay may between 1usec - 56 usec*/

void Delayusec(int delay, int& psc, int& dvd)
{   int prescaler; int divider;
    prescaler = (delay * 10) / (FYSEC * 10);
    prescaler--;
    psc = prescaler;
    divider = ((delay * 10) % 35) / (FYSEC * 10);
    dvd = divider;
}

void Delay10uSec(int usec10)
{   int i;
    for (i = 0; i < usec10; i++);
}

void DelayMs()
{   int i;
    for (i = 0; i < 150; i++);
}

void Delay(int msec)
{   int j;
    for (j = 0; j < msec; j++) DelayMs();
}

