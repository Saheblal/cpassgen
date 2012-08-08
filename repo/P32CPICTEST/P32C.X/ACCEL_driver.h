/**************************************************************************************************
* File: ACCEL_driver.h
* File Type: C - Header File
* Project Name: BrmBrrrrm
* Company: (c) mikroElektronika, 2011
* Revision History:
*     20111020 (DA):
*       - initial release;
* Description:
*     This module contains a set of functions that are used for communication with
*     3-axis digital accelerometer ADXL345.
*
* Target:
*       MCU:             P32MX460F512L
*       Dev.Board:       MikroMMB_for_PIC32
*                        http://www.mikroe.com/eng/products/view/595/mikrommb-for-pic32-board/
*       Oscillator:      80000000 Hz (80MHz)
*       SW:              mikroC PRO for PIC32
*                        http://www.pic32compilers.com/
* NOTES:
*     I2C2 bus is used for communication with accel.
**************************************************************************************************/

// Functions
void ADXL345_Write(unsigned short address, unsigned short data1);
unsigned short ADXL345_Read(unsigned short address);
char ADXL345_Init(void);

// Read X Axis
int Accel_ReadX(void);

// Read Y Axis
int Accel_ReadY(void);

// Read Z Axis
int Accel_ReadZ(void);

/**************************************************************************************************
* End of File
**************************************************************************************************/