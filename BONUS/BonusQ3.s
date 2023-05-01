    .global _start
    .section .text
_start:
    MOV r0, #0x0   //initialize counter
    MOV r1, #0x0   //initialize character storage
    LDR r2, =ARRAY //load memory address of the input array
    LDR r3, [r2]   //load the word from memory
decode_loop:
    TST r3, #0x1   //check if the last bit is a 1
    BEQ print_char //if it is 0, print the stored character and reset the counter
    ADD r0, r0, #1 //increment the counter
    AND r3, r3, #0x7FFFFFFE //shift the word to the right by 1 bit
    CMP r0, #3     //check if 3 bits have been read
    BNE decode_loop //if not, continue reading bits
    //if 3 bits have been read, determine the character and store it in r1
    CMP r3, #0x1
    MOVEQ r1, #0x61 //'a'
    CMP r3, #0x3
    MOVEQ r1, #0x62 //'b'
    CMP r3, #0x7
    MOVEQ r1, #0x63 //'c'
    CMP r3, #0x0
    BEQ print_space //if the character is a space, print it and reset the counter
    B print_char   //if the character is not a space, print the stored character and reset the counter
print_char:
    MOV r0, #0x0   //reset the counter
    MOV r1, #0x0   //reset the character storage
    B decode_loop  //continue decoding the word
print_space:
 
 
    MOV r1, #0x0   //reset the character storage
    B decode_loop  //continue decoding the word
    .section .data
ARRAY:
    .word 0xaeed76d6
