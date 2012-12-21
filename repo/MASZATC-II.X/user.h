/******************************************************************************/
/* User Level #define Macros                                                  */
/******************************************************************************/

/* TODO Application specific user parameters used in user.c may go here */

#define	BUTTON_UP	3
#define BUTTON_DOWN	2
#define BUTTON_ENTER	0
#define BUTTON_EXIT	7
#define BUTTON_MENU	6
#define BUTTON_START_STOP	5

typedef union {
    struct {
        unsigned	S407                : 1;
        unsigned	S406                : 1;
        unsigned	S405                : 1;
        unsigned	S404                : 1;
        unsigned	S403                : 1;
        unsigned	S402                : 1;
        unsigned	S401                : 1;
        unsigned	S400                : 1;
    };
    struct {
        unsigned	EXIT                : 1;
        unsigned	MENU                : 1;
        unsigned	START_STOP          : 1;
        unsigned                            : 1;
        unsigned	UP                  : 1;
        unsigned	DOWN                : 1;
        unsigned                            : 1;
        unsigned	ENTER               : 1;
    };
} Struct_Buttons;

/******************************************************************************/
/* User Function Prototypes                                                   */
/******************************************************************************/

/* TODO User level functions prototypes (i.e. InitApp) go here */

void InitApp(void);         /* I/O and Peripheral Initialization */
/* Print byte value to binary character buffer to print the display. */
char* PrintBin(char* buffer, unsigned char data);