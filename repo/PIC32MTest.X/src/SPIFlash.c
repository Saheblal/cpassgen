

#include "SPIFlash.h"
#include "../system.h"     /* extern timer counter for timeout checking. */

#if defined SPI32_BIT
    #define SPI_BIT_MODE SPI_OPEN_MODE32
#elif defined SPI16_BIT
    #warning "The SPI16 bits functions not yet implemented (yet) :)"
#elif defined SPI8_BIT
    #define SPI_BIT_MODE SPI_OPEN_MODE8
#else
    #warning "Must be defined SPI mode (8, 16, or 32 bits). "\
    "#define one of those symbols: SPI32_BIT, SPI16_BIT, SPI08_BIT"
#endif
/* SEND_CLOCKS()
 * sending clocks with sending dummy byte for SPI bus. The number of clocks equal
 * the installad SPI bus width corresponding the SPIxCON MODE (8/16/32) bits.
 */

#define SEND_CLOCKS() SpiChnPutC(FLASH_MEM_SPI_CHANNEL, 0)

/* Initialize M25P80 Flash memory. Must be call during initialization process
 * before I/O operation, because here setting the port , and deselect CS line.
 * and Open SPI channel for flash memory.
 */

void SPIFlashInit()
{
    /* Output the flash CS I/O. */
    M25P80_CS_SET_OUTPUT();
    /* Deactivate the flash IC. */
    M25P80_CS_DEACTIVE();
    /* Initialize SPI channel for FlashRAM*/
    SpiChnOpen(FLASH_MEM_SPI_CHANNEL, SPI_OPEN_MSTEN | SPI_BIT_MODE, 4);
            //SPI_OPEN_CKP_HIGH, 4);
}

/************************************************************************
* Function: M25P80WriteEnable()
*
* Overview: this function allows writing into M25P80. Must be called
*           before every write/erase command
*
* Input: none
*
* Output: none
*
************************************************************************/

void M25P80WriteEnable()
{
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_CMD_WREN);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE()
}

void SPIFlashWriteEnable()
{
    M25P80_CS_ACTIVE();
    #if defined SPI32_BIT
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_CMD_WREN_W);
    #elif defined SPI16_BIT
    #elif defined SPI8_BIT
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_CMD_WREN);
    #endif
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
}

void SPIFlashWriteDisable()
{
    M25P80_CS_ACTIVE();
    #if defined SPI32_BIT
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_CMD_WRDI_W);
    #elif defined SPI16_BIT
    #elif defined SPI8_BIT
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_CMD_WRDI);
    #endif
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
}

#if defined SPI32_BIT
/* 32 bit Read Ident */
DWORD SPIFlashReadIdent(IDENT_STRUCT* ID)
{
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_READ_IDENT_WORD);
    ID->WORD = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
    return ID->WORD;
}
#elif defined SPI16_BIT
unsigned int    SPIFlashReadIdent(IDENT_STRUCT* ID);
#elif defined SPI8_BIT
unsigned char SPIFlashReadIdent(IDENT_STRUCT* ID)
{
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_READ_IDENT);
    /* I don't know why must to do this... */
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    /* Generate clocks with sending dummy byte. */
    SEND_CLOCKS();
    /* Read manufacturer ID. */
    ID->ManuID = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    SEND_CLOCKS();
    ID->TypeID = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    SEND_CLOCKS();
    ID->Capacity = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
    return ID->ManuID;
}
#endif

/****************************************************************************/
/* Function SPIFlashReadStatus()                                            */
/* Read flash memory's status register                                      */
/* Input: none                                                              */
/* Output: STATUS byte                                                      */
/****************************************************************************/

#if defined SPI32_BIT
unsigned char SPIFlashReadStatus()
{
    DWORD DUMMY;
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_CMD_RDSR_W);
    DUMMY = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
    return DUMMY;
}
#elif defined SPI16_BIT
#elif defined SPI8_BIT
unsigned char SPIFlashReadStatus()
{   unsigned char result;
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_CMD_RDSR);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    SEND_CLOCKS();
    result = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
    return result;
}
#endif

/****************************************************************************/
/* Function SPIFlashWriteStatus()                                           */
/* Write flash memory's status register with check                          */
/* Input: new status value                                                  */
/* Output: checked status byte                                              */
/****************************************************************************/

unsigned char SPIFlashWriteStatus(unsigned char value)
{
    SPIFlashWriteEnable();
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_WRT_STATUS);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, value);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
    SPIFlashWriteDisable();
    return (SPIFlashPollBusy(W_STAT_TIME) == -1) ? -1 : SPIFlashReadStatus();
}

/* Function SPIFlashPollBusy(int timeout);
 * Polling flash memory BUSY status bit, and return if BUSY goes low, or timeout
 * time is elapsed.
 * Input: timeout MAX time (in msec) max 32564
 * Output:  -1 : elapsed timeout millisec without change of BUSY bit
 *          0 - 32565: BUSY bit gone low at output millisec. */

#if defined SPI32_BIT
#elif defined SPI16_BIT
#elif defined SPI8_BIT
int SPIFlashPollBusy(int timeout)
    {  STAT_STRUCT stat; WORD elapsed;
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    ResetTimer();
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_CMD_RDSR);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    do {
        SEND_CLOCKS();
        stat.BYTE = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
        }while ((stat.BUSY) && ((elapsed = GetMillisec()) < timeout)) ;
    M25P80_CS_DEACTIVE();
    return (stat.BUSY) ? -1 : elapsed;
    };
#endif

#if defined SPI32_BIT
DWORD SPIFlashReadByte(DWORD address)
{   RWADDR_STRUCT command; DWORD result;
    command.COMMAND = M25P80_CMD_READ;
    command.ADDRESS = address;
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.WORD);
    result = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
    return result;
}
#elif defined SPI16_BIT
#elif defined SPI8_BIT
unsigned char SPIFlashReadByte(DWORD address)
{   unsigned char result; RWADDR_STRUCT command;
    command.COMMAND = M25P80_CMD_READ;
    command.ADDRESS = address;
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT1);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT2);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT3);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT4);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    
    SEND_CLOCKS();
    result = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
    return result;
}
#endif

/****************************************************************************/
/* Function SPIFlashWriteByte(DWORD address, BYTE value);                   */
/* Input DWORD address address to writing, value to write byte              */
/* Output: -1 if timeout occurs, else 0 if success                          */
/****************************************************************************/

#if defined SPI32_BIT
int SPIFlashWriteByte(DWORD address, BYTE value)
{   RWADDR_STRUCT command; DWORD result;
    command.COMMAND = M25P80_CMD_WRITE;
    command.ADDRESS = address;
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SPIFlashWriteEnable();
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.WORD);
    /* Write to data. */
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, value);
    M25P80_CS_DEACTIVE();
}
#elif defined SPI16_BIT
#elif defined SPI8_BIT
int SPIFlashWriteByte(DWORD address, BYTE value)
{   RWADDR_STRUCT command;
    command.COMMAND = M25P80_CMD_WRITE;
    command.ADDRESS = address;
    SPIFlashWriteEnable();
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT1);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT2);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT3);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT4);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, value);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    
    M25P80_CS_DEACTIVE();
    SPIFlashWriteDisable();
    return (SPIFlashPollBusy(W_BYTE_TIME) == -1) ? -1 : 0;
}

/****************************************************************************/
/* Function SPIFlashWriteWord(DWORD address, WORD value);                   */
/* Input DWORD address address to writing, word value                       */
/* Output: -1 if timeout occurs, else 0 if success                          */
/****************************************************************************/

#if defined SPI32_BIT
    void SPIFlashWriteWord(DWORD address, WORD value);
#elif defined SPI16_BIT
#elif defined SPI8_BIT
int SPIFlashWriteWord(DWORD address, WORD value)
{
    return SPIFlashWriteBuffer(address, (char*)&value, sizeof(WORD));
};
#endif

/****************************************************************************/
/* Function unsigned int SPIFlashReadWord(DWORD address);                   */
/* Input DWORD address address to writing, word value                       */
/* Output: reded word value                                                 */
/****************************************************************************/

#if defined SPI32_BIT
    unsigned int  SPIFlashReadWord(DWORD address);
#elif defined SPI16_BIT
#elif defined SPI8_BIT
WORD SPIFlashReadWord(DWORD address)
{   WORD result;
    SPIFlashReadBuffer(address, (char*)&result, sizeof(WORD));
    return result;
};
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

int SPIFlashBulkErase(int timeout)
{
    SPIFlashWriteEnable();
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    #if defined SPI32_BIT
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_CMD_ERASE_W);
    #elif defined SPI16_BIT
    #elif defined SPI8_BIT
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_CMD_ERASE);
    #endif
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
    SPIFlashWriteDisable();
    /* timeout check. */
    if (timeout)
    return SPIFlashPollBusy(timeout);
    else return 0;
}

/****************************************************************************/
/*    int SPIFlashSectorErase(DWORD address_in_sector);                     */
/* Function: Erase one sector of flash memory                               */
/* Input: address_in_sector any address in demand sector                    */
/* Output: -1 if timeout occurs, else 0 if success                          */
/****************************************************************************/

#if defined SPI32_BIT
#elif defined SPI16_BIT
#elif defined SPI8_BIT
int SPIFlashSectorErase(DWORD address_in_sector)
{   RWADDR_STRUCT command;
    command.COMMAND = M25P80_CMD_SER;
    command.ADDRESS = address_in_sector;
    SPIFlashWriteEnable();
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT1);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT2);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT3);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT4);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    M25P80_CS_DEACTIVE();
    SPIFlashWriteDisable();
    return (SPIFlashPollBusy(E_SECTOR_TIME) == -1) ? -1 : 0;
}
#endif

/****************************************************************************/
/* Function SPIFlashWriteBuffer(DWORD address, BYTE* buffer, int size);     */
/* Input DWORD address address to writing, buffer: pointer to writing buffer*/
/*  size: size of byte the writing buffer (max. 255)                        */
/* Output: -1 if timeout occurs, else 0 if success                          */
/****************************************************************************/

#if defined SPI32_BIT
int SPIFlashWriteBuffer(DWORD address, BYTE* buffer, int size);
#elif defined SPI16_BIT
#elif defined SPI8_BIT
int SPIFlashWriteBuffer(DWORD address, BYTE* buffer, int size)
{   RWADDR_STRUCT command; int i;
    command.COMMAND = M25P80_CMD_WRITE;
    command.ADDRESS = address;
    SPIFlashWriteEnable();
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT1);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT2);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT3);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT4);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    for (i = 0; i < size; i++)
    {
        SpiChnPutC(FLASH_MEM_SPI_CHANNEL, buffer[i]);
        SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    }

    M25P80_CS_DEACTIVE();
    SPIFlashWriteDisable();
    return (SPIFlashPollBusy(W_BYTES_TIME) == -1) ? -1 : 0;
}

#endif

/****************************************************************************/
/* Function SPIFlashReadBuffer(DWORD address, BYTE* buffer, int size);      */
/* Input DWORD address address to reading, buffer: pointer to store         */
/* readed datas                                                             */
/*  size: size of byte the reading buffer (max. 255)                        */
/* Output: readed byte                                                      */
/****************************************************************************/

#if defined SPI32_BIT
int SPIFlashReadBuffer(DWORD address, BYTE* buffer, int size)
#elif defined SPI16_BIT
#elif defined SPI8_BIT
int SPIFlashReadBuffer(DWORD address, BYTE* buffer, int size)
{   unsigned char result; RWADDR_STRUCT command; int i;
    command.COMMAND = M25P80_CMD_READ;
    command.ADDRESS = address;
    M25P80_CS_ACTIVE(); /*FLASH_MEM_SPI_CHANNEL*/
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT1);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT2);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT3);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, command.BT4);
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);

    for (i = 0; i < size; i++)
    {
        SEND_CLOCKS();
        buffer[i] = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    }

    M25P80_CS_DEACTIVE();
    return i;
};
#endif

/****************************************************************************/
/* void SPIFlashPowerDown();                                                */
/* Function: Executing the Deep Power-down (DP) instruction is the only way */
/* to put the device in the lowest consumption mode (the Deep Power-down    */
/* mode). Once the device has entered the Deep Power-down mode, all         */
/* instructions are ignored except the Release from Deep Power-down and     */
/* Read Device ID (RDI) instruction. This releases the device from this mode. */
/* TODO Must be try this procedure !!!                                      */
/****************************************************************************/

void SPIFlashPowerDown()
{
    M25P80_CS_ACTIVE();
    #if defined SPI32_BIT
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_POWER_DOWN_W);
    #elif defined SPI16_BIT
    #elif defined SPI8_BIT
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_POWER_DOWN);
    #endif
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
};

/****************************************************************************/
/* void SPIFlashRPowerDown();                                               */
/* Function: Release from Deep Power-down and Read Device ID (RDI)          */
/* instruction. This releases the device from this mode.                    */
/* TODO Must be try this procedure !!!                                      */
/****************************************************************************/

unsigned char SPIFlashRPowerDown()
{
    M25P80_CS_ACTIVE(); unsigned char result;
    #if defined SPI32_BIT
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_R_POWER_DOWN_W);
    #elif defined SPI16_BIT
    #elif defined SPI8_BIT
    SpiChnPutC(FLASH_MEM_SPI_CHANNEL, M25P80_R_POWER_DOWN);
    #endif
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    SEND_CLOCKS();
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    SEND_CLOCKS();
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    SEND_CLOCKS();
    SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    SEND_CLOCKS();
    result = SpiChnGetC(FLASH_MEM_SPI_CHANNEL);
    M25P80_CS_DEACTIVE();
    return result;
}


#endif





