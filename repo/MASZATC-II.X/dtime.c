

#include "dtime.h"

void DelayMs()
{   int i;
    for (i = 0; i < 150; i++);
}

void Delay(int msec)
{   int j;
    for (j = 0; j < msec; j++) DelayMs();
}

