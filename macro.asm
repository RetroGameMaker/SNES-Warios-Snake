.macro CPU_A8_XY8
    sep #$10
    sep #$20
.endmacro

.macro CPU_A8_XY16
    rep #$10
    sep #$20
.endmacro

.macro CPU_A16_XY16
    rep #$30
.endmacro

.macro RETURN_ADDRESS_PULL variable
    ldx #0
    pla
    sta variable, x
    inx
    pla
    sta variable, x
.endmacro

.macro RETURN_ADDRESS_PUSH variable
    ldx #1
    lda variable, x
    pha
    dex
    lda variable, x
    pha
.endmacro

.macro DWORD_SET variable, pa, pb, pc, pd
    ldx #3
    lda #pa
    sta variable, x
    dex
    lda #pb
    sta variable, x
    dex
    lda #pc
    sta variable, x
    dex
    lda #pd
    sta variable, x
.endmacro

.macro DWORD_STACK_PULL variable
    ldx #3
    pla
    sta variable, x
    dex
    pla
    sta variable, x
    dex
    pla
    sta variable, x
    dex
    pla
    sta variable, x
.endmacro

.macro DWORD_STACK_PULL_DUMMY
    ldx #3
    pla
    dex
    pla
    dex
    pla
    dex
    pla
.endmacro

.macro DWORD_STACK_PUSH variable
    ldx #0
    lda variable, x
    pha
    inx
    lda variable, x
    pha
    inx
    lda variable, x
    pha
    inx
    lda variable, x
    pha
.endmacro

.macro DWORD_STACK_ZERO
    lda #0
    pha
    pha
    pha
    pha
.endmacro

.macro DWORD_STACK_ONE
    lda #1
    pha
    lda #0
    pha
    pha
    pha
.endmacro

.macro DWORD_STACK_TEN
    lda #10
    pha
    lda #0
    pha
    pha
    pha
.endmacro

.macro DWORD_FROM_BYTE dwVar, byteVar
    DWORD_SET dwVar, 0, 0, 0, 0
    ldx #0
    lda byteVar
    sta dwVar, x
.endmacro

.macro DWORD_FROM_WORD dwVar, wordVar
    DWORD_SET dwVar, 0, 0, 0, 0
    ldx #0
    lda byteVar, x
    sta dwVar, x
    inx
    lda byteVar, x
    sta dwVar, x
.endmacro

.macro WORD_SET variable, pa, pb
    ldx #1
    lda #pa
    sta variable, x
    dex
    lda #pb
    sta variable, x
.endmacro

.macro WORD_STACK_PULL variable
    ldx #1
    pla
    sta variable, x
    dex
    pla
    sta variable, x
.endmacro

.macro WORD_STACK_PUSH variable
    ldx #0
    lda variable, x
    pha
    inx
    lda variable, x
    pha
.endmacro

.macro WORD_STACK_ZERO
    lda #0
    pha
    pha
.endmacro

.macro WORD_STACK_ONE
    lda #1
    pha
    lda #0
    pha
.endmacro

.macro WORD_STACK_TEN
    lda #10
    pha
    lda #0
    pha
.endmacro

.macro WORD_REVERSE variable
    ldx #0
    lda variable, x
    sta Global_temp
    ldx #1
    lda variable, x
    ldx #0
    sta variable, x
    lda Global_temp
    ldx #1
    sta variable, x
.endmacro

.macro BYTE_STACK_PULL variable
    pla
    sta variable
.endmacro

.macro BYTE_STACK_PUSH variable
    lda variable
    pha
.endmacro

.macro ZP_STORE_PTR1 ptr1
    lda #<ptr1
    sta ZP_PTR1
    lda #>ptr1
    sta ZP_PTR1+1
.endmacro

.macro ZP_STORE_PTR2 ptr1, ptr2
    lda #<ptr1
    sta ZP_PTR1
    lda #>ptr1
    sta ZP_PTR1+1
    lda #<ptr2
    sta ZP_PTR2
    lda #>ptr2
    sta ZP_PTR2+1
.endmacro

.macro ZP_STORE_PTR3 ptr1, ptr2, ptr3
    lda #<ptr1
    sta ZP_PTR1
    lda #>ptr1
    sta ZP_PTR1+1
    lda #<ptr2
    sta ZP_PTR2
    lda #>ptr2
    sta ZP_PTR2+1
    lda #<ptr3
    sta ZP_PTR3
    lda #>ptr3
    sta ZP_PTR3+1
.endmacro

.macro ARRAY_ZERO array, count
.local @AZLoop
.local @AZOut
    CPU_A8_XY16
.i16
    ldx #count
    cpx #0
    beq @AZOut
    lda #0
@AZLoop:
    dex
    sta array, x
    cpx #0
    bne @AZLoop
@AZOut:
    CPU_A8_XY8
.i8
.endmacro

.macro ARRAY_COPY dst, src, count
.local @ACLoop
.local @ACOut
    CPU_A8_XY16
.i16
    ldx #count
    cpx #0
    beq @ACOut
@ACLoop:
    dex
    lda src, x
    sta dst, x
    cpx #0
    bne @ACLoop
@ACOut:
    CPU_A8_XY8
.i8
.endmacro

.macro NMIEnable
    lda #$81
    sta NMITIMEN
.endmacro

.macro NMIDisable
    stz NMITIMEN
.endmacro

.macro ScreenOn
    lda #$f
    sta INIDISP
.endmacro

.macro ScreenOff
    lda #$80
    sta INIDISP
.endmacro
