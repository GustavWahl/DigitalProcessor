/*
r0 ---> a[]
r1 ---> i
r2 ---> j
r3 ----> aux[]
r4 ----> mid
r5 ----> pRigth
r6 ----> counter
*/

main:
    mov sp, #128
    add sp, sp, sp
    add sp, sp, sp
    add sp, sp, sp
    add sp, sp, sp
    add sp, sp, sp

    sub sp, sp, #8
    mov r0, #2
    str r0, [sp]
    mov r0, #1
    str r0, [sp, #4]
    mov r0, sp

    sub sp, sp, #8
    mov r0, #0
    str r0, [sp, #8]
    str r0, [sp, #12]
	mov r3, sp

	mov r1, #0
	mov r2, #2
    bl merge_s
    add r0, r0, #0

merge_s: 
       
	add r4, r1, r2 
    LSR r4, r4, #1 //mid
    
    add r5, r4, #1 //p rigth
        
    add r4, r4, #1 //left limit
    
    mov r6, r1 //k == 0
    mov r8, r2 // j == 4
    mov r9, r1 // i == 0    
    
    sub r2, r2, #1
loop:
    cmp r6, r2 // k <= j
    bge exit_loop

first_if:
    cmp r10, r4
    bne skip_1

    LSL r5, r5, #2
    add r0, r0, r5
    LSR r5, r5, #2
    
    ldr r12, [r0] // a[p_r]

    LSL r6, r6, #2
    add r3, r3, r6
    LSR r6, r6, #2
    
    str r12, [r3]  

    add r5, r5, #1 // r++
    b increment
    
skip_1:
    
    add r2, r2, #1 // j + 1
    cmp r2, r11 // if r === j + 1
    bne skip_2

    LSL r1, r1, #2
    add r0, r0, r1
    LSR r1, r1, #2
    
    ldr r12, [r0] //a[p_l]

    LSL r6, r6, #2
    add r3, r3, r6
    LSR r6, r6, #2
    
    str r12, [r3]
    
    add r1, r1, #1
    
    sub r2, r2, #1 //reduce j by 1 after if
    
    b increment
 
skip_2:
    sub r2, r2, #1 // reduce j by 1 after if

    LSL r1, r1, #2
    add r0, r0, r1
    LSR r1, r1, #2
    
    ldr r7, [r0] // a[L]

    LSL r5, r5, #2
    add r0, r0, r5
    LSR r5, r5, #2
    
    ldr r12, [r0] // a[R]
    cmp r7, r12
    bge else // a[L] < a[R]

    LSL r6, r6, #2
    add r3, r3, r6
    LSR r6, r6, #2
    
    str r7, [r3]
    add r1, r1, #1 // l++ 
    
    b increment

else:
   lsl r6, r6, #2
   add r3, r3, r6
   LSR r6, r6, #2
   
   str r12, [r3]
   add r5, r5, #1
      
   b increment
    
    
increment:
    add r6, r6, #1
    b loop

exit_loop:
   mov r6, #0
copy_loop:
   cmp r6, r8
   bgt exit

   lsl r6, r6, #2
   add r3, r3, r6
   add r0, r0, r6
   
   ldr r7, [r3]
   str r7, [r0]

   lsr r6, r6, #2
   
   add r6, r6, #1
   
   b copy_loop
exit:
    bx lr
