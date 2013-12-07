/*****************************************************************************
 *  Module for Microchip Graphics Library
 *  HIMAX HX8347 controller driver
 *****************************************************************************
 * FileName:        HX8347.c
 * Processor:       PIC24, dsPIC, PIC32
 * Compiler:        MPLAB C30, MPLAB C32
 * Company:         Microchip Technology Incorporated
 *
 * Software License Agreement
 *
 * Copyright (c) 2011 Microchip Technology Inc.  All rights reserved.
 * Microchip licenses to you the right to use, modify, copy and distribute
 * Software only when embedded on a Microchip microcontroller or digital
 * signal controller, which is integrated into your product or third party
 * product (pursuant to the sublicense terms in the accompanying license
 * agreement).  
 *
 * You should refer to the license agreement accompanying this Software
 * for additional information regarding your rights and obligations.
 *
 * SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
 * KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY WARRANTY
 * OF MERCHANTABILITY, TITLE, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR
 * PURPOSE. IN NO EVENT SHALL MICROCHIP OR ITS LICENSORS BE LIABLE OR
 * OBLIGATED UNDER CONTRACT, NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION,
 * BREACH OF WARRANTY, OR OTHER LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT
 * DAMAGES OR EXPENSES INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL,
 * INDIRECT, PUNITIVE OR CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA,
 * COST OF PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY
 * CLAIMS BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
 * OR OTHER SIMILAR COSTS.
 *
 * Date         Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * 05/26/09     ...
 * 04/12/11     Graphics Library Version 3.00 Support
 * 10/09/11     Fixed WritePixel() in USE_16BIT_PMP mode
 * 02/29/12     1 BPP PutImage() routines processes images with reversed 
 *              bitfields. 
 * 03/05/12     - Enabled transparency support for PutImage()
 *              - Fixed problems with PutImage() when stretch = 2.
 *              - Added GetPixel() function.   
 * 07/02/12     Modified PutImageXBPPYYY() functions to use new API.
 *****************************************************************************/


//#if defined (GFX_USE_DISPLAY_CONTROLLER_ILI9341)

#include "../../Compiler.h"
//#include "TimeDelay.h"
#include "../DisplayDriver.h"
#include "ILI9341.h"
#include "../Primitive.h"

#if defined (USE_GFX_PMP)
    #include "../gfxpmp.h"
#elif defined (USE_GFX_EPMP)
    #include "../gfxepmp.h"
#endif   

// Clipping region control
SHORT       _clipRgn;

// Clipping region borders
SHORT       _clipLeft;
SHORT       _clipTop;
SHORT       _clipRight;
SHORT       _clipBottom; 

// Color
GFX_COLOR   _color;
#ifdef USE_TRANSPARENT_COLOR
GFX_COLOR   _colorTransparent;
SHORT       _colorTransparentEnable;
#endif

#define USE_PRIMITIVE_PUTIMAGE
#ifndef USE_PRIMITIVE_PUTIMAGE
    #warning "This driver does not support partial putImage feature. To enable partial putimage feature, uncomment the macro USE_PRIMITIVE_PUTIMAGE in this file. This will enable the PutImageXBPPYYY() in the Primitive.c implementation."
#endif

/////////////////////// LOCAL FUNCTIONS PROTOTYPES ////////////////////////////
//void    SetReg(BYTE index, BYTE value);

#ifndef USE_PRIMITIVE_PUTIMAGE
void    PutImage1BPP(SHORT left, SHORT top, FLASH_BYTE *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData);
void    PutImage4BPP(SHORT left, SHORT top, FLASH_BYTE *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData);
void    PutImage8BPP(SHORT left, SHORT top, FLASH_BYTE *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData);
void    PutImage16BPP(SHORT left, SHORT top, FLASH_BYTE *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData);

void    PutImage1BPPExt(SHORT left, SHORT top, void *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData);
void    PutImage4BPPExt(SHORT left, SHORT top, void *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData);
void    PutImage8BPPExt(SHORT left, SHORT top, void *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData);
void    PutImage16BPPExt(SHORT left, SHORT top, void *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData);
#endif

/*********************************************************************
* Macros:  WritePixel(data)
*
* Overview: Writes data
*
* PreCondition: none
*
* Input: data
*
* Output: none
*
* Side Effects: none
*
********************************************************************/

#ifdef USE_16BIT_PMP
#define WritePixel(data)  DisplaySetData(); DeviceWrite(data)
#else
#define WritePixel(data) \
    DisplaySetData(); \
    DeviceWrite(((WORD_VAL)data).v[1]);\
    DeviceWrite(((WORD_VAL)data).v[0]);
#endif


/*********************************************************************
* Function:  void SetRegion(SHORT xbeg, SHORT xend, SHORT ybeg, SHORT yend)
* Overview: Writes the region datas
* PreCondition: none
* Input: xbeg - horizontal begin pos, xend : horizontal end pos
*        ybeg - vertical begin pos, yend : vertical end pos.
* Output: none
* Side Effects: none
********************************************************************/

inline void SetRegion(SHORT xbeg, SHORT xend, SHORT ybeg, SHORT yend)
{
	DisplaySetCommand();
  DeviceWrite(ColumnAddressSet);
	DisplaySetData();
  DeviceWrite(((WORD_VAL) (WORD) xbeg).byte.HB);
  DeviceWrite(((WORD_VAL) (WORD) xbeg).byte.LB);
  DeviceWrite(((WORD_VAL) (WORD) xend).byte.HB);
  DeviceWrite(((WORD_VAL) (WORD) xend).byte.LB);

	DisplaySetCommand();
  DeviceWrite(PageAddressSet);
	DisplaySetData();
  DeviceWrite(((WORD_VAL) (WORD) ybeg).byte.HB);
  DeviceWrite(((WORD_VAL) (WORD) ybeg).byte.LB);
  DeviceWrite(((WORD_VAL) (WORD) yend).byte.HB);
  DeviceWrite(((WORD_VAL) (WORD) yend).byte.LB);
  
}
/*********************************************************************
* Function:  void SetAddress(SHORT x, SHORT y)
*
* Overview: Writes address pointer.
*
* PreCondition: none
*
* Input: x - horizontal position
*        y - vertical position
*
* Output: none
*
* Side Effects: none
*
********************************************************************/
inline void SetAddress(SHORT x, SHORT y)
{
//  DisplayEnable();
	DisplaySetCommand();
  DeviceWrite(ColumnAddressSet);
	DisplaySetData();
  DeviceWrite(((WORD_VAL) (WORD) x).byte.HB);
  DeviceWrite(((WORD_VAL) (WORD) x).byte.LB);
  DeviceWrite(((WORD_VAL) (WORD) x).byte.HB);
  DeviceWrite(((WORD_VAL) (WORD) x).byte.LB);

	DisplaySetCommand();
  DeviceWrite(PageAddressSet);
	DisplaySetData();
  DeviceWrite(((WORD_VAL) (WORD) y).byte.HB);
  DeviceWrite(((WORD_VAL) (WORD) y).byte.LB);
  DeviceWrite(((WORD_VAL) (WORD) y).byte.HB);
  DeviceWrite(((WORD_VAL) (WORD) y).byte.LB);

//  DisplayDisable();
}

void ResetLCD()
{
//  DisplayEnable();
  DisplayResetDisable();
  DelayMs(100);
  DisplayResetEnable();
  DelayMs(100);
  DisplayResetDisable();
  DelayMs(100);
}

void WriteCommand(int cmd)
{
  DisplayEnable();
  DisplaySetCommand();
  PMDIN = cmd;
  PMPWaitBusy();
  DisplayDisable();
}

void SoftResetLCD()
{
  WriteCommand(SOFT_RESET_REG);
  DelayMs(100);
}

void WritePMPIN(unsigned int _data)
{
  PMDIN = _data;
}

void WriteData(unsigned int _data)
{
  DisplayEnable();
  DisplaySetData();
  PMDIN = _data;
  PMPWaitBusy();
  DisplayDisable();
}

/*********************************************************************
* Function:  void  SetReg(BYTE index, BYTE value)
*
* PreCondition: none
*
* Input: index - register number
*        value - value to be set
*
* Output: none
*
* Side Effects: none
*
* Overview: sets graphics controller register
*
* Note: none
*
********************************************************************/
void SetReg(BYTE index, BYTE value)
{
	DisplayEnable();
	DisplaySetCommand();
	DeviceWrite(index);
	DisplaySetData();
	DeviceWrite(value);
	DisplayDisable();
}

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


/*********************************************************************
* Function:  void ResetDevice()
*
* PreCondition: none
*
* Input: none
*
* Output: none
*
* Side Effects: none
*
* Overview: resets LCD, initializes PMP
*
* Note: none
*
********************************************************************/
#define LCD_nRESET LATCbits.LATC1
void ResetDevice()
{
/*  SetLCDPorts();
  Init_MCU();*/
	// Initialize the device
	DriverInterfaceInit();
	DelayMs(1);				// Delay to let controller ready for next SetReg command

/*  LCD_nRESET = 1;
DelayMs(1); // Delay 1ms
LCD_nRESET = 0;
DelayMs(10); // Delay 10ms // This delay time is necessary
LCD_nRESET = 1;
DelayMs(120); // Delay 120 ms*/

  ResetLCD();

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
LCD_ILI9341_Parameter(RGBSET | MVSET | MXSET);

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
DelayMs(120);
//delayms(120);
LCD_ILI9341_CMD(0x29);        //Display on

DisplayBacklightOn();

}


#ifdef USE_TRANSPARENT_COLOR
/*********************************************************************
* Function:  void TransparentColorEnable(GFX_COLOR color)
*
* Overview: Sets current transparent color.
*
* PreCondition: none
*
* Input: color - Color value chosen.
*
* Output: none
*
* Side Effects: none
*
********************************************************************/
void TransparentColorEnable(GFX_COLOR color)
{
    _colorTransparent = color;    
    _colorTransparentEnable = TRANSPARENT_COLOR_ENABLE;

}
#endif

/*********************************************************************
* Function: void PutPixel(SHORT x, SHORT y)
* PreCondition: none
* Input: x,y - pixel coordinates
* Output: none
* Side Effects: none
* Overview: puts pixel
* Note: none
********************************************************************/
void PutPixel(SHORT x, SHORT y)
{
    if(_clipRgn)
    {
        if(x < _clipLeft)
            return;
        if(x > _clipRight)
            return;
        if(y < _clipTop)
            return;
        if(y > _clipBottom)
            return;
    }

    DisplayEnable();
    SetAddress(x, y);
    DisplaySetCommand();
    DeviceWrite(MemoryWrite);
    DisplaySetData();
    DeviceWrite(_color);
    DisplayDisable();
}

/*********************************************************************
* Function: GFX_COLOR GetPixel(SHORT x, SHORT y)
*
* PreCondition: none
*
* Input: x,y - pixel coordinates 
*
* Output: pixel color
*
* Side Effects: none
*
* Overview: return pixel color at x,y position
*
* Note: This implementation assumes an 8bit Data interface. 
*       For other data interface, this function should be modified.
*
********************************************************************/
GFX_COLOR GetPixel(SHORT x, SHORT y)
{ GFX_COLOR result;
    BYTE red = 0, green = 0, blue = 0;
    
    DisplayEnable();
    SetAddress(x, y);
    DisplaySetCommand();
    DeviceWrite(READMEMCONTINUE_REG);
    DisplaySetData(); 
    SingleDeviceRead();
    // read RED
	result = SingleDeviceRead();
/*    // read GREEN
	green = SingleDeviceRead();
    // read BLUE
	blue = SingleDeviceRead();*/

    DisplayDisable();
    return result;
//    return ((WORD) (((((GFX_COLOR)(red) & 0xF8) >> 3) << 11) | ((((GFX_COLOR)(green) & 0xFC) >> 2) << 5) | (((GFX_COLOR)(blue) & 0xF8) >> 3)));
}

/*********************************************************************
* Function: IsDeviceBusy()
*
* Overview: Returns non-zero if LCD controller is busy 
*           (previous drawing operation is not completed).
*
* PreCondition: none
*
* Input: none
*
* Output: Busy status.
*
* Side Effects: none
*
********************************************************************/
WORD IsDeviceBusy(void)
{  
    return (0);
}

/*********************************************************************
* Function: WORD Bar(SHORT left, SHORT top, SHORT right, SHORT bottom)
* PreCondition: none
* Input: left,top - top left corner coordinates,
*        right,bottom - bottom right corner coordinates
* Output: none
* Side Effects: none
* Overview: draws rectangle filled with current color
* Note: none
********************************************************************/
WORD Bar(SHORT left, SHORT top, SHORT right, SHORT bottom)
{
    register SHORT  x, y;

    #ifndef USE_NONBLOCKING_CONFIG
    while(IsDeviceBusy() != 0);

    /* Ready */
    #else
    if(IsDeviceBusy() != 0)
        return (0);
    #endif
    if(_clipRgn)
    {
        if(left < _clipLeft)
            left = _clipLeft;
        if(right > _clipRight)
            right = _clipRight;
        if(top < _clipTop)
            top = _clipTop;
        if(bottom > _clipBottom)
            bottom = _clipBottom;
    }

    DisplayEnable();
    
    SetRegion(left, right, top, bottom);
    DisplaySetCommand();
    DeviceWrite(MemoryWrite);
    DisplaySetData();
    for(y = top; y < bottom + 1; y++)
    {
      for(x = left; x < right + 1; x++)
      {
        DeviceWrite(_color);
      }
    }

//    SetRegion(0, GetMaxX(), 0, GetMaxY());
/*    for(y = top; y < bottom + 1; y++)
    {
        SetAddress(left, y);
        for(x = left; x < right + 1; x++)
        {
            WritePixel(_color);
        }
    }*/
//    SetRegion(0, GetMaxX(), 0, GetMaxY());
    DisplayDisable();
    return (1);
}

/*********************************************************************
* Function: void ClearDevice(void)
*
* PreCondition: none
*
* Input: none
*
* Output: none
*
* Side Effects: none
*
* Overview: clears screen with current color 
*
* Note: none
*
********************************************************************/
void ClearDevice(void)
{   int x, y;
    DisplayEnable();
    SetRegion(0, GetMaxX(), 0, GetMaxY());
    DisplaySetCommand();
    DeviceWrite(MemoryWrite);
    DisplaySetData();
    for (x = 0; x < GetMaxY() + 1; x++)
    {
      for (y = 0; y < GetMaxX() + 1; y++)
      {
        DeviceWrite(_color);
      }
    }
    DisplayDisable();
}

#ifndef USE_PRIMITIVE_PUTIMAGE

    #ifdef USE_BITMAP_FLASH

/*********************************************************************
* Function: void PutImage1BPP(SHORT left, SHORT top, FLASH_BYTE* image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
*
* PreCondition: none
*
* Input: left,top - left top image corner,
*        image - image pointer,
*        stretch - image stretch factor
*        pPartialImageData - (currently not implemented in this driver)
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs monochrome image starting from left,top coordinates
*
* Note: image must be located in flash
*
********************************************************************/
void PutImage1BPP(SHORT left, SHORT top, FLASH_BYTE *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
{
    register FLASH_BYTE *flashAddress;
    register FLASH_BYTE *tempFlashAddress;
    BYTE                temp = 0;
    WORD                sizeX, sizeY;
    WORD                x, y, currentXLocation;
    BYTE                stretchX, stretchY;
    WORD                pallete[2];
    BYTE                mask;

    // Move pointer to size information
    flashAddress = image + 2;

    // Read image size
    sizeY = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;
    sizeX = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;
    pallete[0] = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;
    pallete[1] = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;

    DisplayEnable();
    for(y = 0; y < sizeY; y++)
    {
        tempFlashAddress = flashAddress;
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            flashAddress = tempFlashAddress;
            SetAddress((WORD) left, (WORD) top);
            mask = 0;
            for(x = 0, currentXLocation = 0; x < sizeX; x++)
            {

                // Read 8 pixels from flash
                if(mask == 0)
                {
                    temp = *flashAddress;
                    flashAddress++;
                    mask = 0x01;
                }

                // Set color
                if(mask & temp)
                {
                    SetColor(pallete[1]);
                }
                else
                {
                    SetColor(pallete[0]);
                }

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
#ifdef USE_TRANSPARENT_COLOR
                    if (((GetTransparentColor() == GetColor()) && (GetTransparentColorStatus() == TRANSPARENT_COLOR_ENABLE)))
                    {
                        currentXLocation++;
                        SetAddress(left + currentXLocation , top);
                    }
                    else
#endif              
                    {
                        currentXLocation++;
                        WritePixel(_color);
                    }
                }

                // Shift to the next pixel
                mask <<= 1;
            }

            top++;
        }
    }

    DisplayDisable();
}

/*********************************************************************
* Function: void PutImage4BPP(SHORT left, SHORT top, FLASH_BYTE* image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
*
* PreCondition: none
*
* Input: left,top - left top image corner,
*        image - image pointer,
*        stretch - image stretch factor
*        pPartialImageData - (currently not implemented in this driver)
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs 16 color image starting from left,top coordinates
*
* Note: image must be located in flash
*
********************************************************************/
void PutImage4BPP(SHORT left, SHORT top, FLASH_BYTE *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
{
    register FLASH_BYTE *flashAddress;
    register FLASH_BYTE *tempFlashAddress;
    WORD                sizeX, sizeY;
    register WORD       x, y, currentXLocation;
    BYTE                temp = 0;
    register BYTE       stretchX, stretchY;
    WORD                pallete[16];
    WORD                counter;

    // Move pointer to size information
    flashAddress = image + 2;

    // Read image size
    sizeY = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;
    sizeX = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;

    // Read pallete
    for(counter = 0; counter < 16; counter++)
    {
        pallete[counter] = *((FLASH_WORD *)flashAddress);
        flashAddress += 2;
    }

    DisplayEnable();
    for(y = 0; y < sizeY; y++)
    {
        tempFlashAddress = flashAddress;
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            flashAddress = tempFlashAddress;
            SetAddress(left, top);
            for(x = 0, currentXLocation = 0; x < sizeX; x++)
            {

                // Read 2 pixels from flash
                if(x & 0x0001)
                {

                    // second pixel in byte
                    SetColor(pallete[temp >> 4]);
                }
                else
                {
                    temp = *flashAddress;
                    flashAddress++;

                    // first pixel in byte
                    SetColor(pallete[temp & 0x0f]);
                }

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
#ifdef USE_TRANSPARENT_COLOR
                    if (((GetTransparentColor() == GetColor()) && (GetTransparentColorStatus() == TRANSPARENT_COLOR_ENABLE)))
                    {
                        currentXLocation++;
                        SetAddress(left + currentXLocation, top);
                    }
                    else
#endif
                    {
                        WritePixel(_color);
                        currentXLocation++;
                    }
                }
            }

            top++;
        }
    }

    DisplayDisable();

}

/*********************************************************************
* Function: void PutImage8BPP(SHORT left, SHORT top, FLASH_BYTE* image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
*
* PreCondition: none
*
* Input: left,top - left top image corner,
*        image - image pointer,
*        stretch - image stretch factor
*        pPartialImageData - (currently not implemented in this driver)
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs 256 color image starting from left,top coordinates
*
* Note: image must be located in flash
*
********************************************************************/
void PutImage8BPP(SHORT left, SHORT top, FLASH_BYTE *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
{
    register FLASH_BYTE *flashAddress;
    register FLASH_BYTE *tempFlashAddress;
    WORD                sizeX, sizeY;
    WORD                x, y, currentXLocation;
    BYTE                temp;
    BYTE                stretchX, stretchY;
    WORD                pallete[256];
    WORD                counter;

    // Move pointer to size information
    flashAddress = image + 2;

    // Read image size
    sizeY = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;
    sizeX = *((FLASH_WORD *)flashAddress);
    flashAddress += 2;

    // Read pallete
    for(counter = 0; counter < 256; counter++)
    {
        pallete[counter] = *((FLASH_WORD *)flashAddress);
        flashAddress += 2;
    }

    DisplayEnable();
    for(y = 0; y < sizeY; y++)
    {
        tempFlashAddress = flashAddress;
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            flashAddress = tempFlashAddress;
            SetAddress(left, top);
            for(x = 0, currentXLocation = 0; x < sizeX; x++)
            {

                // Read pixels from flash
                temp = *flashAddress;
                flashAddress++;

                // Set color
                SetColor(pallete[temp]);

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
#ifdef USE_TRANSPARENT_COLOR
                    if (((GetTransparentColor() == GetColor()) && (GetTransparentColorStatus() == TRANSPARENT_COLOR_ENABLE)))
                    {
                        currentXLocation++;
                        SetAddress(left + currentXLocation, top);
                    }
                    else
#endif
                    {
                        WritePixel(_color);
                        currentXLocation++;
                    }
                }
            }

            top++;
        }
    }

    DisplayDisable();
}

/*********************************************************************
* Function: void PutImage16BPP(SHORT left, SHORT top, FLASH_BYTE* image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
*
* PreCondition: none
*
* Input: left,top - left top image corner,
*        image - image pointer,
*        stretch - image stretch factor
*        pPartialImageData - (currently not implemented in this driver)
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs hicolor image starting from left,top coordinates
*
* Note: image must be located in flash
*
********************************************************************/
void PutImage16BPP(SHORT left, SHORT top, FLASH_BYTE *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
{
    register FLASH_WORD *flashAddress;
    register FLASH_WORD *tempFlashAddress;
    WORD                sizeX, sizeY;
    register WORD       x, y, currentXLocation;
    WORD                temp;
    register BYTE       stretchX, stretchY;

    // Move pointer to size information
    flashAddress = (FLASH_WORD *)image + 1;

    // Read image size
    sizeY = *flashAddress;
    flashAddress++;
    sizeX = *flashAddress;
    flashAddress++;

    DisplayEnable();
    for(y = 0; y < sizeY; y++)
    {
        tempFlashAddress = flashAddress;
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            flashAddress = tempFlashAddress;
            SetAddress(left, top);
            for(x = 0, currentXLocation = 0; x < sizeX; x++)
            {

                // Read pixels from flash
                temp = *flashAddress;
                flashAddress++;

                // Set color
                SetColor(temp);

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
#ifdef USE_TRANSPARENT_COLOR
                    if (((GetTransparentColor() == GetColor()) && (GetTransparentColorStatus() == TRANSPARENT_COLOR_ENABLE)))
                    {
                        currentXLocation++;
                        SetAddress(left + currentXLocation, top);
                    }
                    else
#endif
                    {
                        WritePixel(_color);
                        currentXLocation++;
                    }
                }
            }

            top++;
        }
    }

    DisplayDisable();
}

    #endif // USE_BITMAP_FLASH
    #ifdef USE_BITMAP_EXTERNAL


/*********************************************************************
* Function: void PutImage1BPPExt(SHORT left, SHORT top, void* image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
*
* PreCondition: none
*
* Input: left,top - left top image corner,
*        image - image pointer,
*        stretch - image stretch factor
*        pPartialImageData - (currently not implemented in this driver)
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs monochrome image starting from left,top coordinates
*
* Note: image must be located in external memory
*
********************************************************************/
void PutImage1BPPExt(SHORT left, SHORT top, void *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
{
    register DWORD  memOffset;
    BITMAP_HEADER   bmp;
    WORD            pallete[2];
    BYTE            lineBuffer[((GetMaxX() + 1) / 8) + 1];
    BYTE            *pData;
    SHORT           byteWidth;

    BYTE            temp = 0;
    BYTE            mask;
    WORD            sizeX, sizeY;
    WORD            x, y, currentXLocation;
    BYTE            stretchX, stretchY;

    // Get image header
    ExternalMemoryCallback(image, 0, sizeof(BITMAP_HEADER), &bmp);

    // Get pallete (2 entries)
    ExternalMemoryCallback(image, sizeof(BITMAP_HEADER), 2 * sizeof(WORD), pallete);

    // Set offset to the image data
    memOffset = sizeof(BITMAP_HEADER) + 2 * sizeof(WORD);

    // Line width in bytes
    byteWidth = bmp.width >> 3;
    if(bmp.width & 0x0007)
        byteWidth++;

    // Get size
    sizeX = bmp.width;
    sizeY = bmp.height;

    for(y = 0; y < sizeY; y++)
    {

        // Get line
        ExternalMemoryCallback(image, memOffset, byteWidth, lineBuffer);
        memOffset += byteWidth;
        DisplayEnable();
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            pData = lineBuffer;
            SetAddress(left, top);
            mask = 0;
            for(x = 0, currentXLocation = 0; x < sizeX; x++)
            {

                // Read 8 pixels from flash
                if(mask == 0)
                {
                    temp = *pData++;
                    mask = 0x01;
                }

                // Set color
                if(mask & temp)
                {
                    SetColor(pallete[1]);
                }
                else
                {
                    SetColor(pallete[0]);
                }

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
#ifdef USE_TRANSPARENT_COLOR
                    if (((GetTransparentColor() == GetColor()) && (GetTransparentColorStatus() == TRANSPARENT_COLOR_ENABLE)))
                    {
                        currentXLocation++;
                        SetAddress(left + currentXLocation, top);
                    }
                    else
#endif
                    {
                        WritePixel(_color);
                        currentXLocation++;
                    }
                }

                // Shift to the next pixel
                mask <<= 1;
            }

            top++;
        }

        DisplayDisable();
    }
}

/*********************************************************************
* Function: void PutImage4BPPExt(SHORT left, SHORT top, void* image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
*
* PreCondition: none
*
* Input: left,top - left top image corner,
*        image - image pointer,
*        stretch - image stretch factor
*        pPartialImageData - (currently not implemented in this driver)
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs monochrome image starting from left,top coordinates
*
* Note: image must be located in external memory
*
********************************************************************/
void PutImage4BPPExt(SHORT left, SHORT top, void *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
{
    register DWORD  memOffset;
    BITMAP_HEADER   bmp;
    WORD            pallete[16];
    BYTE            lineBuffer[((GetMaxX() + 1) / 2) + 1];
    BYTE            *pData;
    SHORT           byteWidth;

    BYTE            temp = 0;
    WORD            sizeX, sizeY;
    WORD            x, y, currentXLocation;
    BYTE            stretchX, stretchY;

    // Get image header
    ExternalMemoryCallback(image, 0, sizeof(BITMAP_HEADER), &bmp);

    // Get pallete (16 entries)
    ExternalMemoryCallback(image, sizeof(BITMAP_HEADER), 16 * sizeof(WORD), pallete);

    // Set offset to the image data
    memOffset = sizeof(BITMAP_HEADER) + 16 * sizeof(WORD);

    // Line width in bytes
    byteWidth = bmp.width >> 1;
    if(bmp.width & 0x0001)
        byteWidth++;

    // Get size
    sizeX = bmp.width;
    sizeY = bmp.height;

    for(y = 0; y < sizeY; y++)
    {

        // Get line
        ExternalMemoryCallback(image, memOffset, byteWidth, lineBuffer);
        memOffset += byteWidth;
        DisplayEnable();
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            pData = lineBuffer;
            SetAddress(left, top);

            for(x = 0, currentXLocation = 0; x < sizeX; x++)
            {

                // Read 2 pixels from flash
                if(x & 0x0001)
                {

                    // second pixel in byte
                    SetColor(pallete[temp >> 4]);
                }
                else
                {
                    temp = *pData++;

                    // first pixel in byte
                    SetColor(pallete[temp & 0x0f]);
                }

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
#ifdef USE_TRANSPARENT_COLOR
                    if (((GetTransparentColor() == GetColor()) && (GetTransparentColorStatus() == TRANSPARENT_COLOR_ENABLE)))
                    {
                        currentXLocation++;
                        SetAddress(left + currentXLocation, top);
                    }
                    else
#endif
                    {
                        WritePixel(_color);
                        currentXLocation++;
                    }
                }
            }

            top++;
        }

        DisplayDisable();
    }
}

/*********************************************************************
* Function: void PutImage8BPPExt(SHORT left, SHORT top, void* image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
*
* PreCondition: none
*
* Input: left,top - left top image corner,
*        image - image pointer,
*        stretch - image stretch factor
*        pPartialImageData - (currently not implemented in this driver)
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs monochrome image starting from left,top coordinates
*
* Note: image must be located in external memory
*
********************************************************************/
void PutImage8BPPExt(SHORT left, SHORT top, void *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
{
    register DWORD  memOffset;
    BITMAP_HEADER   bmp;
    WORD            pallete[256];
    BYTE            lineBuffer[(GetMaxX() + 1)];
    BYTE            *pData;

    BYTE            temp;
    WORD            sizeX, sizeY;
    WORD            x, y, currentXLocation;
    BYTE            stretchX, stretchY;

    // Get image header
    ExternalMemoryCallback(image, 0, sizeof(BITMAP_HEADER), &bmp);

    // Get pallete (256 entries)
    ExternalMemoryCallback(image, sizeof(BITMAP_HEADER), 256 * sizeof(WORD), pallete);

    // Set offset to the image data
    memOffset = sizeof(BITMAP_HEADER) + 256 * sizeof(WORD);

    // Get size
    sizeX = bmp.width;
    sizeY = bmp.height;

    for(y = 0; y < sizeY; y++)
    {

        // Get line
        ExternalMemoryCallback(image, memOffset, sizeX, lineBuffer);
        memOffset += sizeX;
        DisplayEnable();
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            pData = lineBuffer;
            SetAddress(left, top);

            for(x = 0, currentXLocation = 0; x < sizeX; x++)
            {
                temp = *pData++;
                SetColor(pallete[temp]);

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
#ifdef USE_TRANSPARENT_COLOR
                    if (((GetTransparentColor() == GetColor()) && (GetTransparentColorStatus() == TRANSPARENT_COLOR_ENABLE)))
                    {
                        currentXLocation++;
                        SetAddress(left + currentXLocation, top);
                    }
                    else
#endif
                    {
                        WritePixel(_color);
                        currentXLocation++;
                    }
                }
            }

            top++;
        }

        DisplayDisable();
    }
}

/*********************************************************************
* Function: void PutImage16BPPExt(SHORT left, SHORT top, void* image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
*
* PreCondition: none
*
* Input: left,top - left top image corner,
*        image - image pointer,
*        stretch - image stretch factor
*        pPartialImageData - (currently not implemented in this driver)
*
* Output: none
*
* Side Effects: none
*
* Overview: outputs monochrome image starting from left,top coordinates
*
* Note: image must be located in external memory
*
********************************************************************/
void PutImage16BPPExt(SHORT left, SHORT top, void *image, BYTE stretch, PUTIMAGE_PARAM *pPartialImageData)
{
    register DWORD  memOffset;
    BITMAP_HEADER   bmp;
    WORD            lineBuffer[(GetMaxX() + 1)];
    WORD            *pData;
    WORD            byteWidth;

    WORD            temp;
    WORD            sizeX, sizeY;
    WORD            x, y, currentXLocation;
    BYTE            stretchX, stretchY;

    // Get image header
    ExternalMemoryCallback(image, 0, sizeof(BITMAP_HEADER), &bmp);

    // Set offset to the image data
    memOffset = sizeof(BITMAP_HEADER);

    // Get size
    sizeX = bmp.width;
    sizeY = bmp.height;

    byteWidth = sizeX << 1;

    for(y = 0; y < sizeY; y++)
    {

        // Get line
        ExternalMemoryCallback(image, memOffset, byteWidth, lineBuffer);
        memOffset += byteWidth;
        DisplayEnable();
        for(stretchY = 0; stretchY < stretch; stretchY++)
        {
            pData = lineBuffer;
            SetAddress(left, top);

            for(x = 0, currentXLocation = 0; x < sizeX; x++)
            {
                temp = *pData++;
                SetColor(temp);

                // Write pixel to screen
                for(stretchX = 0; stretchX < stretch; stretchX++)
                {
#ifdef USE_TRANSPARENT_COLOR
                    if (((GetTransparentColor() == GetColor()) && (GetTransparentColorStatus() == TRANSPARENT_COLOR_ENABLE)))
                    {
                        currentXLocation++;
                        SetAddress(left + currentXLocation, top);
                    }
                    else
#endif
                    {
                        WritePixel(_color);
                        currentXLocation++;
                    }
                }
            }

            top++;
        }

        DisplayDisable();
    }
}

    #endif //USE_BITMAP_EXTERNAL
#endif //#ifndef USE_PRIMITIVE_PUTIMAGE

//#endif // #if defined (GFX_USE_DISPLAY_CONTROLLER_ILI9341)

