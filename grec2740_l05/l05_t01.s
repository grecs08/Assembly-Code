/*
-------------------------------------------------------
l05_t01.s
A program that calculates the sum of all values in a list and displays that value in r1.
R0: temp storage of value in list
R1: sum of all values in list
R2: address of start of list
R3: address of end of list
-------------------------------------------------------
Author:  Your Name
ID:      Your ID
Email:   your.email@domain.com
Date:    2023-03-03
-------------------------------------------------------
*/
.org	0x1000	// Start at memory location 1000
.text  // Code section
.global _start
_start:

LDR    R2, =Data    // Store address of start of list
LDR    R3, =_Data   // Store address of end of list
MOV    R1, #0       // Initialize sum to zero

Loop:
LDR    R0, [R2], #4  // Read address with post-increment (R0 = *R2, R2 += 4)
ADD    R1, R1, R0   // Add value to sum
CMP    R3, R2       // Compare current address with end of list
BNE    Loop         // If not at end, continue

_stop:
B	_stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data:	// End of list address

.end
