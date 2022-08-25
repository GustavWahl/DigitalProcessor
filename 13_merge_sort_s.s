.global merge_s
.global merge_sort_s
.extern printf
/*
r0 ---> a[]
r1 ---> i
r2 ---> j
r3 ----> aux[]
r4 ----> mid
r5 ----> pRigth
r6 ----> counter
*/

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

    ldr r12, [r0, r5, LSL #2] // a[p_r]
    str r12, [r3, r6, LSL #2]  

    add r5, r5, #1 // r++
    b increment
    
skip_1:
    
    add r2, r2, #1 // j + 1
    cmp r2, r11 // if r === j + 1
    bne skip_2

    ldr r12, [r0, r1, LSL #2] //a[p_l]
    str r12, [r3, r6, LSL #2]
    
    add r1, r1, #1
    
    sub r2, r2, #1 //reduce j by 1 after if
    
    b increment
 
skip_2:
    sub r2, r2, #1 // reduce j by 1 after if
    
    ldr r7, [r0, r1, LSL #2] // a[L]
    ldr r12, [r0, r5, LSL #2] // a[R]
    cmp r7, r12
    bge else // a[L] < a[R]
    
    str r7, [r3, r6, LSL #2]
    add r1, r1, #1 // l++ 
    
    b increment

else:
   str r12, [r3, r6, LSL #2]
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
   ldr r7, [r3, r6, lsl #2]
   str r7, [r0, r6, LSL #2]
   
   add r6, r6, #1
   
   b copy_loop
exit:
    bx lr

merge_sort_s: /* r0 array, r1 i, r2 j, r3 aux */
    sub sp, sp, #32
    str lr, [sp]
    cmp r2, r1
    ble end_m_s // r1 less than or equal r0

    add r4, r1, r2
    LSR r4, r4, #1 // mid

    
    str r1, [sp, #4]
    str r2, [sp, #8]
    str r4, [sp, #12]
/*    str r0, [sp, #16]*/
    
    mov r2, r4 // j == mid   
    bl merge_sort_s

   /* ldr r0, [sp, #16] */
    ldr r4, [sp, #12]
    ldr r2, [sp, #8] // j == j
    ldr r1, [sp, #4]
    
    str r1, [sp, #4]
    str r2, [sp, #8]
    /*str r0, [sp, #12] */
    
    add r4, r4, #1
    mov r1, r4 // i = mid + 1
    
    bl merge_sort_s

  /*  ldr r0, [sp, #12]*/
    ldr r2, [sp, #8]
    ldr r1, [sp, #4] // i == i
    
    bl merge_s

end_m_s:
    ldr lr, [sp]
    add sp, sp, #32
    bx lr
