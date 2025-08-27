bits 16
org 0x7c00
init: 

jmp kernel
gdt_start:

gdt_null:
    dd 0x0
    dd 0x0

gdt_code:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10011010b
    db 11001111b
    db 0x0

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
kernel:
    mov ax, 0
    mov ss, ax
    mov sp, 0xFFFC

    mov ax, 0
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    cli
    lgdt[gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:b32

[bits 32]
nop 

b32:
    mov ax, DATA_SEG
    mov fs, ax
    mov gs, ax
    ;mov ax, 0
    mov ds, ax
    mov es, ax
    mov ss, ax

    mov ebp, 0x9FF00
    mov esp, ebp
;start eax ebx ecx edx to enter on program
    mov eax,0
    mov ebx,0
    mov ecx,0xf000
    mov edx,0
    mov esi,0
    mov edi,0
    ds
    call dword 0x70000
exits:
hello:
db 'hello world.....', 0
spere:
times  510-(spere-init) db 0 
signature:
dw 0xaa55
mov ax,0
mov ds,ax
mov eax,0
mov ds,ax
mov es,ax
mov ebx,0xb8000
mov ecx,2000
mov eax,0x6020

loop8:
    mov [ebx],ax
    inc ebx
    inc ebx
    dec ecx
    cmp ecx,0
    jnz loop8

loop9:
    jmp loop9

halts:
    jmp halts


