/*
-------------------------------------------------------
sub_read.s
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
Author:  David Brown
ID:      999999999
Email:   dbrown@wlu.ca
Date:    2020-12-14
-------------------------------------------------------
*/
// Constants
.equ SIZE, 20    	// Size of string buffer storage (bytes)
.text  // Code section
.org	0x1000	// Start at memory location 1000
.global _start
_start:

MOV    R5, #SIZE
//load the first register with space for first
LDR    R4, =First
BL	   ReadString
//allocate space for second
LDR    R4, =Second
BL	   ReadString
//allocate space for third
LDR    R4, =Third
BL     ReadString
//allocate space for fourth
LDR    R4, =Last
BL     ReadString
    
_stop:
B	_stop

// Subroutine constants
.equ UART_BASE, 0xff201000     // UART base address
.equ VALID, 0x8000	// Valid data in UART mask
.equ DATA, 0x00FF	// Actual data in UART mask
.equ ENTER, 0x0A	// End of line character

ReadString:
/*
-------------------------------------------------------
Reads an ENTER terminated string from the UART.
-------------------------------------------------------
Parameters:
  R4 - address of string buffer
  R5 - size of string buffer
Uses:
  R0 - holds character to print
  R1 - address of UART
-------------------------------------------------------
*/

// Set up variables
PUSH  {R0, R1, R2, R3}  // Save registers
MOV   R2, R4            // Copy string buffer address to R2
ADD   R3, R4, R5        // Calculate end of buffer address
SUBS  R5, R5, #1        // Adjust size to allow for null terminator

LOOP:
LDR   R0, [R1]          // Read the UART data register
TST   R0, #VALID        // Check if there is new data
BEQ   END              // If no data, exit loop
STRB  R0, [R2], #1      // Store the character in memory and move to next byte
CMP   R2, R3            // Check if end of buffer reached
BEQ   END              // If buffer full, exit loop
CMP   R0, #ENTER        // Check if end of string character
BNE   LOOP             // If not end of string, continue loop

// End of string reached
MOV   R0, #0            // Store null terminator at end of string
STRB  R0, [R2], #1
END:
POP   {R0, R1, R2, R3}  // Restore registers
BX    LR               // Return from subroutine

//end of subroutine
_ReadString:
LDR R0,=ENTER //add an enter after the string is processed
STR R0, [R1]
LDMFD  SP!, {R0-R1, R4,R5, PC} //restore registers to original values in stack

.data
.align
// The list of strings
First:
.space  SIZE
Second:
.space	SIZE
Third:
.space	SIZE
Last:
.space	SIZE
_Last:    // End of list address

.end