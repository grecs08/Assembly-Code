Fibonacci:
    stmfd sp!, {lr}     @ save the return address
    cmp r1, #0          @ check if n == 0
    moveq r0, #0        @ if yes, return 0
    beq fib_done
    cmp r1, #1          @ check if n == 1
    moveq r0, #1        @ if yes, return 1
    beq fib_done
    sub r2, r1, #1      @ calculate n-1
    sub r3, r1, #2      @ calculate n-2
    bl Fibonacci        @ recursive call for n-1
    mov r4, r0          @ save result for n-1
    bl Fibonacci        @ recursive call for n-2
    add r0, r4, r0      @ calculate result for n = (n-1) + (n-2)
fib_done:
    ldmfd sp!, {pc}     @ return from subroutine

