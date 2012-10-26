/* 
 * File:   xlcd.h
 * Author: Bandi
 *
 * Created on 2012. október 26., 14:44
 */

#ifndef XLCD_H
#define	XLCD_H

#ifdef	__cplusplus
extern "C" {
#endif

/* defines general XLCD symbols for     */

//#define CLOCK_FREQ   .15000000
#define XLCDINTERFACE   8
#define XLCDLINE   1
#define XLCDFONT   0
#define XLCDNIBBLESEL   0
#define XLCDDATAPORT   PORTD
#define XLCDRSPORT   PORTE
#define XLCDRSPIN   0
#define XLCDENPORT   PORTE
#define XLCDENPIN   2
#define XLCDRWPORT  PORTE
#define XLCDRWPIN   1
#define XLCDBLOCKING    1
#define XLCDMODE    1
//#define XLCDDELAY    .20
#define XLCDDELAY 	.250
#define XLCDDISPLAYON   1
#define XLCDCURSORON   1
#define XLCDBLINKON   1
#define XLCDENTRYID   1
#define XLCDENTRYSHIFT   0



    int XLCDInit();
    void XLCDPut();

#ifdef	__cplusplus
}
#endif

#endif	/* XLCD_H */

