; ----------------------------------------------------------------------------- ;
; It is not certain that this code will work, as I do not work with Windows.    ; 
; Theoretically, everything should be fine, but I cannot guarantee it.          ;
; ----------------------------------------------------------------------------- ;

section .rodata
    align 8
    newline db 0x0A

section .text
    extern get_random_quote

    extern GetStdHandle
    extern WriteFile

    global print_random_quote

print_random_quote:
    push r12
    push r13
    push r14
    sub  rsp, 48

    call get_random_quote
    mov  r12, rax

    ; strlen
    xor  r13, r13
.loop:
    cmp  byte [r12 + r13], 0
    je   .done
    inc  r13
    jmp  .loop
.done:

    mov  rcx, -11
    call GetStdHandle
    mov  r14, rax

    mov  rcx, r14
    mov  rdx, r12
    mov  r8, r13
    lea  r9, [rsp + 40]
    mov  qword [rsp + 32], 0
    call WriteFile

    mov  rcx, r14
    lea  rdx, [rel newline]
    mov  r8, 1
    lea  r9, [rsp + 40]
    mov  qword [rsp + 32], 0
    call WriteFile

    add  rsp, 48
    pop  r14
    pop  r13
    pop  r12
    ret