.define WARIO_SPRITE_START 0
.define WARIO_TILE_START 128

.segment "CODE"
.proc WarioLoad
    SNESCopyVRAM wario_tiles, PPUADDR(CHRADDR + 4096), 1920, #4
    SNESCopyCGRAM wario_palette, (128 + 16), 32, #4
    rts
.endproc

.segment "DATA"
WarioDraw_x: .byte 0
WarioDraw_y: .byte 0
WarioDraw_tile: .byte 0
WarioDraw_index: .byte 0
WarioDraw_offset: .byte 0

.macro WarioDraw
.local @WarioOffsetOFF
.local @Continue
.local @FrameLeft
.local @FrameRight
.local @FrameUp
.local @FrameDown
.local @FrameRightHelper
.local @FrameUpHelper
.local @Out
    lda Global_snakeHeadX
    sta WarioDraw_x
    lda Global_snakeHeadY
    sta WarioDraw_y
    lda #WARIO_SPRITE_START
    sta WarioDraw_index
    lda WarioDraw_offset
    cmp #0
    beq @WarioOffsetOFF
    ByteSubtract WarioDraw_y, #4
    lda #0
    sta WarioDraw_offset
    bra @Continue
@WarioOffsetOFF:
    lda #1
    sta WarioDraw_offset
@Continue:
    lda Global_snakeDirection
    cmp #LEFT
    beq @FrameLeft
    cmp #RIGHT
    beq @FrameRightHelper
    cmp #UP
    beq @FrameUpHelper
    ; Defaults to down
    jmp @FrameDown

@FrameRightHelper:
    jmp @FrameRight
@FrameUpHelper:
    jmp @FrameUp

@FrameLeft:
    ByteSubtract WarioDraw_y, #32
    lda #WARIO_TILE_START
    sta WarioDraw_tile
    ByteAdd WarioDraw_x, #24
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteSubtract WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteSubtract WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    lda #WARIO_TILE_START
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #12
    ByteAdd WarioDraw_x, #24
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteSubtract WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteSubtract WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    lda #WARIO_TILE_START
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #24
    ByteAdd WarioDraw_x, #24
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteSubtract WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteSubtract WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    lda #WARIO_TILE_START
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #36
    ByteAdd WarioDraw_x, #24
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteSubtract WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteSubtract WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    lda #WARIO_TILE_START
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #48
    ByteAdd WarioDraw_x, #24
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteSubtract WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteSubtract WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(64 | 16 | 32 | 2)
    ; Empty sprites
    ByteInc WarioDraw_index
    SpriteSetXYTile WarioDraw_index, #0, #0, #0, #0
    ByteInc WarioDraw_index
    SpriteSetXYTile WarioDraw_index, #0, #0, #0, #0
    ByteInc WarioDraw_index
    SpriteSetXYTile WarioDraw_index, #0, #0, #0, #0
    ByteInc WarioDraw_index
    SpriteSetXYTile WarioDraw_index, #0, #0, #0, #0
    ByteInc WarioDraw_index
    SpriteSetXYTile WarioDraw_index, #0, #0, #0, #0
    jmp @Out
@FrameRight:
    ByteSubtract WarioDraw_x, #24
    ByteSubtract WarioDraw_y, #32
    lda #WARIO_TILE_START
    sta WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #24
    lda #WARIO_TILE_START
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #12
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #24
    lda #WARIO_TILE_START
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #24
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #24
    lda #WARIO_TILE_START
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #36
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #24
    lda #WARIO_TILE_START
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #48
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ; Empty sprites
    ByteInc WarioDraw_index
    SpriteSetXYTile WarioDraw_index, #0, #0, #0, #0
    ByteInc WarioDraw_index
    SpriteSetXYTile WarioDraw_index, #0, #0, #0, #0
    ByteInc WarioDraw_index
    SpriteSetXYTile WarioDraw_index, #0, #0, #0, #0
    ByteInc WarioDraw_index
    SpriteSetXYTile WarioDraw_index, #0, #0, #0, #0
    ByteInc WarioDraw_index
    SpriteSetXYTile WarioDraw_index, #0, #0, #0, #0
    jmp @Out
@FrameUp:
    ByteSubtract WarioDraw_x, #12
    ByteSubtract WarioDraw_y, #16
    lda #(WARIO_TILE_START + 3)
    sta WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #12
    lda #(WARIO_TILE_START + 3)
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #12
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #12
    lda #(WARIO_TILE_START + 3)
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #24
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #12
    lda #(WARIO_TILE_START + 3)
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #36
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #12
    lda #(WARIO_TILE_START + 3)
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #48
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    jmp @Out
@FrameDown:
    ByteSubtract WarioDraw_x, #12
    ByteSubtract WarioDraw_y, #40
    lda #(WARIO_TILE_START + 7)
    sta WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #12
    lda #(WARIO_TILE_START + 7)
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #12
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #12
    lda #(WARIO_TILE_START + 7)
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #24
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #12
    lda #(WARIO_TILE_START + 7)
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #36
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    lda Global_snakeHeadX
    sta WarioDraw_x
    ByteSubtract WarioDraw_x, #12
    lda #(WARIO_TILE_START + 7)
    sta WarioDraw_tile
    ByteAdd WarioDraw_tile, #48
    ByteAdd WarioDraw_y, #8
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
    ByteInc WarioDraw_index
    ByteAdd WarioDraw_x, #8
    ByteInc WarioDraw_tile
    SpriteSetXYTile WarioDraw_index, WarioDraw_x, WarioDraw_y, WarioDraw_tile, #(16 | 32 | 2)
@Out:
.endmacro

.segment "DATA"
WarioErase_count: .byte 0
WarioErase_index: .byte 0

.macro WarioErase
.local @Loop
    lda #WARIO_SPRITE_START
    sta WarioErase_index
    stz WarioErase_count
@Loop:
    ; 20 Empty sprites
    SpriteSetXYTile WarioErase_index, #0, #0, #0, #0
    ByteInc WarioErase_index
    ByteInc WarioErase_count
    cmp #20
    bne @Loop
.endmacro
