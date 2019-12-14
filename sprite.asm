.segment "CODE"
.proc SpriteInit
    lda #0
    ldx #0
@LoopRow1:
    sta Global_spritesX, x
    pha
    lda #0
    sta Global_spritesY, x
    pla
    clc
    adc #8
    pha
    txa
    sta Global_spriteTiles, x
    pla
    inx
    cpx #32
    bne @LoopRow1

    lda #0
@LoopRow2:
    sta Global_spritesX, x
    pha
    lda #8
    sta Global_spritesY, x
    pla
    clc
    adc #8
    pha
    txa
    sta Global_spriteTiles, x
    pla
    inx
    cpx #64
    bne @LoopRow2

    lda #0
@LoopRow3:
    sta Global_spritesX, x
    pha
    lda #16
    sta Global_spritesY, x
    pla
    clc
    adc #8
    pha
    txa
    sta Global_spriteTiles, x
    pla
    inx
    cpx #96
    bne @LoopRow3

    lda #0
@LoopRow4:
    sta Global_spritesX, x
    pha
    lda #24
    sta Global_spritesY, x
    pla
    clc
    adc #8
    pha
    txa
    sta Global_spriteTiles, x
    pla
    inx
    cpx #128
    bne @LoopRow4
    rts
.endproc

.macro SpriteZero
.local @Loop
    ldx #0
@Loop:
    lda #0
    sta Global_spritesX, x
    lda #8
    sta Global_spritesY, x
    lda #0
    sta Global_spriteTiles, x
    sta Global_spriteFlags, x
    inx
    cpx #128
    bne @Loop
.endmacro

.macro SpriteSetXYTile index, xp, yp, tile, flags
    ; Store the x & y positions at the index
    ldx index
    lda xp
    sta Global_spritesX, x
    lda yp
    sta Global_spritesY, x
    lda tile
    sta Global_spriteTiles, x
    lda flags
    sta Global_spriteFlags, x
.endmacro

.macro SpriteCopyOAM
.local @Loop
    stz OAMADDL
    stz OAMADDH
    ldx #0
@Loop:
    lda Global_spritesX, x
    sta OAMDATA
    lda Global_spritesY, x
    sta OAMDATA
    lda Global_spriteTiles, x
    sta OAMDATA
    lda Global_spriteFlags, x
    sta OAMDATA
    inx
    cpx #128
    bne @Loop
.endmacro
