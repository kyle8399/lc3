; Initialization
;
        .ORIG   x3000
START   AND R2, R2, #0          ; R2 is counter, initially 0
        LD  R3, PTR             ; R3 is pointer to characters
        GETC                    ; R0 gets character input
        OUT
        LDR R1, R3, #0          ; R1 gets first character
;
; Test character for end of file
;
TEST    ADD R4, R1, #-10        ; Test for end of line (ASCII xA)
        BRz OUTPUT              ; If done, prepare the output
;
; Test character for match.  If a match, increment count.
;
        NOT R1, R1
        ADD R1, R1, R0          ; If match, R1 = xFFFF
        NOT R1, R1              ; If match, R1 = x0000
        BRnp    GETCHAR         ; If no match, test for capital ones
        ADD R2, R2, #1

;
; Get next character from file.
;
GETCHAR ADD R3, R3, #1          ; Point to next character.
        LDR R1, R3, #0          ; R1 gets next char to test
        BRnzp   TEST
;
; Output the count.
;
OUTPUT  LD  R0, ASCII           ; Load the ASCII template
        ADD R0, R0, R2              ; Convert binary count to ASCII
        OUT                         ; ASCII code in R0 is displayed.
        ADD R5, R2, #0
        BRnp START
        HALT                        ; Halt machine
;
; Storage for pointer and ASCII template
;
ASCII   .FILL   x0030
PTR     .FILL   x4000
        .END
