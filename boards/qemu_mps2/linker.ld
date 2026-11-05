MEMORY
{
    ROM (rx)    : ORIGIN = 0x00000000, LENGTH = 4M
    RAM (rwx)   : ORIGIN = 0x20000000, LENGTH = 4M
}

SECTIONS 
{

    .isr_vector:
    {
        KEEP(*(isr_vector));
    } >  ROM

    .text :
    {
        *(.text*)
    } > ROM

    .rodata :
    {
        *(.rodata*)
    } > ROM

    _stack = ORIGIN(RAM) + LENGTH(RAM);
    _data_load = LOADADDR(.data);

    .data :
    {
        . = ALIGN(4);
        _data_start = .;
        *(.data*)
        . = ALIGN(4);
        _data_end = .;
    } > RAM AT> ROM
    
    .bss :
    {
        . = ALIGN(4);
        _bss_start = .;
        *(.bss*)
        . = ALIGN(4);
        _bss_end = .;
    } > RAM

}