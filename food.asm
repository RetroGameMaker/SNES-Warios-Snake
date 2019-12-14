.segment "DATA"
FoodPlot_rAddr: .word 0
FoodPlot_calc: .dword 0
FoodPlot_work: .dword 0
FoodPlot_index: .byte 0
FoodPlot_x: .byte 0
FoodPlot_y: .byte 0

.segment "CODE"
.proc FoodPlot
    RETURN_ADDRESS_PULL FoodPlot_rAddr
@Loop:
    ; Get a random number in the horizontal direction
    jsr MathRandom
    DWORD_STACK_PULL FoodPlot_calc
    DWORD_SET FoodPlot_work, 0, 0, 0, TILES_HORZ
    DWORD_STACK_PUSH FoodPlot_work
    DWORD_STACK_PUSH FoodPlot_calc
    jsr DWordModulus
    ; Pull the result from the stack
    DWORD_STACK_PULL FoodPlot_work
    ; We only need the lowest byte
    ldx #0
    lda FoodPlot_work, x
    sta Global_foodX
    ; Get a random number in the vertical direction
    jsr MathRandom
    DWORD_STACK_PULL FoodPlot_calc
    DWORD_SET FoodPlot_work, 0, 0, 0, TILES_VERT
    DWORD_STACK_PUSH FoodPlot_work
    DWORD_STACK_PUSH FoodPlot_calc
    jsr DWordModulus
    ; Pull the result from the stack
    DWORD_STACK_PULL FoodPlot_work
    ; We only need the lowest byte
    ldx #0
    lda FoodPlot_work, x
    sta Global_foodY
    ; Push food x/y to stack
    lda Global_foodY
    pha
    lda Global_foodX
    pha
    ; Check if the food item collides with any other object
    CollisionGetXY
    pla
    ; Check if it's an empty tile, if not keep looping
    cmp #TILE_EMPTY
    bne @LoopHelper
    bra @Continue

@LoopHelper:
    jmp @Loop

@Continue:
    ; Check food collision with snake
    stz FoodPlot_index
@LoopSnake:
    ldx FoodPlot_index
    lda Global_snakeX, x
    cmp Global_foodX
    beq @XEqual
    bra @LoopSnakeInc

@XEqual:
    lda Global_snakeY, x
    cmp Global_foodY
    beq @LoopHelper
    bra @LoopSnakeInc

@LoopHelper2:
    jmp @Loop

@LoopSnakeInc:
    lda FoodPlot_index
    inc
    sta FoodPlot_index
    ; Loop until we've checked all the snake's positions
    cmp Global_snakeLength
    beq @Continue2
    bra @LoopSnake

@Continue2:
    ; Calculate the x pixel position on the screen
    DWORD_SET FoodPlot_calc, 0, 0, 0, 8
    DWORD_SET FoodPlot_work, 0, 0, 0, 0
    lda Global_foodX
    ldx #0
    sta FoodPlot_work, x
    DWORD_STACK_PUSH FoodPlot_calc
    DWORD_STACK_PUSH FoodPlot_work
    jsr DWordMultiply
    jsr DWordGetByte
    pla
    sta FoodPlot_x
    ; Calculate the y pixel position on the screen
    DWORD_SET FoodPlot_work, 0, 0, 0, 0
    lda Global_foodY
    ldx #0
    sta FoodPlot_work, x
    DWORD_STACK_PUSH FoodPlot_calc
    DWORD_STACK_PUSH FoodPlot_work
    jsr DWordMultiply
    jsr DWordGetByte
    pla
    sta FoodPlot_y
    SpriteSetXYTile #127, FoodPlot_x, FoodPlot_y, #TILE_FOOD, #(16 | 32)
    RETURN_ADDRESS_PUSH FoodPlot_rAddr
    rts
.endproc
