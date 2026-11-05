    .syntax     unified     /*сделали нормальный синтаксис*/
    .cpu        cortex-m3   
    .thumb          /*всё в режиме thumb*/

    .section    isr_vector, "a", %progbits  /*секция вектора*/
    .align      2   /* 2^2 = 4 выравнивание 4 байта*/
    .long       _stack  /* Начало MSP */
    .long       Reset_Handler   

    .long       Default_Handler
    .long       Default_Handler
    .long       Default_Handler
    .long       Default_Handler
    .long       Default_Handler

    .long       0
    .long       0
    .long       0
    .long       0

    .long       Default_Handler
    .long       Default_Handler
    
    .long       0

    .long       Default_Handler
    .long       Default_Handler

    .text       
    .global     Reset_Handler
    .thumb_func
    Reset_Handler:

    ldr r0,     =_data_load
    ldr r1,     =_data_start
    ldr r2,     =_data_end

    data_loop: 
        cmp r1, r2
        beq data_done
        ldr r3, [r0]
        str r3, [r1]
        add r0, r0, #4
        add r1, r1, #4
        b data_loop
        
    data_done:
        mov r3, #0
        ldr r4,     =_bss_start
        ldr r5,     =_bss_end

    bss_loop:
        cmp r4, r5
        beq bss_done
        str r3, [r4]
        add r4, r4, #4
        b bss_loop
    
    bss_done:
        bl main
    
    stop:
        b stop
        
    .thumb_func
    Default_Handler:
        b Default_Handler
