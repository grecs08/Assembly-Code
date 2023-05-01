// Assignment 2

 

// Constants

.equ UART_BASE, 0xff201000     // UART base address

.equ MASK, 0x0F

.equ DIGIT, 0x30

.equ LETTER, 0x37

.org    0x1000    // Start at memory location 1000

.text  // Code Section

.global _start

_start:

MOV R3,#6            // Move the value 6 into R3

LSL R3,R3,#3         // Logical shift left three times
LSL R3,R3,#3
LSL R3,R3,#3

ADD R3,R3,#1         // Add one to R3

ROR R3,R3,#4         // Rotate right four times
ROR R3,R3,#4
ROR R3,R3,#4
ROR R3,R3,#4

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