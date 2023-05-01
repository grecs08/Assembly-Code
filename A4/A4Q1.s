.equ MaxSize, 10       @ define constant MaxSize

Input:
    stmfd sp!, {lr}    @ save the return address
    mov r3, r2         @ r3 = size
    mov r4, r1         @ r4 = array address
    mov r5, #0         @ r5 = counter
input_loop:
    cmp r5, r3         @ check if counter == size
    beq input_done     @ if yes, exit loop
    ldrb r6, [r0]      @ read a character from UART
    cmp r6, #32        @ check if character is a space
    beq input_save     @ if yes, save the previous input
    strb r6, [r4], #1  @ store the input into the array and increment address
    add r5, #1         @ increment counter
    b input_loop       @ continue loop
input_save:
    strb r6, [r4], #1  @ store the input into the array and increment address
    add r5, #1         @ increment counter
    cmp r5, r3         @ check if counter == size
    beq input_done     @ if yes, exit loop
    b input_loop       @ otherwise, continue loop
input_done:
    sub r0, r3, r5     @ r0 = actual size of the array
    ldmfd sp!, {pc}    @ return from subroutine

SortAndPrint:
    stmfd sp!, {lr}    @ save the return address
    mov r3, r2         @ r3 = size
    mov r4, r1         @ r4 = array address
sort_loop:
    mov r5, #0         @ reset flag
    mov r6, #1         @ set index
inner_loop:
    cmp r6, r3         @ check if index == size
    beq sort_exit      @ if yes, exit inner loop
    ldr r7, [r4, r6, lsl #2]  @ load a[i]
    cmp r8, r7         @ check if a[i-1] > a[i]
    ble inner_cont     @ if no, continue loop
    str r8, [r4, r6, lsl #2]  @ swap a[i-1] and a[i]

inner_cont:
    add r6, #1         @ increment index
    b inner_loop       @ continue loop
sort_exit:
    cmp r5, #0         @ check if any swaps were made
    bne sort_loop      @ if yes, continue sorting
    mov r3, #0         @ r3 = 0 for Print subroutine
    mov r4, r1         @ r4 = array address
    b Print            @ call Print subroutine

Print:
    stmfd sp!, {lr}    @ save the return address
    mov r5, r1         @ r5 = array address
print_loop:
    cmp r2, #0         @ check if size == 0

    ldr r6, [r5], #4   @ load an element from the array
