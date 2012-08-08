/**************************************************************************************************
* File: ACCEL_driver.c
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
*       Dev.Board:       Mikromedia_for_PIC32
*                        http://www.mikroe.com/eng/products/view/595/mikromedia-for-pic32/
*       Oscillator:      80000000 Hz (80MHz)
*       SW:              mikroC PRO for PIC32
*                        http://www.mikroe.com/eng/products/view/623/mikroc-pro-for-pic32/
* NOTES:
*     I2C2 bus is used for communication with accel.
**************************************************************************************************/
#include "ACCEL_driver.h"

// ADXL345 Register Definition
#define _POWER_CTL      0x2D
#define _DATA_FORMAT    0x31
#define _BW_RATE        0x2C
#define _DATAX0         0x32
#define _DATAX1         0x33
#define _DATAY0         0x34
#define _DATAY1         0x35
#define _DATAZ0         0x36
#define _DATAZ1         0x37
#define _FIFO_CTL       0x38
#define _SPEED          0x0F          // Buffer Speed - 3200Hz

#define _ACCEL_ERROR    0x02

/**************************************************************************************************
* Function ADXL345_Write()
* -------------------------------------------------------------------------------------------------
* Overview: Function write byte of data to ADXL345
* Input: register address, data
* Output: Nothing
**************************************************************************************************/
void ADXL345_Write(unsigned short address, unsigned short data1)
{
  I2C2_Start();                      // issue I2C start signal
  I2C2_Write(0x3A);                  // send byte via I2C  (device address + W)
  I2C2_Write(address);               // send byte (address of the location)
  I2C2_Write(data1);                 // send data (data to be written)
  I2C2_Stop();                       // issue I2C stop signal
}

/**************************************************************************************************
* Function ADXL345_Read()
* -------------------------------------------------------------------------------------------------
* Overview: Function read byte of data from ADXL345
* Input: register address
* Output: data from addressed register in ADXL345
**************************************************************************************************/
unsigned short ADXL345_Read(unsigned short address)
{
  unsigned short tmp = 0;

  I2C2_Start();                      // issue I2C start signal
  I2C2_Write(0x3A);                  // send byte via I2C (device address + W)
  I2C2_Write(address);               // send byte (data address)
  
  I2C2_Start();                      // issue I2C signal repeated start
  I2C2_Write(0x3B);                  // send byte (device address + R)
  tmp = I2C2_Read(1);                // Read the data (NO acknowledge)
  I2C2_Stop();                       // issue I2C stop signal

  return tmp;
}

/**************************************************************************************************
* Function ADXL345_Init()
* -------------------------------------------------------------------------------------------------
* Overview: Function that initializes ADXL345
* Input: Nothing
* Output: return 0 for OK; return _ACCEL_ERROR for ERROR
**************************************************************************************************/
char ADXL345_Init(void)
{
  char id = 0x00;

  // Go into standby mode to configure the device.
  ADXL345_Write(0x2D, 0x00);

  id = ADXL345_Read(0x00);

  if (id != 0xE5)
  {
    return _ACCEL_ERROR;
  }
  else
  {
    ADXL345_Write(_DATA_FORMAT, 0x08);       // Full resolution, +/-2g, 4mg/LSB, right justified
    ADXL345_Write(_BW_RATE, 0x0A);           // Set 100 Hz data rate
    ADXL345_Write(_FIFO_CTL, 0x80);          // stream mode
    ADXL345_Write(_POWER_CTL, 0x08);         // POWER_CTL reg: measurement mode
    return 0x00;
  }
}

/**************************************************************************************************
* Function Accel_ReadX()
* -------------------------------------------------------------------------------------------------
* Overview: Function read X axis from accel.
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
int Accel_ReadX(void)
{
  char low_byte;
  int Out_x;

  Out_x = ADXL345_Read(_DATAX1);
  low_byte = ADXL345_Read(_DATAX0);

  Out_x = (Out_x << 8);
  Out_x = (Out_x | low_byte);

  return Out_x;
}

/**************************************************************************************************
* Function Accel_ReadY()
* -------------------------------------------------------------------------------------------------
* Overview: Function read Y axis from accel.
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
int Accel_ReadY(void)
{
  char low_byte;
  int Out_y;

  Out_y = ADXL345_Read(_DATAY1);
  low_byte = ADXL345_Read(_DATAY0);

  Out_y = (Out_y << 8);
  Out_y = (Out_y | low_byte);

  return Out_y;
}

/**************************************************************************************************
* Function Accel_ReadZ()
* -------------------------------------------------------------------------------------------------
* Overview: Function read Z axis from accel.
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
int Accel_ReadZ(void)
{
  char low_byte;
  int Out_z;

  Out_z = ADXL345_Read(_DATAZ1);
  low_byte = ADXL345_Read(_DATAZ0);

  Out_z = (Out_z << 8);
  Out_z = (Out_z | low_byte);

  return Out_z;
}

/**************************************************************************************************
* End of File
**************************************************************************************************/