section .rodata
    align 8

%assign QUOTE_ID 0

%macro QUOTE 1+
q%+QUOTE_ID:
    db %1, 0
    %assign QUOTE_ID QUOTE_ID + 1
%endmacro

; ============================================================
;                         QUOTES
; ============================================================

    ; --- Game Quotes ---

        ; Guilty Gear
        ; Look at how little damage i do
            QUOTE "Heaven or Hell, let's rock!"
            QUOTE "Mankind knew that they cannot change society.", 0xA, \
                  "So instead of reflecting on themselves, they blamed the Beasts."

            ; Guilty Gear Strive
                QUOTE "There is no salvation, only armageddon."
                QUOTE "There is no salvation for the unforgiven."
                QUOTE "Pitch black. Pure white. All the same."
                QUOTE "Where there is no beginning and no end. Will I be like that?"
                QUOTE "I may not be able to make you smile, but I'll never make you cry."
                QUOTE "If a room without a sky is what we idolise, it’s a dead tommorow."
                QUOTE "It took me 10 years to find the answer to something. I forgot it in about 2 seconds."
                QUOTE "Life is about swimming against the harshest waves.", 0xA, \
                      "The moment you give in, you get wiped out."

                QUOTE "Nothing can be done without hope." ; Ky's quote on the back of his jacket
                QUOTE "Do not wallow in defeat. Take pride that you did your best."  ; Nagoriyuki
                QUOTE "Projectiles are bullshit" ; Sol Badguy VOLVANIC VIPER, BANDIT REVOLVER 
                QUOTE "Today's tragedy is the comedy of tomorrow" ; Axl Low

            ; Guilty Gear Xrd
                QUOTE "Trick, cheat, fraud, lie, sulfur in the air."
                QUOTE "Give me a break, you damned.", 0xA, \
                      "Just wanna get back my dice again."
                QUOTE "Blazing down, what a heavy day."

            ; Guilty Gear XX
                QUOTE "Take your time. You will find purpose in your life as you go." ; Slayer win quote to Testament

            ; Guilty Gear (Original)
                QUOTE "My rule is never to show any mercy to women.", 0xA, \
                      "In a battle, everyone's an enemy... even children." ; Chipp

        ; Fallout
            QUOTE "War, war never changes. Men do, through the roads they walk."

            ; Fallout: New Vegas
                QUOTE "I survived because the fire inside me burned brighter than the fire around me."

        ; Persona
            QUOTE "I am thou, thou art I..."

            ; Revelations: Persona
            QUOTE "Lived in buried memory, with fear-ridden self-consciousness, I'm just a lone prayer"

            ; Persona 3
                QUOTE "The Arcana is the means by which all is revealed."
                QUOTE "The meeting of two personalities is like the contact of two chemical substances:", 0xA, \
                      "if there is any reaction, both are transformed."
                QUOTE "Forgetting pain provides relief, but only leads to repetition."
                QUOTE "Man believes what he wants to believe in the way he wants."
                QUOTE "He who has a why to live for can bear almost any how."
                QUOTE "Man was born free, and everywhere he is in chains."
                QUOTE "Life is the law, death merely sleep."

                QUOTE "I once ran away from the god of fear, and he chained me to despair."
                QUOTE "I will burn my dread."

            ; Persona 4
                QUOTE "Bonds of people is the true power."
                QUOTE "I Am A Shadow, The True Self."
                QUOTE "Signs of love overshadowed by dreams"
                QUOTE "Great vegetables."
                QUOTE "Reach out to the truth."
                QUOTE "The strength of heart required to face oneself has been made manifest."
                QUOTE "There's no easy way for real bliss", 0xA, \
                      "So I keep on fighting for beauty of destiny"
                QUOTE "I wanna know", 0xA, \
                      "Even it may hurt, even it brings pain within", 0xA, \
                      "My mind's determined, I need to know", 0xA, \
                      "Even it may kill, even it may change me", 0xA, \
                      "Ready to face truth"
                QUOTE "Ignorance is not bliss."
                QUOTE "They say that truth will out, can't keep on hiding."

        ; NieR
            ; NieR: Automata
                QUOTE "Everything that lives is designed to end.", 0xA, \
                      "We are perpetually trapped in a never-ending spiral of life and death."
                QUOTE "A future is not given to you. It is something you must take for yourself."
                QUOTE "Do you think games are silly little things?"
                QUOTE "I never quite realized... how beautiful this world is."

        ; Dota
            QUOTE "Zet is the Self, and the Self is Zet."
            
            QUOTE "A dazzling death."
            QUOTE "Where my shadow falls, there falls my foe."
            QUOTE "The enemy pales when they see the face of Dazzle!"
            QUOTE "Take a care when my shadow falls upon the foe."
            QUOTE "If killing you is wrong, I don't want to be right."

    ; --- Anime Quotes ---

        ; Monogatari
            QUOTE "I don't know everything, I only know what I know."
            QUOTE "If you want to die tomorrow, I'm ready for my life to end tomorrow - ", 0xA, \
                  "if you care to live for today, then so will I"

        ; Steins;Gate
            QUOTE "No one knows what the future holds, that's why its potential is infinite."
            QUOTE "The universe has a beginning, but no end. - Infinite.", 0xA, \
                  "Stars, too, have their own beginnings, but their own power results in their destruction. - Finite.", 0xA, \
                  "It is those who possess wisdom who are the greatest fools. History has shown us this.", 0xA, \
                  "You could say that this is the last warning from God to those who resist."

        ; Serial Experiments Lain
            QUOTE "Present day, present time. Hahaha!"
            QUOTE "No matter where you go, everyone's connected."
            QUOTE "If you're not remembered, then you never existed."
            QUOTE "The physical body exists at a less evolved plane only to verify one's existence in the universe."

        ; Berserk
            QUOTE "Even if we painstakingly piece together something lost, it doesn't mean things will ever go back to how they were"

    ; --- Another Quotes ---
	QUOTE "Let the bloodshed begin!" ; From Tekken, maybe

section .rodata
    align 8
    newline db 0x0A

quotes_table:
%assign i 0
%rep QUOTE_ID
    dq q%+i
    %assign i i+1
%endrep

quotes_count equ QUOTE_ID

section .text
    global get_random_quote

; --- Internal: RAX = mixed random, RDX = index ---
;_get_rand_index:
;    rdtsc
;    shl rdx, 32
;    or  rax, rdx
;    mov rcx, rax
;    shl rcx, 13
;    xor rax, rcx
;    shr rax, 7
;    xor rdx, rdx
;    mov rcx, quotes_count
;    div rcx
;    ret
; The old version was slow due to div, so I chose the new one, which is faster

_get_rand_index:
    rdtsc
    shl rdx, 32
    or  rax, rdx

    ; Xorshift
    mov rcx, rax
    shr rcx, 12
    xor rax, rcx
    mov rcx, rax
    shl rcx, 25
    xor rax, rcx
    mov rcx, rax
    shr rcx, 27
    xor rax, rcx

    ; Apply Lemire's fast range reduction 
    ; index = (random_64bit * N) / 2^64
    mov rcx, quotes_count
    mul rcx
    ret

; --- Returns RAX = const char* ---
get_random_quote:
    call _get_rand_index
    lea  rax, [rel quotes_table]
    mov  rax, [rax + rdx * 8]
    ret

%ifidn __OUTPUT_FORMAT__, elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
