/*
-------------------------------------------------------
l03_t02.s
A simple count down program (BGE)
-------------------------------------------------------
Author:  David Brown
ID:      999999999
Email:   dbrown@wlu.ca
Date:    2020-12-14
-------------------------------------------------------
*/
.org 0x1000 // Start at memory location 1000
.text // Code section
.global _start

.data
COUNTER: .word 5

_start:

LDR R3, =COUNTER // Load the value of COUNTER into R3

TOP:
SUB R3, R3, #1 // Decrement the countdown value
CMP R3, #0 // Compare the countdown value to 0
BGE TOP // Branch to top under certain conditions

_stop:
B _stop

.end

/*
t02 Answer:

The address of Counter in hexadecimal is 00001000.
/*