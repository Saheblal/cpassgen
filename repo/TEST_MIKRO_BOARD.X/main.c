/******************************************************************************/
/*  Files to Include                                                          */
/******************************************************************************/
#ifdef __XC32
    #include <xc.h>          /* Defines special funciton registers, CP0 regs  */
#endif

#include <plib.h>           /* Include to use PIC32 peripheral libraries      */
#include <stdint.h>         /* For uint32_t definition                        */
#include <stdbool.h>        /* For true/false definition                      */

#include "system.h"         /* System funct/params, like osc/periph config    */
#include "user.h"           /* User funct/params, such as InitApp             */
#include "ILI9341.h"        /* ILI9431 driver function prototypes             */

/******************************************************************************/
/* Global Variable Declaration                                                */
/******************************************************************************/

/* i.e. uint32_t <variable_name>; */

/******************************************************************************/
/* Main Program                                                               */
/******************************************************************************/

char block[10] = {0, 0, 0};

#define TFT_RS LATBbits.LATB15
#define TFT_CS LATFbits.LATF12

void SetLCDPorts()
{
    /* LCD hardware reset pin output */
    TRISCbits.TRISC1 = 0;
    TRISDbits.TRISD4 = 0;   //PMWR
    TRISDbits.TRISD5 = 0;   //PMRD
    /* LCD CS to select lCD chip... */
    TRISFbits.TRISF12 = 0;
    /* D/CX(SCL) IO Register select signal */
    TRISBbits.TRISB15 = 0;
}

void Init_MCU() {
  PMMODE = 0;
  PMAEN  = 0;
  PMCON  = 0;  // WRSP: Write Strobe Polarity bit
  PMMODEbits.MODE0 = 0;     // Master 2
  PMMODEbits.MODE1 = 1;     // Master 2

  PMMODEbits.WAITB = 0;
  PMMODEbits.WAITM = 1;
  PMMODEbits.WAITE = 0;
  PMMODEbits.MODE16 = 1;   // 16 bit mode
  PMCONbits.CSF = 0;
  PMCONbits.PTRDEN = 1;
  PMCONbits.PTWREN = 1;
  PMCONbits.PMPEN = 1;
}

void PMPWaitBusy() {
  while(PMMODEbits.BUSY);
}

void ResetLCD()
{
    TFT_CS = 0;
    LATCbits.LATC1 = 0;
    DelayMs(5);
    LATCbits.LATC1 = 1;
    DelayMs(5);
    TFT_CS = 1;
}

void WriteCommand(int cmd)
{
  TFT_CS = 0;
  TFT_RS = 0;
  PMDIN = cmd;
  PMPWaitBusy();
  TFT_CS = 1;
}

void SoftResetLCD()
{
    WriteCommand(0x01);
    DelayMs(10);
}

void WriteData(unsigned int _data)
{
  TFT_CS = 0;
  TFT_RS = 1;
  PMDIN = _data;
  PMPWaitBusy();
  TFT_CS = 1;
}

void write_cmd(int cmd)
{
  WriteCommand(cmd);
}

void write_data16(int a, int data)
{
  WriteData(data);
}

void delay(int d)
{
  DelayMs(d);
}

#define LCD_nRESET LATCbits.LATC1

#define delayms(z) DelayMs(z)
#define LCD_ILI9341_CMD WriteCommand
#define LCD_ILI9341_Parameter WriteData

void lcdSetWindow(unsigned short x0, unsigned short y0, unsigned short x1, unsigned short y1)
{
  WriteCommand(ColumnAddressSet);
  WriteData((x0 >> 8) & 0xFF);
  WriteData(x0 & 0xFF);
  WriteData((y0 >> 8) & 0xFF);
  WriteData(y0 & 0xFF);
  WriteCommand(PageAddressSet);
  WriteData((x1 >> 8) & 0xFF);
  WriteData(x1 & 0xFF);
  WriteData((y1 >> 8) & 0xFF);
  WriteData(y1 & 0xFF);
//  WriteCommand(MemoryWrite);
}

void ILI9341_Initial(void)
{
// VCI=2.8V
//************* Reset LCD Driver ****************//
LCD_nRESET = 1;
delayms(1); // Delay 1ms
LCD_nRESET = 0;
delayms(10); // Delay 10ms // This delay time is necessary
LCD_nRESET = 1;
delayms(120); // Delay 120 ms
//************* Start Initial Sequence **********//

LCD_ILI9341_CMD(PowerControlB);        //Power control B (CFh)
LCD_ILI9341_Parameter(0x00);
LCD_ILI9341_Parameter(0x81);
LCD_ILI9341_Parameter(0X30);

LCD_ILI9341_CMD(PowerOnSequenceControl);
LCD_ILI9341_Parameter(0x64);
LCD_ILI9341_Parameter(0x03);
LCD_ILI9341_Parameter(0X12);
LCD_ILI9341_Parameter(0X81);

LCD_ILI9341_CMD(DriverTimingControlA);
LCD_ILI9341_Parameter(0x85);
LCD_ILI9341_Parameter(0x10);
LCD_ILI9341_Parameter(0x78);

LCD_ILI9341_CMD(PowerControlA);
LCD_ILI9341_Parameter(0x39);
LCD_ILI9341_Parameter(0x2C);
LCD_ILI9341_Parameter(0x00);
LCD_ILI9341_Parameter(0x34);
LCD_ILI9341_Parameter(0x02);

LCD_ILI9341_CMD(PumpRatioControl);
LCD_ILI9341_Parameter(0x20);

LCD_ILI9341_CMD(DriverTimingControlB);
LCD_ILI9341_Parameter(0x00);
LCD_ILI9341_Parameter(0x00);

LCD_ILI9341_CMD(FrameRateControlInNormalModeFullColors);
LCD_ILI9341_Parameter(0x00);
LCD_ILI9341_Parameter(0x1B);

LCD_ILI9341_CMD(DisplayFunctionControl);        // Display Function Control
LCD_ILI9341_Parameter(0x0A);
LCD_ILI9341_Parameter(0xA2);

LCD_ILI9341_CMD(PowerControl1);         //Power control
LCD_ILI9341_Parameter(0x21);            //VRH[5:0]

LCD_ILI9341_CMD(PowerControl2);         //Power control
LCD_ILI9341_Parameter(0x11);            //SAP[2:0];BT[3:0]

LCD_ILI9341_CMD(VCOMControl1);          //VCM control
LCD_ILI9341_Parameter(0x3F);
LCD_ILI9341_Parameter(0x3C);

LCD_ILI9341_CMD(VCOMControl2);          //VCM control2
LCD_ILI9341_Parameter(0Xb5);

LCD_ILI9341_CMD(PixelFormatSet);

#if defined (_64K_COLOR_MODE)
LCD_ILI9341_Parameter(BITPERPIXEL16);
#elif defined (_256K_COLOR_MODE)
LCD_ILI9341_Parameter(BITPERPIXEL18);
#endif

LCD_ILI9341_CMD(MemoryAccessControl);        // Memory Access Control
LCD_ILI9341_Parameter(RGBSET);

LCD_ILI9341_CMD(InterfaceControl);        // Memory Access Control
LCD_ILI9341_Parameter(0x01);
#if defined (_MDT00)
LCD_ILI9341_Parameter(MDT00);
#elif defined (_MDT01)
LCD_ILI9341_Parameter(MDT01);
#else
#error "You must define the MDT parameter !"
#endif

LCD_ILI9341_Parameter(0x00);

LCD_ILI9341_CMD(Enable3G);              // 3Gamma Function Disable
LCD_ILI9341_Parameter(0x00);
LCD_ILI9341_CMD(GammaSet);              //Gamma curve selected
LCD_ILI9341_Parameter(0x01);

LCD_ILI9341_CMD(PositiveGammaCorrection);        //Set Gamma
LCD_ILI9341_Parameter(0x0F);
LCD_ILI9341_Parameter(0x26);
LCD_ILI9341_Parameter(0x24);
LCD_ILI9341_Parameter(0x0B);
LCD_ILI9341_Parameter(0x0E);
LCD_ILI9341_Parameter(0x09);
LCD_ILI9341_Parameter(0x54);
LCD_ILI9341_Parameter(0XA8);
LCD_ILI9341_Parameter(0x46);
LCD_ILI9341_Parameter(0x0C);
LCD_ILI9341_Parameter(0x17);
LCD_ILI9341_Parameter(0x09);
LCD_ILI9341_Parameter(0x0F);
LCD_ILI9341_Parameter(0x07);
LCD_ILI9341_Parameter(0x00);

LCD_ILI9341_CMD(NegativeGammaCorrection);        //Set Gamma
LCD_ILI9341_Parameter(0x00);
LCD_ILI9341_Parameter(0x19);
LCD_ILI9341_Parameter(0x1B);
LCD_ILI9341_Parameter(0x04);
LCD_ILI9341_Parameter(0x10);
LCD_ILI9341_Parameter(0x07);
LCD_ILI9341_Parameter(0x2A);
LCD_ILI9341_Parameter(0x47);
LCD_ILI9341_Parameter(0x39);
LCD_ILI9341_Parameter(0x03);
LCD_ILI9341_Parameter(0x06);
LCD_ILI9341_Parameter(0x06);
LCD_ILI9341_Parameter(0x30);
LCD_ILI9341_Parameter(0x38);
LCD_ILI9341_Parameter(0x0F);

//lcdSetWindow(10, 230 - 1, 10, 310 - 1);

LCD_ILI9341_CMD(SleepOut);        //Exit Sleep
delayms(120);
LCD_ILI9341_CMD(0x29);        //Display on

}

void ILI9341_DisplayOff()
{
  LCD_ILI9341_CMD(DisplayOff); // Display off
  delayms(20);
}

void ILI9341_DisplayOn()
{
  LCD_ILI9341_CMD(DisplayOn); // Display on
}

void ILI9341_Enter_Sleep(void)
{
  ILI9341_DisplayOff();
  LCD_ILI9341_CMD(EnterSleepMode); // Enter Sleep mode
}

void ILI9341_Exit_Sleep(void)
{
  LCD_ILI9341_CMD(SleepOut); // Sleep out
  delayms(120);
  ILI9341_DisplayOn();
}


void ILI9341_Invert()
{
    LCD_ILI9341_CMD(DisplayInversionOn);
}

void ILI9341_ReInvert()
{
    LCD_ILI9341_CMD(DisplayInversionOff);
}

void ILI9341_SetBrightness(unsigned char brightness)
{
  LCD_ILI9341_CMD(WriteDisplayBrightness);
  LCD_ILI9341_Parameter(brightness);
}

void lcdSetOrientation()
{
//  lcdOrientation = value;
  WriteCommand(MemoryAccessControl);
  WriteData(0b01000000);
/*  WriteCommand(MemoryWrite);
  lcdSetWindow(0, 320 - 1, 0, 240 - 1);*/
}
#if defined (_64K_COLOR_MODE)
void ClearScreen(RGBPIXEL color)
{ int y, x; 
  WriteCommand(MemoryWrite);
  for (y = 0; y < 310; y++)
  {
    for (x = 0; x < 240; x++)
    {
      WriteData(color.D16);
    }
  }
}
#elif defined (_256K_COLOR_MODE)
void ClearScreen(RGBPIXEL color)
{ int y, x, max_data;
  RGBPIXEL PX;
#if defined (_MDT00)
max_data = 360;
MODE00_STRUCT M;
#elif defined (_MDT01)
max_data = 480;
MODE01_STRUCT M;
#endif
  M.AL8 = color.G8;
  M.AH8 = color.R8;
  M.BL8 = color.R8;
  M.BH8 = color.B8;
  M.CL8 = color.B8;
  M.CH8 = color.G8; // color.B8;
  WriteCommand(MemoryWrite);
  for (y = 0; y < 310; y++)
  {
    for (x = 0; x < (max_data / 3); x++)
    {
      WriteData(M.A16);
      WriteData(M.B16);
      WriteData(M.C16);
    }
  }
}
#endif
//LATCbits.
void LCD_Out_Pixel64k(const struct s_gimp_image* g)
{ unsigned int i, j, data; unsigned char datal, datah;
  long ptr = 0;
  WriteCommand(MemoryWrite);
  for (i = 0; i < g->width; i++)
  {
    for (j = 0; j < g->height; j++)
    {
      datal = g->pixel_data[ptr];
      datah = g->pixel_data[ptr + 1];
      data = (datah << 8) | datal;
      WriteData(data);
      ptr += 2;
    }
  }
}

void LCD_Out_Pixel256k(const struct s_gimp_image* g)
{ unsigned int i, j, data; unsigned char datar, datag, datab;
  long ptr = 0;
  WriteCommand(MemoryWrite);
  for (i = 0; i < g->width; i++)
  {
    for (j = 0; j < g->height; j++)
    {
      datar = g->pixel_data[ptr++];
      datag = g->pixel_data[ptr++];
      data = (datar << 8) | datag;
      WriteData(data);
      datab = g->pixel_data[ptr++];
      WriteData(datab);
    }
  }
}

void LCD_Out_Pixel(const struct s_gimp_image* g)
{
  /* 2 bytes / pixel, therefore 65k colors per pixel*/
  if (g->bytes_per_pixel == 2)
  {
    LCD_Out_Pixel64k(g);
  } else if (g->bytes_per_pixel == 3)
  {
    LCD_Out_Pixel256k(g);
  }
}

/*void LCD_Test()
{
  WriteCommand(MemoryWrite);
  int y, x;
  for (y = 0; y < 310; y++) {
    for (x = 0; x < 240; x++) {
      if (y > 279) WriteData(GREEN);
      else if (y > 239) WriteData(RED);
      else if (y > 199) WriteData(BLUE);
      else if (y > 159) WriteData(RED);
      else if (y > 119) WriteData(GREEN);
      else if (y > 79) WriteData(WHITE);
      else if (y > 39) WriteData(BLACK);
      else WriteData(BLACK);
    }
  }
}*/

int32_t main(void)
{

#ifndef PIC32_STARTER_KIT
    /*The JTAG is on by default on POR.  A PIC32 Starter Kit uses the JTAG, but
    for other debug tool use, like ICD 3 and Real ICE, the JTAG should be off
    to free up the JTAG I/O */
    DDPCONbits.JTAGEN = 0;
#endif

    /*Refer to the C32 peripheral library documentation for more
    information on the SYTEMConfig function.
    
    This function sets the PB divider, the Flash Wait States, and the DRM
    /wait states to the optimum value.  It also enables the cacheability for
    the K0 segment.  It could has side effects of possibly alter the pre-fetch
    buffer and cache.  It sets the RAM wait states to 0.  Other than
    the SYS_FREQ, this takes these parameters.  The top 3 may be '|'ed
    together:
    
    SYS_CFG_WAIT_STATES (configures flash wait states from system clock)
    SYS_CFG_PB_BUS (configures the PB bus from the system clock)
    SYS_CFG_PCACHE (configures the pCache if used)
    SYS_CFG_ALL (configures the flash wait states, PB bus, and pCache)*/

    /* TODO Add user clock/system configuration code if appropriate.  */
    SYSTEMConfig(SYS_FREQ, SYS_CFG_ALL);

//    INTConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);
    /* Initialize I/O and Peripherals for application */
    InitApp();
    SetLCDPorts();  // Setting LCD I/O ports
    Init_MCU();
    DisplayBacklightOn();
    /*Configure Multivector Interrupt Mode.  Using Single Vector Mode
    is expensive from a timing perspective, so most applications
    should probably not use a Single Vector Mode*/

    ILI9341_Initial();
//    lcdSetOrientation();
    RGBPIXEL pixel;
    GRAY(pixel)
    ClearScreen(pixel);
    lcdSetWindow(20, 20 + gimp_image.width - 1, 60, 60 + gimp_image.height - 1);
    LCD_Out_Pixel(&gimp_image);
//    ClearScreen(0b0000011111100000);
//    ClearScreen(0b0000000000011111);

    while(1)
    {
//      ILI9341_SetBrightness(b+=20);
      
        DelayMs(500);
//        ILI9341_Invert();
//        ILI9341_Enter_Sleep();
//        LCD_Test(h+=10);
//        DelayMs(500);
//        ILI9341_ReInvert();
//        ILI9341_Exit_Sleep();
//        LCD_Test(h);
    }

    ResetLCD();
    SoftResetLCD();

    WriteCommand(0x021);

    int hd = 40;

    while (1)
    {
        DelayMs(500);
        DisplayBacklightOff();
        DelayMs(500);
        DisplayBacklightOn();
    }
    while(1)
    {
        PMPMasterWrite(0x20);
        DelayMs(500);
        PMPMasterWrite(0x21);
        DelayMs(500);
//        DisplayBacklightOn();
//        PMPMasterWriteByteBlock(wd++, 1, block);

//        PMPMasterWrite(hu++);
/*        DelayMs(5);
//        PMPMasterWriteByteBlock(wd++, 1, block);
        PMPSetAddress(wd++);
        PMPMasterWrite(0);*/
//        DisplayBacklightOff();
    }
}
/*  37 D/CX(SCL) IO Register select signal; Serial Interface Clock
    38 CSX IO Chip Select Signal*/
/*            D/CX RDX WRX  */
/*Display OFF 0     1   ? XX 0 0 1 0 1 0 0 0 28h
   Display ON 0     1   ? XX 0 0 1 0 1 0 0 1 29h*/