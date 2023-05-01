.global main
main:
    @ Set up the stack pointer
    ldr r0, =0x10000000
    mov sp, r0
    
    @ Initialize variables
    ldr r1, =SIZE
    ldr r2, =1
    ldr r3, =2
    
    @ Print upper half of diamond
    loop1:
        cmp r2, r1
        bgt loop2
        mov r4, #0
        loop3:
            cmp r4, r2
            bge newline1
            ldr r0, =42
            bl putchar
            ldr r0, =32
            bl putchar
            add r4, r4, #1
            b loop3
        newline1:
            mov r4, #0
            bl putchar
            bl putchar
            add r2, r2, #1
            b loop1
    
    @ Print lower half of diamond
    loop2:
        cmp r2, #0
        ble exit
        mov r4, #0
        loop4:
            cmp r4, r2
            bge newline2
            ldr r0, =42
            bl putchar
            ldr r0, =32
            bl putchar
            add r4, r4, #1
            b loop4
        newline2:
            mov r4, #0
            bl putchar
            bl putchar
            sub r2, r2, #1
            b loop2
    
    @ Exit program
    exit:
        mov r0, #0
        bx lr
    
    @ putchar function
    putchar:
        @ Store registers
        push {r4, lr}
        
        @ Write character to UART
        mov r4, r0
        ldr r0, =0x101f1000
        ldr r1, =0x00000020
        strb r4, [r0, r1]
        
        @ Restore registers and return
        pop {r4, pc}
    
SIZE:
    .word 5
