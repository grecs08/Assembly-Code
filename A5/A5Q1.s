```
.org 0x1000                
.text 
.global _start
_start:


ldr r0, =arr
ldr r1, =_end
sub r1, r1, r0
lsr r1, #2
stmfd sp!, {r0, r1}
bl buildHeap

_stop:
b _stop

heapify:
    stmfd sp!, {fp, lr} //Save registers to the stack
    mov fp, sp
	stmfd sp!, {r0-r9}
	
	ldr r0, [fp, #8] //Load arr from the stack
    ldr r1, [fp, #12] //Load N from the stack
	ldr r2, [fp, #16] // i 

    //Calculate l and r
    mov r3, r2 // largest
    lsl r4, r2, #1
	add r4, #1 // l
    lsl r5, r2, #1
	add r5, #2 // r

    //Check if l < N
    cmp r4, r1
    blt check_l_greater

    //If not, jump to check_r
    b check_r_greater

check_l_greater:
    //Check if arr[l] > arr[largest]
	lsl r6, r3, #2
	add r6, r0
	lsl r7, r4, #2
	add r7, r0
	ldr r6, [r6]
	ldr r7, [r7]
    cmp r7, r6
    ble check_r_greater

    //If yes, set largest = l
    mov r3, r4

check_r_greater:
    //Check if r < N
    cmp r5, r1
    blt check_r_largest

    //If not, jump to the next check
    b check_largest_not_i

check_r_largest:
    //Check if arr[r] > arr[largest]
	lsl r6, r3, #2
	add r6, r0
	lsl r7, r5, #2
	add r7, r0
	ldr r6, [r6]
	ldr r7, [r7]
	cmp r7, r6
    ble check_largest_not_i

    //If yes, set largest = r
    mov r3, r5

check_largest_not_i:
    //Check if largest != i
    cmp r3, r2
    beq end_heapify

    //If yes, swap arr[i] and arr[largest]
	lsl r6, r3, #2
	add r6, r0
	lsl r7, r2, #2
	add r7, r0
    ldr r8, [r6]
    ldr r9, [r7]
	
    str r8, [r7]
    str r9, [r6]

    //Recursive call to heapify(arr, N, largest)
    stmfd sp!, {r0, r1, r3} //Push largest as a parameter
    bl heapify //Call heapify subroutine
    ldmfd sp!, {r0, r1, r3}  //Pop the parameter from the stack

end_heapify:
    ldmfd sp!, {r0-r9}	// restore preserved registers
    ldmfd sp!, {fp, pc} //Restore registers and return

buildHeap:
    stmfd sp!, {fp, lr} //Save registers to the stack
    mov fp, sp
	stmfd sp!, {r0, r1, r2}
	
	ldr r0, [fp, #8] //Load arr from the stack
    ldr r1, [fp, #12] //Load N from the stack

    //Calculate startIdx
    lsr r2, r1, #1
	sub r2, r2, #1

buildHeap_loop:
    //Check if i >= 0
    cmp r2, #0
    blt end_buildHeap

    stmfd sp!, {r0, r1, r2} //Push largest as a parameter
    bl heapify //Call heapify subroutine
    ldmfd sp!, {r0, r1, r2}  //Pop the parameter from the stack

    //Decrement i
    sub r2, r2, #1

    //Continue the loop
    b buildHeap_loop

end_buildHeap:
    ldmfd sp!, {r0-r2}	// restore preserved registers
    ldmfd sp!, {fp, pc} //Restore registers and return


.data // Data Section
arr:
	.word 10, 13, 4, 5, 1, 4, 7
_end:
```