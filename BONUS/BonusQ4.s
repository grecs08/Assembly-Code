.data
word: .word 0x12345678  @ example word to modify

.text
.global main
main:
    ldr r0, =word    @ load word into r0
    ldr r1, [r0]     @ load the value of the word into r1
    
    mov r2, #1       @ initialize r2 to 1 (used for counting consecutive 1s)
    mov r3, #1       @ initialize r3 to 1 (used for counting consecutive 0s)
    mov r4, #0       @ initialize r4 to 0 (used for storing the modified word)
    
    loop:
        lsr r5, r1, #1    @ shift the value of r1 right by 1 bit and store in r5
        cmp r1, #0        @ check if the value of r1 is zero
        beq done          @ if it is, jump to the "done" label
        ands r6, r5, #1   @ mask out the least significant bit of r5 and store in r6
        
        @ check for consecutive 1s
        cmp r6, #1
        bne check_zero    @ if r6 is not 1, jump to the "check_zero" label
        add r2, r2, #1    @ increment the consecutive 1s counter
        cmp r2, #3        @ check if there are 3 consecutive 1s
        bne no_toggle     @ if there are not, jump to the "no_toggle" label
        eor r6, r6, #1    @ toggle the least significant bit of r6
        mov r2, #1        @ reset the consecutive 1s counter
        
        b toggle_done     @ jump to the "toggle_done" label
        
    check_zero:
        @ check for consecutive 0s
        cmp r6, #0
        bne no_toggle     @ if r6 is not 0, jump to the "no_toggle" label
        add r3, r3, #1    @ increment the consecutive 0s counter
        cmp r3, #2        @ check if there are 2 consecutive 0s
        bne no_toggle     @ if there are not, jump to the "no_toggle" label
        eor r6, r6, #1    @ toggle the least significant bit of r6
        mov r3, #1        @ reset the consecutive 0s counter
        
    no_toggle:
        str r6, [r4], #4  @ store the value of r6 in r4 and increment r4 by 4
        lsl r1, r1, #1    @ shift the value of r1 left by 1 bit and store in r1
        b loop            @ jump to the "loop" label
    
    toggle_done:
        str r6, [r4], #4  @ store the value of r6 in r4 and increment r4 by 4
        lsl r1, r1, #1    @ shift the value of r1 left by 1 bit and store in r1
        b loop            @ jump to the "loop" label
    
    done:
        bx lr             @ return from the function
