// Assignment 2

 

// Constants

.equ UART_BASE, 0xff201000     // UART base address

.equ MASK, 0x0F

.equ DIGIT, 0x30

.equ LETTER, 0x37

.org    0x1000    // Start at memory location 1000

.data               // Data Section
my_var:     .word   0x12345678      // Define a 32-bit word variable 'my_var' with initial value 0x12345678

.text  // Code Section

.global _start

_start:

LDR R3, =my_var     // Load the address of 'my_var' into R3
LDR R3, [R3]        // Load the value of 'my_var' into R3
    
// Toggle the 8th bit of r3
MOV R2, #0x00000100     // Create a mask with only the 8th bit set to 1
EOR R3, R3, R2          // Apply the mask to R3 using EOR to toggle the 8th bit

// Print R3 to UART as ASCII

LDR R0, =UART_BASE

MOV R1,#8

// Print the register contents as ASCII characters

// Assumes value to print is in R3, UART address in R0

// Uses R1 for counter and R2 for temporary value

// R0 and R3 are preserved

TOP:

ROR R3,#28            // Rotate next four bits to LSB

MOV R2,R3            // Copy to R2 for masking

AND R2,R2,#MASK       // Keep last 4 bits only

CMP R2,#9            // Compare last 4 bits to 9

ADDLE R2,R2,#DIGIT    // add ASCII coding for 0 to 9

ADDGT R2,R2,#LETTER   // add ASCII coding for A to F

STR R2,[R0]           // Copy ASCII byte to UART

SUB R1,#1            // Move to next byte

CMP r1,#0            // Compare the countdown value to 0

BGT TOP              // Branch to TOP if greater than 0

 

_stop:

B    _stop