.segment "DATA"
MathRandom_rAddr: .word 0
MathRandom_first: .byte 0
MathRandom_next: .dword 0
MathRandom_seed: .dword 0
MathRandom_res: .dword 0

.segment "CODE"
.proc MathRandom
    RETURN_ADDRESS_PULL MathRandom_rAddr
    lda MathRandom_first
    cmp #0
    bne @Continue
    lda #1
    sta MathRandom_first
    DWORD_SET MathRandom_next, 0, 0, 0, 1
@Continue:
    DWORD_SET MathRandom_seed, $41, $c6, $4e, $6d
    DWORD_STACK_PUSH MathRandom_seed
    DWORD_STACK_PUSH MathRandom_next
    jsr DWordMultiply
    DWORD_SET MathRandom_seed, $0, $0, $30, $39
    DWORD_STACK_PUSH MathRandom_seed
    jsr DWordAdd
    DWORD_STACK_PULL MathRandom_next
    DWORD_SET MathRandom_seed, $0, $1, $0, $0
    DWORD_STACK_PUSH MathRandom_seed
    DWORD_STACK_PUSH MathRandom_next
    jsr DWordDivide
    DWORD_STACK_PULL MathRandom_res
    DWORD_SET MathRandom_seed, $0, $0, $80, $0
    DWORD_STACK_PUSH MathRandom_seed
    DWORD_STACK_PUSH MathRandom_res
    jsr DWordModulus
    DWORD_STACK_PULL MathRandom_res
    ; Zero the upper word
 ;   ldx #3
  ;  lda #0
  ;  sta MathRandom_res, x
  ;  dex
  ;  sta MathRandom_res, x
    DWORD_STACK_PUSH MathRandom_res
    RETURN_ADDRESS_PUSH MathRandom_rAddr
    rts
.endproc


;{
;    next = next * 1103515245ll + 12345ll;
;;    return (unsigned int)(next/65536ll) % 32768ll;
;}
