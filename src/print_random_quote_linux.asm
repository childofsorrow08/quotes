section .rodata
    align 8
    newline db 0x0A

section .text
    extern get_random_quote

    global print_random_quote

; --- Prints quote and newline ---
print_random_quote:
    call get_random_quote
    mov  rsi, rax               ; RSI = string address

    ; Calculate length (strlen)
    xor  rdx, rdx
.loop:
    cmp  byte [rsi + rdx], 0
    je   .done
    inc  rdx
    jmp  .loop
.done:

    ; Syscall: write(stdout, rsi, rdx)
    mov  rax, 1
    mov  rdi, 1
    syscall

    ; Syscall: write(stdout, newline, 1)
    mov  rax, 1
    mov  rdi, 1
    lea  rsi, [rel newline]
    mov  rdx, 1
    syscall
    ret

section .note.GNU-stack noalloc noexec nowrite progbits