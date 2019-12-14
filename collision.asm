.segment "DATA"
CollisionCreate_bankOld: .byte 0

.macro CollisionCreate collisionMap, bank
.local @Loop
    ; Store old bank
    phb
    pla
    sta CollisionCreate_bankOld
    ; Switch to new bank
    lda #bank
    pha
    plb
    CPU_A8_XY16
.i16
    ldx #1024
@Loop:
    dex
    lda collisionMap, x
    sta Global_collision, x
    cpx #0
    bne @Loop
    CPU_A8_XY8
.i8
    ; Switch back to old bank
    lda CollisionCreate_bankOld
    pha
    plb
.endmacro

.segment "DATA"
CollisionGetXY_xp: .byte 0
CollisionGetXY_yp: .byte 0
CollisionGetXY_calc: .word 0
CollisionGetXY_mult: .word 0
CollisionGetXY_work: .word 0
CollisionGetXY_res: .word 0
CollisionGetXY_tile: .byte 0

.macro CollisionGetXY
    pla
    sta CollisionGetXY_xp
    pla
    sta CollisionGetXY_yp
    WordSetByte CollisionGetXY_calc, CollisionGetXY_yp
    WORD_SET CollisionGetXY_mult, 0, 32
    WordMultiply CollisionGetXY_calc, CollisionGetXY_mult, CollisionGetXY_work
    WordSetByte CollisionGetXY_calc, CollisionGetXY_xp
    WordAdd CollisionGetXY_calc, CollisionGetXY_work, CollisionGetXY_res
    ; Switch CPU to 16bit index registers
    CPU_A8_XY16
.i16
    ldx CollisionGetXY_res
    lda Global_collision, x
    sta CollisionGetXY_tile
    ; Switch CPU back to 8bit index registers
    CPU_A8_XY8
.i8
    ; Return the tile we found at x/y
    lda CollisionGetXY_tile
    pha
.endmacro
