
#ifndef _SPIFlash_H
#define _SPIFlash_H

#include "HWP_MIKROE_PIC32_GP_SK_16PMP.h"
#include <plib.h>

/****************************************************************************/
/* SPI32_BIT                                                                */
/* here defined SPI channel mode You must decommented the appripriate mode  */
/* of your demand.                                                          */
/* TODO Must writing the 16 and 32 bits mode functions, because those       */
/* procedures are doesn't ready.                                            */
/****************************************************************************/

//#define SPI32_BIT
//#define SPI16_BIT
#define SPI8_BIT

#define SFLASHCSLow()      CS_FLASH_LAT_BIT=0;
#define SFLASHCSHigh()     CS_FLASH_LAT_BIT=1;

/*From hardwareconfig ..............*/

#define M25P80_CS_TRIS TRISCbits.TRISC2
#define M25P80_CS_LAT LATCbits.LATC2

/* W_STAT_TIME: max time in millisec to write status byte               */
#define W_STAT_TIME 2
/* W_BYTE_TIME: max time in millisec to write any byte                  */
#define W_BYTE_TIME 2
/* Sector erase timeout time in millisec */
#define E_SECTOR_TIME 1000
/* W_BYTES_TIME max time on bytes time writing (255 bytes max)          */
#define W_BYTES_TIME 5


/************************************************************************
* Macro: M25P80_CS_OUTPUT()
* Set output to M25P80 Flash chip select pin.
************************************************************************/

#define M25P80_CS_SET_OUTPUT() M25P80_CS_TRIS = 0;

/************************************************************************
* Macro: M25P80_CS_ACTIVE()
* Activate M25P80 Flash chip with to select to its CS pin pull down.
************************************************************************/

#define M25P80_CS_ACTIVE()    M25P80_CS_LAT = 0;

/************************************************************************
* Macro: M25P80_CS_DEACTIVE()
* Deactivate M25P80 Flash chip with to select to its CS pin pull down.
************************************************************************/

#define M25P80_CS_DEACTIVE()   M25P80_CS_LAT = 1;

/************************************************************************
* M25P80 Commands
* 8 Mbit, Low Voltage, Serial Flash Memory
* With 25 MHz SPI Bus Interface
* Memory address: 0 - 0xFFFFF bytes.
* The M25P80 is a 8 Mbit (1M x 8) Serial Flash
* Machanisms, accessed by a high speed SPI-compatible bus.
* The memory can be programmed 1 to 256 bytes at
* a time, using the Page Program instruction.
* The memory is organized as 16 sectors, each con-
* taining 256 pages. Each page is 256 bytes wide.
* Thus, the whole memory can be viewed as con-
* sisting of 4096 pages, or 1,048,576 bytes.
* The whole memory can be erased using the Bulk
* Erase instruction, or a sector at a time, using the
* Sector Erase instruction. Table 4.
* Instr.    Instruction         One-byte    Code    Address Dummy   Data
* Set       Description         Instr.Code  HEX.    Bytes   Bytes   Bytes
* WREN      Write Enable        0000 0110   0x06    0       0       0
* WRDI      Write Disable       0000 0100   0x04    0       0       0
* RDSR      Read Status Reg.    0000 0101   0x05    0       0       1 to ?
* WRSR      Write Status Reg.   0000 0001   0x01    0       0       1
* READ      Read Data Bytes     0000 0011   0x03    3       0       1 to ?
* FAST_READ Read Data Bytes     0000 1011   0x0B    3       1       1 to ?
*           at Higher Speed
* PP        Page Program        0000 0010   0x02    3       0       1 to 256
* SE        Sector Erase        1101 1000   0xD8    3       0       0
* BE        Bulk Erase          1100 0111   0xC7    0       0       0
* DP        Deep Power-down     1011 1001   0xB9    0       0       0
* READ      Release from ,      1010 1011   0xAB    0       3       1 to ?
*           Deep Power-down and
*           Read Electronic
*           Signature
*           Release from        1010 1011   0xAB    0       0       0
*           Deep Power-down
************************************************************************/

#define M25P80_CMD_WREN  (unsigned)0x06     /*Write Enable*/
#define M25P80_CMD_WREN_W (DWORD) 0x00000006
#define M25P80_CMD_WRDI  (unsigned)0x04     /*Write Disable*/
#define M25P80_CMD_WRDI_W (DWORD) 0x00000004

#define M25P80_CMD_READ  (unsigned)0x03     /*Read Data Bytes*/
#define M25P80_CMD_READ_W  (DWORD)0x03000000    

#define M25P80_CMD_WRITE (unsigned)0x02     /*Write data bytes */
#define M25P80_CMD_WRITE_W  (DWORD)0x02000000

#define M25P80_CMD_RDSR  (unsigned)0x05     /*Read Status Reg.*/
#define M25P80_CMD_RDSR_W (DWORD) 0x05000000        /*Read Status Reg word.*/

#define M25P80_CMD_EWSR  (unsigned)0x50     /*Enable write status register. */

#define M25P80_CMD_SER   (unsigned)0xD8     /*Sector Erase*/
#define M25P80_CMD_SER_W   (unsigned)0xD8000000     /*Sector Erase*/

#define M25P80_CMD_READ_HIGH_SPEED  (unsigned) 0x0B

#define M25P80_CMD_ERASE (unsigned) 0xC7            /*Bulk erase*/
#define M25P80_CMD_ERASE_W (DWORD) 0xC7000000       /*Bulk erase*/

#define M25P80_WRT_STATUS (unsigned) 0x01           /*Write Status Reg.*/
#define M25P80_WRT_STATUS_W (DWORD) 0x01000000      /*Write Status Reg.*/

#define M25P80_WEL_STATUS (unsigned) 0x02
#define M25P80_STATUS_MASK (unsigned) 0x60  /**/

#define M25P80_READ_IDENT (unsigned) 0x9F   /* Read identification command. */
#define M25P80_READ_IDENT_WORD (DWORD) 0x9F000000   /* Read identification dword */

#define M25P80_POWER_DOWN (unsigned) 0xB9   /* Executing and release power down mode */
#define M25P80_POWER_DOWN_w (DWORD) 0xB9000000

#define M25P80_R_POWER_DOWN (unsigned) 0xAB   /* Executing and release power down mode */
#define M25P80_R_POWER_DOWN_W (DWORD) 0xAB000000

#define M25P80_SELECT
#define M25P80_ELECTRONIC_SIGNATURE 0x013

/* IDENT_STRUCT structur for read flash identifier. */
typedef union  {
struct {
    BYTE Capacity;
    BYTE TypeID;
    BYTE ManuID;
    BYTE Dummy;
}__attribute__ ((packed));
struct {
    DWORD WORD;
}__attribute__ ((packed));
}IDENT_STRUCT;

/*Status registers bits*/
typedef union {
    struct {
        BYTE BUSY:   1;  /* BUSY bit. The BUSY bit indicates whether the memory is bu
                     * sy with a Write Status Register, Program or Erase cycle.
                     * When set to 1, such a cycle is in progress, when reset to
                     * 0 no such cycle is in progress. */
        BYTE  WEL:    1; /* The Write Enable Latch (WEL) bit indicates the status of
                     * the internal Write Enable Latch. When set to 1 the internal
                     * Write Enable Latch is set, when set to 0 the internal
                     * Write Enable Latch is reset and no Write Status Register,
                     * Program or Erase instruction is accepted. */
        BYTE  BP0:  1;
        BYTE  BP1:  1;
        BYTE  BP2:  1;
                        /*The Block Protect (BP2, BP1, BP0) bits are non-volatile.
                         * They define the size of the area to be software protected
                         * against Program and Erase instructions. These bits are
                         * written with the Write Status Register (WRSR) instruction.
                         * When one or both of the Block Protect (BP2, BP1, BP0) bits
                         * is set to 1, the relevant memory area (as defined in Table 3.)
                         * becomes protected against Page Program (PP)and Sector Erase (SE)
                         * instructions. The Block Protect (BP2, BP1, BP0) bits can be
                         * written provided that the Hardware Protected mode has not
                         * been set. The Bulk Erase (BE) instruction is executed if, and only if,
                         * both Block Protect (BP2, BP1, BP0) bits are 0.*/
        BYTE  RES:  2;
        BYTE  SRP:  1;  /*SRP bit. The Status Register Protect (SRP) bit is operated in
                         * conjunction with the Write Protect (WP#) signal. The Status
                         * Register Write Protect (SRP) bit and Write Protect (WP#) signal
                         * allow the device to be put in the Hardware Protected mode (when
                         * the Status Register Protect (SRP) bit is set to 1, and Write
                         * Protect (WP#) is driven Low). In this mode, the non-volatile
                         * bits of the Status Register (SRP, BP2, BP1, BP0) become read-only
                         * bits and the Write Status Register (WRSR) instruction is no longer
                         * accepted for execution.  */
    }__attribute__ ((packed));
    struct {
    BYTE BYTE;
    }__attribute__ ((packed));
}STAT_STRUCT;
/* RWADDR_STRUCT help for read write bytes. */
typedef union {
    struct {
        DWORD ADDRESS: 24;
        DWORD COMMAND: 8;
    }__attribute__ ((packed));
    struct {
        DWORD WORD;
    }__attribute__ ((packed));
    struct {
        DWORD HIWORD: 16;
        DWORD LOWORD: 16;
    }__attribute__ ((packed));
    struct {
        DWORD BT4: 8;
        DWORD BT3: 8;
        DWORD BT2: 8;
        DWORD BT1: 8;
    }__attribute__ ((packed));
}RWADDR_STRUCT;

/* SPIFlashInit Initialize MIKROE PIC32MX board SPI port of flash memory. */

void SPIFlashInit();

/************************************************************************
* Function: SPIFlashWriteEnable();
* Overview: this function allows writing into SPI Flash. Must be called
*           before every write/erase command
* Input: none
* Output: none
************************************************************************/

void SPIFlashWriteEnable();

/****************************************************************************/
/* Function SPIFlashReadStatus()                                            */
/* Read flash memory's status register                                      */
/* Input: none                                                              */
/* Output: STATUS byte                                                      */
/*  BITS: 0 = BUSY, 1 = Write enable latch, 2,3,4 = Block Protect 0,1,2     */
/*  5,6 = reserved, 7 = Status Register Protect bit                         */
/****************************************************************************/

unsigned char SPIFlashReadStatus();

/****************************************************************************/
/* Function SPIFlashWriteStatus()                                           */
/* Write flash memory's status register with check                          */
/* Input: new status value                                                  */
/* Output: checked status byte                                              */
/*  4   3   2  bit                                                          */
/* BP2 BP1 BP0  Protect Addresses           Density(KB)     Portion         */
/*              Sector                                                      */
/*  1   1   1   All     000000h-0FFFFFh     1024KB          All             */
/*  1   1   0   All     000000h-0FFFFFh     1024KB          All             */
/*  1   0   1   All     000000h-0FFFFFh     1024KB          All             */
/*  1   0   0   Sector 8 to 15 080000h-0FFFFFh 512KB        Upper 1/2       */
/*  0   1   1   Sector 12 to 15 0C0000h-0FFFFFh 256KB       Upper 1/4       */
/*  0   1   0   Sector 14 to 15 0E0000h-0FFFFFh 128KB       Upper 1/8       */
/*  0   0   1   Sector 15  0F0000h-0FFFFFh      64KB        Upper 1/16      */
/*  0   0   0   None        None            None            None            */

unsigned char SPIFlashWriteStatus(unsigned char value);

/****************************************************************************/
/* Function SPIFlashPollBusy(int timeout);                                  */
/* Polling flash memory BUSY status bit, and return if BUSY goes low, or    */
/* timeout time is elapsed.                                                 */
/* Input: timeout MAX time (in msec) max 32564                              */
/* Output:  -1 : elapsed timeout millisec without change of BUSY bit        */
/*          0 - 32565: BUSY bit gone low in at output millisec.             */
/****************************************************************************/

int SPIFlashPollBusy(int timeout);

/****************************************************************************/
/*Function SPIFlashReadIdent()                                              */
/* Read Identification byte from flash memory                               */
/* Result: flash manufacturer ID byte (0x1C in cfeon EN25P80 for example)   */
/* Output: store the (struct IDENT_STRUCT* ID) the flash manufacturer ID,   */
/* memory type ID, and capacity byte.                                       */
/****************************************************************************/

#if defined SPI32_BIT
    DWORD           SPIFlashReadIdent(IDENT_STRUCT* ID);
#elif defined SPI16_BIT
    unsigned int    SPIFlashIdent(IDENT_STRUCT* ID);
#elif defined SPI8_BIT
    unsigned char   SPIFlashReadIdent(IDENT_STRUCT* ID);
#endif

/****************************************************************************/
/*    void SPIFlashBulkErase(int timeout);                                  */
/* Function: Erase all flash memory                                         */
/* Input: if 32000 > timeout > 0 then this function waiting max. millisec   */
/* time until status.BUSY bit gone low. (cycle in progress end)             */
/*          if millisec = 0 then function return immediate when out the     */
/*          bulk erese command on SPI.                                      */
/* Output:  0: if timeout was 0 (no timeout check)                          */
/*          -1 if timeout > 0, but < (erasing time) (timeout)               */
/*          0- 32000 : if timeout > 0 erasing time in timeout (with         */
/*          check)                                                          */
/****************************************************************************/

#if defined SPI32_BIT
#elif defined SPI16_BIT
#elif defined SPI8_BIT
    int SPIFlashBulkErase(int timeout);
#endif

/****************************************************************************/
/*    int SPIFlashSectorErase(DWORD address_in_sector);                     */
/* Function: Erase one sector of flash memory                               */
/* Input: address_in_sector any address in demand sector                    */
/* Output: -1 if timeout occurs, else 0 if success                          */
/****************************************************************************/

#if defined SPI32_BIT
#elif defined SPI16_BIT
#elif defined SPI8_BIT
    int SPIFlashSectorErase(DWORD address_in_sector);
#endif

/****************************************************************************/
/* Function SPIFlashReadByte(DWORD address);                                */
/* Input DWORD address address to reading                                   */
/* Output: redaed byte                                                      */
/****************************************************************************/

#if defined SPI32_BIT
    DWORD SPIFlashReadByte(DWORD address);
#elif defined SPI16_BIT
#elif defined SPI8_BIT
    unsigned char SPIFlashReadByte(DWORD address);
#endif

/****************************************************************************/
/* Function SPIFlashWriteByte(DWORD address, BYTE value);                   */
/* Input DWORD address address to writing, value to write byte              */
/* Output: -1 if timeout occurs, else 0 if success                          */
/****************************************************************************/

#if defined SPI32_BIT
    void SPIFlashWriteByte(DWORD address, BYTE value);
#elif defined SPI16_BIT
#elif defined SPI8_BIT
    int SPIFlashWriteByte(DWORD address, BYTE value);
#endif

/****************************************************************************/
/* Function SPIFlashWriteWord(DWORD address, WORD value);                   */
/* Input DWORD address address to writing, word value                       */
/* Output: -1 if timeout occurs, else 0 if success                          */
/****************************************************************************/

#if defined SPI32_BIT
    void SPIFlashWriteWord(DWORD address, WORD value);
#elif defined SPI16_BIT
#elif defined SPI8_BIT
    int SPIFlashWriteWord(DWORD address, WORD value);
#endif

/****************************************************************************/
/* Function SPIFlashReadWord(DWORD address);                                */
/* Input DWORD address where stored the asking word value                   */
/* Output: WORD value                                                       */
/****************************************************************************/

#if defined SPI32_BIT
    WORD SPIFlashReadWord(DWORD address);
#elif defined SPI16_BIT
#elif defined SPI8_BIT
    WORD SPIFlashReadWord(DWORD address);
#endif


/****************************************************************************/
/* Function SPIFlashWriteBuffer(DWORD address, BYTE* buffer, int size);     */
/* Input DWORD address address to writing, buffer: pointer to writing datas */
/* buffer                                                                   */
/*  size: size of byte the writing buffer (max. 255)                        */
/* Output: -1 if timeout occurs, else 0 if success                          */
/****************************************************************************/

#if defined SPI32_BIT
    void SPIFlashWriteByte(DWORD address, BYTE value);
#elif defined SPI16_BIT
#elif defined SPI8_BIT
    int SPIFlashWriteBuffer(DWORD, BYTE*, int);
#endif

/****************************************************************************/
/* Function SPIFlashReadBuffer(DWORD address, BYTE* buffer, int size);      */
/* Input DWORD address address to reading, buffer: pointer to store         */
/* readed datas                                                             */
/*  size: size of byte the reading buffer (max. 255)                        */
/* Output: -1 if timeout occurs, else 0 if success                          */
/****************************************************************************/

#if defined SPI32_BIT
    void SPIFlashWriteByte(DWORD address, BYTE value);
#elif defined SPI16_BIT
#elif defined SPI8_BIT
    int SPIFlashReadBuffer(DWORD, BYTE*, int);
#endif


/****************************************************************************/
/* void SPIFlashPowerDown();                                                */
/* Function: Executing the Deep Power-down (DP) instruction is the only way */
/* to put the device in the lowest consumption mode (the Deep Power-down    */
/* mode). Once the device has entered the Deep Power-down mode, all         */
/* instructions are ignored except the Release from Deep Power-down and     */
/* Read Device ID (RDI) instruction. This releases the device from this mode. */
/****************************************************************************/

void SPIFlashPowerDown();

/****************************************************************************/
/* unsigned char SPIFlashRPowerDown();                                      */
/* Function: Release from Deep Power-down and Read Device ID (RDI)          */
/* instruction. This releases the device from this mode.                    */
/* Input: none                                                              */
/* Output: Device ID                                                        */
/****************************************************************************/

unsigned char SPIFlashRPowerDown();


#endif