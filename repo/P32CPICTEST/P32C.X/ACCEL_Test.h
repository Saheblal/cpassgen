/**************************************************************************************************
* File: ACCEL_Test.h
* File Type: C - Header File
* Project Name: BrmBrrrrm
* Company: (c) mikroElektronika, 2011
* Revision History:
*     20111020 (DA):
*       - initial release;
* Description:
*     This module demonstrates communication with 3-axis digital
*     accelerometer ADXL345 on mmB PIC32. Values from accelerometer
*     are shown on the TFT display.
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

// Global Variables
char out[16];
int readings[3] = {0, 0, 0}; // X, Y and Z buffer

// Calculate the average values of the X, Y and Z axis reads
void Accel_Average(void);
// Display average X-axis read value on TFT
void Display_X_Value(void);
// Display average Y-axis read value on TFT
void Display_Y_Value(void);
// Display average z-axis read value on TFT
void Display_Z_Value(void);
// Start using ACCEL
void ACCEL_Start(char *test);
// Test Accel
void ACCEL_Test(void);

//- Imported from ACCEL_DRIVER.H ------------------------------------------------------------------
extern void ADXL345_Write(unsigned short address, unsigned short data1);
extern unsigned short ADXL345_Read(unsigned short address);
extern char ADXL345_Init(void);

extern int Accel_ReadX(void);
extern int Accel_ReadY(void);
extern int Accel_ReadZ(void);

/**************************************************************************************************
* End of File
**************************************************************************************************/