.segment "DATA"
StringLength_rAddr: .word 0

.segment "CODE"
.proc StringLength
    RETURN_ADDRESS_PULL StringLength_rAddr
    ldy #255
@Loop:
    iny
    cpy #255
    beq @Out
    ; Check for the string terminator character
    lda (ZP_PTR1), y
    cmp #0
    bne @Loop
@Out:
    phy
    RETURN_ADDRESS_PUSH StringLength_rAddr
    rts
.endproc

.proc StringZero
    ldx #0
    lda #0
    sta Global_string, x
    rts
.endproc

.segment "CODE"
.proc StringHello
    ldx #0
    lda #72 ; H
    sta Global_string, x
    inx
    lda #69 ; E
    sta Global_string, x
    inx
    lda #76 ; L
    sta Global_string, x
    inx
    sta Global_string, x
    inx
    lda #79 ; O
    sta Global_string, x
    inx
    lda #0
    sta Global_string, x
    rts
.endproc

.segment "CODE"
.proc String123456
    ldx #0
    lda #49 ; 1
    sta Global_string, x
    inx
    lda #50 ; 2
    sta Global_string, x
    inx
    lda #51 ; 3
    sta Global_string, x
    inx
    lda #52 ; 4
    sta Global_string, x
    inx
    lda #53 ; 5
    sta Global_string, x
    inx
    lda #54 ; 6
    sta Global_string, x
    inx
    lda #0
    sta Global_string, x
    rts
.endproc

.segment "CODE"
.proc StringNULL
    ldx #0
    lda #78 ; N
    sta Global_string, x
    inx
    lda #85 ; U
    sta Global_string, x
    inx
    lda #76 ; L
    sta Global_string, x
    inx
    lda #76 ; L
    sta Global_string, x
    inx
    lda #0
    sta Global_string, x
    rts
.endproc

.segment "CODE"
.proc StringLevel
    ldy #0
    lda #76 ; L
    sta (ZP_PTR1), y
    iny
    lda #69 ; E
    sta (ZP_PTR1), y
    iny
    lda #86 ; V
    sta (ZP_PTR1), y
    iny
    lda #69 ; E
    sta (ZP_PTR1), y
    iny
    lda #76 ; L
    sta (ZP_PTR1), y
    iny
    lda #0
    sta (ZP_PTR1), y
    rts
.endproc

.segment "CODE"
.proc StringLives
    ldy #0
    lda #76 ; L
    sta (ZP_PTR1), y
    iny
    lda #73 ; I
    sta (ZP_PTR1), y
    iny
    lda #86 ; V
    sta (ZP_PTR1), y
    iny
    lda #69 ; E
    sta (ZP_PTR1), y
    iny
    lda #83 ; S
    sta (ZP_PTR1), y
    iny
    lda #0
    sta (ZP_PTR1), y
    rts
.endproc

.macro StringSpace
    ldx #0
    lda #32
    sta Global_string, x
    inx
    lda #0
    sta Global_string, x
.endmacro

.segment "CODE"
.proc StringConcat
    jsr StringLength
    pla
    tay
    ldx #0
@Loop:
    lda Global_string, x
    sta (ZP_PTR1), y
    inx
    iny
    cmp #0
    bne @Loop
    rts
.endproc

.segment "CODE"
.proc StringCopyToGlobal
    ldy #0
@Loop:
    lda (ZP_PTR1), y
    sta Global_string, y
    iny
    cmp #0
    bne @Loop
@Out:
    rts
.endproc
