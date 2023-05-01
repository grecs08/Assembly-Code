/*
 * l04_t02.s
 * Reads a string from the UART and writes it back to the UART until Enter key is pressed
 * Author: Andrew Greco
 */
 // Constants            
.equ UART_BASE, 0xff201000     // UART base address
.equ SIZE, 80        // Size of string buffer storage (bytes)
.equ VALID, 0x8000   // Valid data in UART mask
.equ ENTER, 0x0a
.org 0x1000       // Start at memory location 1000

.global _start
_start:

// read a string from the UART
LDR R1, =UART_BASE
LDR R4, =READ_STRING
ADD R5, R4, #SIZE // store address of end of buffer
LOOP:
LDRB R0, [R1] // load a single byte from the string
CMP R0, #ENTER
BEQ _stop  // stop when the null character is found
STRB R0, [R4] // store the character in memory
ADD R4, R4, #1  // move to next character in memory
CMP R4, R5   // end program if buffer full
BEQ _stop
B LOOP
_stop:
B _stop

.data  // Data Section
// Set aside storage for a string
READ_STRING:
.space SIZE
.end 

/*
If all of the data in the Read FIFO is not read, 
the unread data will remain in the FIFO until it 
is read by the program or cleared. However, if 
the amount of unread data in the FIFO exceeds 
the size of the buffer in the program, the program
may not be able to read all of the unread data before 
the buffer is full.
*/