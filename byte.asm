.segment "DATA"
ByteNegate_rAddr: .word 0
ByteNegate_val: .byte 0
ByteNegate_ret: .byte 0

.segment "CODE"
.proc ByteNegate
    RETURN_ADDRESS_PULL ByteNegate_rAddr
    ; Read the value parameter from stack
    pla
    sta ByteNegate_val
    ; Zero the return value
    stz ByteNegate_ret
    ; Negate the value one bit at a time
    lda #$80
    and ByteNegate_val
    cmp #0
    bne @BitIsOne7th
    lda #$80
    ora ByteNegate_ret
    sta ByteNegate_ret

@BitIsOne7th:
    lda #$40
    and ByteNegate_val
    cmp #0
    bne @BitIsOne6th
    lda #$40
    ora ByteNegate_ret
    sta ByteNegate_ret

@BitIsOne6th:
    lda #$20
    and ByteNegate_val
    cmp #0
    bne @BitIsOne5th
    lda #$20
    ora ByteNegate_ret
    sta ByteNegate_ret

@BitIsOne5th:
    lda #$10
    and ByteNegate_val
    cmp #0
    bne @BitIsOne4th
    lda #$10
    ora ByteNegate_ret
    sta ByteNegate_ret

@BitIsOne4th:
    lda #$8
    and ByteNegate_val
    cmp #0
    bne @BitIsOne3rd
    lda #$8
    ora ByteNegate_ret
    sta ByteNegate_ret

@BitIsOne3rd:
    lda #$4
    and ByteNegate_val
    cmp #0
    bne @BitIsOne2nd
    lda #$4
    ora ByteNegate_ret
    sta ByteNegate_ret

@BitIsOne2nd:
    lda #$2
    and ByteNegate_val
    cmp #0
    bne @BitIsOne1st
    lda #$2
    ora ByteNegate_ret
    sta ByteNegate_ret

@BitIsOne1st:
    lda #$1
    and ByteNegate_val
    cmp #0
    bne @BitIsOneEnd
    lda #$1
    ora ByteNegate_ret
    sta ByteNegate_ret

@BitIsOneEnd:
    ;Save return value on stack
    lda ByteNegate_ret
    pha
    RETURN_ADDRESS_PUSH ByteNegate_rAddr
    rts
.endproc

.macro ByteInc byte
    lda byte
    inc
    sta byte
.endmacro

.macro ByteDec byte
    lda byte
    dec
    sta byte
.endmacro

.macro ByteAdd byte, value
    lda byte
    clc
    adc value
    sta byte
.endmacro

.macro ByteSubtract byte, value
    lda byte
    sec
    sbc value
    sta byte
.endmacro
