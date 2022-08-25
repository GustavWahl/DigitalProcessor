/* find_max_s - find the maximum value in an interger array */

main:
   mov sp, #128
   add sp, sp, sp
   add sp, sp, sp
   add sp, sp, sp
   add sp, sp, sp
   add sp, sp, sp
   
   sub sp, sp, #40
   mov r0, #1
   str r0, [sp]
   mov r0, #99
   str r0, [sp, #4]
   mov r0, #1
   str r0, [sp, #8]
   mov r0, #2
   str r0, [sp, #12]
   mov r0, #3
   str r0, [sp, #16]
   mov r0, #4
   str r0, [sp, #20]
   mov r0, #5
   str r0, [sp, #24]
   mov r0, #6
   str r0, [sp, #28]
   mov r0, #7
   str r0, [sp, #32]
   mov r0, #0
   str r0, [sp, #36]
   
   mov r0, sp
   mov r1, #10
   mov r2, #0
   mov r3, #0
   bl find_max_s
   add r0, r0, #0

/*
 * r0 - int *array
 * r1 - int n
 *
 * r2 - int i
 * r3 - int max
 */     
find_max_s:
    mov r2, #1
    ldr r3, [r0]              /* r3 = array[0] */

find_max_loop:
    cmp r2, r1
    bge find_max_loop_exit
    mov r2, r2, LSL #2
    add r0, r0, r2
    mov r2, r2, LSR #2
    ldr r12, [r0] /* r12 = array[i] */
    cmp r12, r3
    ble find_max_not_greater
    mov r3, r12               /* r3 = array[i] */    

find_max_not_greater:
    add r2, r2, #1
    b find_max_loop

find_max_loop_exit:
    mov r0, r3
    bx lr
