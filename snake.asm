.segment "DATA"
SnakeCreate_rAddr: .word 0
SnakeCreate_i: .byte 0
SnakeCreate_prevX: .byte 0
SnakeCreate_prevY: .byte 0
SnakeCreate_entry: .word 0

.segment "CODE"
.proc SnakeCreate
    RETURN_ADDRESS_PULL SnakeCreate_rAddr
    ; Pull the length argument from stack
    pla
    sta Global_snakeLength
    ; Store the x/y and tile below values for the head of the snake
    ldx #0
    lda #(TILES_HORZ / 2)
    sta Global_snakeX, x
    lda #(TILES_VERT / 2)
    sta Global_snakeY, x
    ; Call MapGetXY to find out the tile below the position
    lda Global_snakeY, x
    pha
    lda Global_snakeX, x
    pha
    jsr MapGetXY
    WORD_STACK_PULL SnakeCreate_entry
    ldx #0
    ldy #0
    lda SnakeCreate_entry, y
    sta Global_snakeTileBelow, x
    ; Cycle through the length value and create the snake
    lda #1
    sta SnakeCreate_i
    ldx #0
    lda Global_snakeX, x
    sta SnakeCreate_prevX
    lda Global_snakeY, x
    sta SnakeCreate_prevY
@Loop:
    ldx SnakeCreate_i
    lda SnakeCreate_prevX
    sta Global_snakeX, x
    lda SnakeCreate_prevY
    dec
    sta Global_snakeY, x
    sta SnakeCreate_prevY
    pha
    lda Global_snakeX, x
    pha
    jsr MapGetXY
    WORD_STACK_PULL SnakeCreate_entry
    ldx SnakeCreate_i
    ldy #0
    lda SnakeCreate_entry, y
    sta Global_snakeTileBelow, x
    lda SnakeCreate_i
    inc
    sta SnakeCreate_i
    cmp Global_snakeLength
    bne @LoopHelper
    bra @Out
@LoopHelper:
    jmp @Loop
@Out:
    RETURN_ADDRESS_PUSH SnakeCreate_rAddr
    rts
.endproc

.segment "DATA"
SnakeCheckCollision_i: .byte 0
SnakeCheckCollision_headX: .byte 0
SnakeCheckCollision_headY: .byte 0

.macro SnakeCheckCollision
.local @OutHelper
.local @Continue
.local @Loop
.local @LoopNext
.local @Out
    ; Check snake hit scenery
    ldx #0
    lda Global_snakeY, x
    pha
    lda Global_snakeX, x
    pha
    CollisionGetXY
    pla
    cmp #TILE_EMPTY
    bne @OutHelper
    bra @Continue

@OutHelper:
    lda #1
    jmp @Out

@Continue:
    ldx #0
    lda Global_snakeX, x
    sta SnakeCheckCollision_headX
    lda Global_snakeY, x
    sta SnakeCheckCollision_headY
    lda #1
    sta SnakeCheckCollision_i
@Loop:
    ldx SnakeCheckCollision_i
    lda Global_snakeX, x
    cmp SnakeCheckCollision_headX
    bne @LoopNext
    lda Global_snakeY, x
    cmp SnakeCheckCollision_headY
    bne @LoopNext
    ; Snake hit it's body
    lda #1
    bra @Out
@LoopNext:
    ldx SnakeCheckCollision_i
    inx
    stx SnakeCheckCollision_i
    cpx Global_snakeLength
    bne @Loop
    ; Snake didn't hit anything
    lda #0
@Out:
    pha
.endmacro

.segment "DATA"
SnakeCheckCollisionFood_headX: .byte 0
SnakeCheckCollisionFood_headY: .byte 0

.macro SnakeCheckCollisionFood
.local @NoCollision
.local @Out
    ldx #0
    lda Global_snakeX, x
    sta SnakeCheckCollisionFood_headX
    lda Global_snakeY, x
    sta SnakeCheckCollisionFood_headY
    lda SnakeCheckCollisionFood_headX
    cmp Global_foodX
    bne @NoCollision
    lda SnakeCheckCollisionFood_headY
    cmp Global_foodY
    bne @NoCollision
    lda #1
    bra @Out
@NoCollision:
    lda #0
@Out:
    pha
.endmacro

.segment "DATA"
SnakeMove_rAddr: .word 0
SnakeMove_oldX: .byte 0
SnakeMove_oldY: .byte 0
SnakeMove_oldTile: .byte 0
SnakeMove_oldXTemp: .byte 0
SnakeMove_oldYTemp: .byte 0
SnakeMove_oldTileTemp: .byte 0
SnakeMove_tile: .word 0
SnakeMove_i: .byte 0

.macro SnakeMove
.local @Loop
.local @MoveHead
.local @MoveBody
.local @MoveHeadLeft
.local @MoveHeadRight
.local @MoveHeadUp
.local @MoveHeadDown
.local @StoreTileBelow
.local @Continue
.local @OutHelper
.local @Out
    stz SnakeMove_i
@Loop:
    ldx SnakeMove_i
    cpx #0
    beq @MoveHead
    jmp @MoveBody

@MoveHead:
    lda Global_snakeX, x
    sta SnakeMove_oldX
    lda Global_snakeY, x
    sta SnakeMove_oldY
    lda Global_snakeTileBelow, x
    sta SnakeMove_oldTile
    lda Global_snakeDirection
    cmp #LEFT
    beq @MoveHeadLeft
    cmp #RIGHT
    beq @MoveHeadRight
    cmp #UP
    beq @MoveHeadUp
    ; Defaults to down
    bra @MoveHeadDown

@MoveHeadLeft:
    lda Global_snakeX, x
    dec
    sta Global_snakeX, x
    bra @StoreTileBelow

@MoveHeadRight:
    lda Global_snakeX, x
    inc
    sta Global_snakeX, x
    bra @StoreTileBelow

@MoveHeadUp:
    lda Global_snakeY, x
    dec
    sta Global_snakeY, x
    bra @StoreTileBelow

@MoveHeadDown:
    lda Global_snakeY, x
    inc
    sta Global_snakeY, x

@StoreTileBelow:
    lda Global_snakeY, x
    pha
    lda Global_snakeX, x
    pha
    jsr MapGetXY
    ; We need only the low byte (high byte ignored)
    WORD_STACK_PULL SnakeMove_tile
    ldx #0
    ldy #0
    lda SnakeMove_tile, y
    sta Global_snakeTileBelow, x
    bra @Continue

@MoveBody:
    lda Global_snakeX, x
    sta SnakeMove_oldXTemp
    lda Global_snakeY, x
    sta SnakeMove_oldYTemp
    lda Global_snakeTileBelow, x
    sta SnakeMove_oldTileTemp
    lda SnakeMove_oldX
    sta Global_snakeX, x
    lda SnakeMove_oldY
    sta Global_snakeY, x
    lda SnakeMove_oldTile
    sta Global_snakeTileBelow, x
    lda SnakeMove_oldXTemp
    sta SnakeMove_oldX
    lda SnakeMove_oldYTemp
    sta SnakeMove_oldY
    lda SnakeMove_oldTileTemp
    sta SnakeMove_oldTile

@Continue:
    ldx SnakeMove_i
    inx
    stx SnakeMove_i
    cpx Global_snakeLength
    bne @LoopHelper
    bra @Out
@LoopHelper:
    jmp @Loop
@Out:
.endmacro

.segment "DATA"
SnakeErase_count: .byte 0

.macro SnakeErase
.local @Loop
.local @LoopHelper
.local @Out
    stz SnakeErase_count
@Loop:
    ldx SnakeErase_count
    lda Global_snakeTileBelow, x
    pha
    lda Global_snakeY, x
    pha
    lda Global_snakeX, x
    pha
    jsr MapSetXY
    ldx SnakeErase_count
    inx
    stx SnakeErase_count
    cpx Global_snakeLength
    bne @LoopHelper
    bra @Out
@LoopHelper:
    jmp @Loop
@Out:
.endmacro

.segment "DATA"
SnakeDraw_count: .byte 0

.macro SnakeDraw
.local @Loop
.local @LoopHelper
.local @Out
    stz SnakeDraw_count
@Loop:
    ldx SnakeDraw_count
    lda #TILE_SNAKE
    pha
    lda Global_snakeY, x
    pha
    lda Global_snakeX, x
    pha
    jsr MapSetXY
    ldx SnakeDraw_count
    inx
    stx SnakeDraw_count
    cpx Global_snakeLength
    bne @LoopHelper
    bra @Out
@LoopHelper:
    jmp @Loop
@Out:
.endmacro

.define SNAKEHEAD_START_SPRITE 20
.define SNAKEHEAD_START_TILE 11

.segment "DATA"
SnakeDrawHead_frame: .byte 0
SnakeDrawHead_x: .byte 0
SnakeDrawHead_y: .byte 0
SnakeDrawHead_tile: .byte 0
SnakeDrawHead_index: .byte 0

.macro SnakeDrawHead
.local @DrawFrame0
.local @DrawFrame1
.local @Continue
.local @DrawFrameLeft
.local @DrawFrameRight
.local @DrawFrameUp
.local @DrawFrameDown
.local @DrawFrameRightHelper
.local @DrawFrameUpHelper
.local @Out
    lda Global_snakeHeadX
    sta SnakeDrawHead_x
    lda Global_snakeHeadY
    sta SnakeDrawHead_y
    lda #SNAKEHEAD_START_SPRITE
    sta SnakeDrawHead_index
    lda SnakeDrawHead_frame
    cmp #0
    beq @DrawFrame0
    jmp @DrawFrame1
@DrawFrame0:
    lda #SNAKEHEAD_START_TILE
    sta SnakeDrawHead_tile
    lda #1
    sta SnakeDrawHead_frame
    bra @Continue
@DrawFrame1:
    lda #(SNAKEHEAD_START_TILE + 2)
    sta SnakeDrawHead_tile
    lda #0
    sta SnakeDrawHead_frame
@Continue:
    lda Global_snakeDirection
    cmp #LEFT
    beq @DrawFrameLeft
    cmp #RIGHT
    beq @DrawFrameRightHelper
    cmp #UP
    beq @DrawFrameUpHelper
    jmp @DrawFrameDown
@DrawFrameRightHelper:
    jmp @DrawFrameRight
@DrawFrameUpHelper:
    jmp @DrawFrameUp
@DrawFrameLeft:
    ByteAdd SnakeDrawHead_tile, #5
    ByteSubtract SnakeDrawHead_y, #5
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32 | 64)
    ByteInc SnakeDrawHead_index
    ByteAdd SnakeDrawHead_x, #8
    ByteDec SnakeDrawHead_tile
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32 | 64)
    ByteInc SnakeDrawHead_index
    ByteAdd SnakeDrawHead_y, #8
    ByteAdd SnakeDrawHead_tile, #32
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32 | 64)
    ByteInc SnakeDrawHead_index
    ByteSubtract SnakeDrawHead_x, #8
    ByteInc SnakeDrawHead_tile
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32 | 64)
    jmp @Out
@DrawFrameRight:
    ByteAdd SnakeDrawHead_tile, #4
    ByteSubtract SnakeDrawHead_y, #5
    ByteSubtract SnakeDrawHead_x, #8
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32)
    ByteInc SnakeDrawHead_index
    ByteAdd SnakeDrawHead_x, #8
    ByteInc SnakeDrawHead_tile
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32)
    ByteInc SnakeDrawHead_index
    ByteSubtract SnakeDrawHead_x, #8
    ByteAdd SnakeDrawHead_y, #8
    ByteAdd SnakeDrawHead_tile, #31
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32)
    ByteInc SnakeDrawHead_index
    ByteAdd SnakeDrawHead_x, #8
    ByteInc SnakeDrawHead_tile
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32)
    jmp @Out
@DrawFrameUp:
    ByteSubtract SnakeDrawHead_y, #1
    ByteAdd SnakeDrawHead_tile, #32
    ByteSubtract SnakeDrawHead_x, #4
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32 | 128)
    ByteInc SnakeDrawHead_index
    ByteAdd SnakeDrawHead_x, #8
    ByteInc SnakeDrawHead_tile
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32 | 128)
    ByteInc SnakeDrawHead_index
    ByteSubtract SnakeDrawHead_x, #8
    ByteAdd SnakeDrawHead_y, #8
    ByteSubtract SnakeDrawHead_tile, #33
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32 | 128)
    ByteInc SnakeDrawHead_index
    ByteAdd SnakeDrawHead_x, #8
    ByteInc SnakeDrawHead_tile
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32 | 128)
    jmp @Out
@DrawFrameDown:
    ByteSubtract SnakeDrawHead_y, #9
    ByteSubtract SnakeDrawHead_x, #4
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32)
    ByteInc SnakeDrawHead_index
    ByteAdd SnakeDrawHead_x, #8
    ByteInc SnakeDrawHead_tile
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32)
    ByteInc SnakeDrawHead_index
    ByteSubtract SnakeDrawHead_x, #8
    ByteAdd SnakeDrawHead_y, #8
    ByteAdd SnakeDrawHead_tile, #31
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32)
    ByteInc SnakeDrawHead_index
    ByteAdd SnakeDrawHead_x, #8
    ByteInc SnakeDrawHead_tile
    SpriteSetXYTile SnakeDrawHead_index, SnakeDrawHead_x, SnakeDrawHead_y, SnakeDrawHead_tile, #(16 | 32)
@Out:
.endmacro

.segment "DATA"
SnakeGrow_rAddr: .word 0
SnakeGrow_amount: .byte 0
SnakeGrow_count: .byte 0
SnakeGrow_from: .byte 0
SnakeGrow_footX: .byte 0
SnakeGrow_footY: .byte 0
SnakeGrow_footTileBelow: .byte 0

.segment "CODE"
.proc SnakeGrow
    RETURN_ADDRESS_PULL SnakeGrow_rAddr
    BYTE_STACK_PULL SnakeGrow_amount
    stz SnakeGrow_count
    ldx Global_snakeLength
    dex
    lda Global_snakeX, x
    sta SnakeGrow_footX
    lda Global_snakeY, x
    sta SnakeGrow_footY
    lda Global_snakeTileBelow, x
    sta SnakeGrow_footTileBelow
    inx
    stx SnakeGrow_from
@Loop:
    ldx SnakeGrow_from
    lda SnakeGrow_footX
    sta Global_snakeX, x
    lda SnakeGrow_footY
    sta Global_snakeY, x
    lda SnakeGrow_footTileBelow
    sta Global_snakeTileBelow, x
    inx
    stx SnakeGrow_from
    ldx SnakeGrow_count
    inx
    stx SnakeGrow_count
    cpx SnakeGrow_amount
    bne @Loop
    lda Global_snakeLength
    clc
    adc SnakeGrow_amount
    sta Global_snakeLength
    RETURN_ADDRESS_PUSH SnakeGrow_rAddr
    rts
.endproc
