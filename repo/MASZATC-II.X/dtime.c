

#include "dtime.h"

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

