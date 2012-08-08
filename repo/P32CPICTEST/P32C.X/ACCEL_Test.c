/**************************************************************************************************
* File: ACCEL_Test.c
* File Type: C - Header File
* Project Name: BrmBrrrrm
* Company: (c) mikroElektronika, 2011
* Revision History:
*     20111020 (DA):
*       - initial release;
*     20111028 (JK);
*       - revision
* Description:
*     This module demonstrates communication with 3-axis digital
*     accelerometer ADXL345 on mmB PIC32. Values from accelerometer
*     are shown on the TFT display.
* Test configuration:
*       MCU:             P32MX460F512L
*       Dev.Board:       Mikromedia_for_PIC32
*                        http://www.mikroe.com/eng/products/view/595/mikromedia-for-pic32
*       Modules:         Accel on-board module
*                        ac:accel
*       Oscillator:      80000000 Hz (80MHz)
*       SW:              mikroC PRO for PIC32
*                        http://www.mikroe.com/eng/products/view/623/mikroc-pro-for-pic32/
* NOTES:
*     I2C2 bus is used for communication with accel.
**************************************************************************************************/
#include "ACCEL_Test.h"
#include "resources.h"
/*************************************************************************************************/
char cACCEL_test_status;
/*************************************************************************************************
* Draw Accel Screen function
**************************************************************************************************/
void DrawAccelScr(){
  TFT_Fill_Screen(CL_WHITE);
  TFT_Set_Pen(CL_Black, 1);
  TFT_Line(20, 220, 300, 220);
  TFT_LIne(20,  46, 300,  46);
  TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("ACCEL  TEST", 75, 14);
  TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("mikromedia for PIC32", 19, 223);
  TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("www.mikroe.com", 200, 223);
  TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
}

/*************************************************************************************************
* Init MCU function
**************************************************************************************************/
void InitMCU(){
  CM1CON  = 0;                    // Turn off comparators
  CM2CON  = 0;
  AD1PCFG = 0xff;                 // Make all inputs digital

  PMMODE = 0;
  PMAEN  = 0;
  PMCON  = 0;  // WRSP: Write Strobe Polarity bit
  PMMODEbits.MODE = 2;     // Master 2
  PMMODEbits.WAITB = 0;
  PMMODEbits.WAITM = 1;
  PMMODEbits.WAITE = 0;
  PMMODEbits.MODE16 = 1;   // 16 bit mode
  PMCONbits.CSF = 0;
  PMCONbits.PTRDEN = 1;
  PMCONbits.PTWREN = 1;
  PMCONbits.PMPEN = 1;
  TFT_Set_Active(Set_Index,Write_Command,Write_Data);
  TFT_Init(320, 240);
  Delay_ms(1000);
}

/*************************************************************************************************
* Function Accel_Average()
* -------------------------------------------------------------------------------------------------
* Overview: Function calculate the average values of the X, Y and Z axis reads
* Input: Nothing
* Output: X,Y and Z values are stored in readings[] buffer
*************************************************************************************************/
void Accel_Average(void)
{
  int i, sx, sy, sz;

  // sum
  sx = sy = sz = 0;
  
  // average accelerometer reading over last 16 samples
  for (i=0; i<16; i++)
  {
    sx += Accel_ReadX();
    sy += Accel_ReadY();
    sz += Accel_ReadZ();
  }
  // average
  readings[0] = sx >> 4;
  readings[1] = sy >> 4;
  readings[2] = sz >> 4;
}

/**************************************************************************************************
* Function Display_X_Value()
* -------------------------------------------------------------------------------------------------
* Overview: Function display average X-axis read value on TFT
* Input: value stored in readings[0] buffer
* Output: Nothing
**************************************************************************************************/
void Display_X_Value(void)
{
  TFT_Rectangle(160, 100, 200, 115);
  TFT_Write_Text("X: ", 140, 100);
  IntToStr(readings[0], out);
  TFT_Write_Text(out, 160, 100);
  Delay_ms(100);
}

/**************************************************************************************************
* Function Display_Y_Value()
* -------------------------------------------------------------------------------------------------
* Overview: Function display average Y-axis read value on TFT
* Input: value stored in readings[1] buffer
* Output: Nothing
**************************************************************************************************/
void Display_Y_Value(void)
{
  TFT_Rectangle(160, 130, 200, 145);
  TFT_Write_Text("Y: ", 140, 130);
  IntToStr(readings[1], out);
  TFT_Write_Text(out, 160, 130);
  Delay_ms(100);
}

/**************************************************************************************************
* Function Display_Z_Value()
* -------------------------------------------------------------------------------------------------
* Overview: Function display average Z-axis read value on TFT
* Input: value stored in readings[2] buffer
* Output: Nothing
**************************************************************************************************/
void Display_Z_Value(void)
{
  TFT_Rectangle(160, 160, 200, 175);
  TFT_Write_Text("Z: ", 140, 160);
  IntToStr(readings[2], out);
  TFT_Write_Text(out, 160, 160);
  Delay_ms(100);
}

/**************************************************************************************************
* Function ACCEL_Start()
* -------------------------------------------------------------------------------------------------
* Overview: Function Initialize I2C bus and accel module
* Input: Nothing
* Output: test status: 0 - skiped; 1 - pass; 2 - fail
**************************************************************************************************/
void ACCEL_Start(char *test)
{
  // Reset error flag
  *test = 0;
  
  // Initialize I2C communication
  I2C2_Init(250000);

  TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
  TFT_Set_Pen(CL_WHITE, 1);
  TFT_Set_Brush(1, CL_WHITE, 0, 0, 0, 0);

  TFT_Write_Text("Starting Accel test...", 90, 100);
  Delay_ms(2000);
  TFT_Rectangle(70, 70, 250, 130);
  
  // Initialize ADXL345 accelerometer
  if (ADXL345_Init() == 0)
  {
    TFT_Write_Text("Accel module initialized.", 90, 100);
    *test = 1;
    Delay_ms(2000);
  }
  else
  {
    TFT_Write_Text("Error during Accel module initialization.", 90, 100);
    *test = 2;
  }
    
  TFT_Rectangle(70, 70, 250, 130);
}

/**************************************************************************************************
* Function ACCEL_Test()
* -------------------------------------------------------------------------------------------------
* Overview: Function run the accel test
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
void ACCEL_Test(void)
{
  TFT_Write_Text("Reading axis values :", 90, 70);
  Accel_Average();               // Calculate average X, Y and Z reads
  Display_X_Value();             // Display average X value read
  Display_Y_Value();             // Display average Y value read
  Display_Z_Value();             // Display average Z value read
  Delay_ms(200);
}

/**************************************************************************************************
* main function
**************************************************************************************************/

void main(){
  InitMCU();
  DrawAccelScr();
  ACCEL_Start(&cACCEL_test_status);
  while (1){
    ACCEL_Test();
  }
}