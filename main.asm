.p816
.i8

.include "define.asm"
.include "macro.asm"
.include "global.asm"
.include "snes.asm"
.include "byte.asm"
.include "dword.asm"
.include "word.asm"
.include "math.asm"
.include "string.asm"
.include "sprite.asm"
.include "font.asm"
.include "data.asm"
.include "collision.asm"
.include "food.asm"
.include "map.asm"
.include "snake.asm"
.include "wario.asm"

.segment "HEADER"
.word $1337
.byte "SNES"
.byte 0, 0, 0, 0, 0, 0, 0
.byte 0
.byte 0
.byte 0
.byte "WARIO'S SNAKE        "
.byte $30
.byte 0
.byte $09
.byte 0
.byte 0
.byte $33
.byte 1
.word $AAAA, $5555


.segment "DATA"
WriteHeader_str: .byte "0000000000000000000000000000000000000000000000000000000000000000", 0
WriteHeader_dword: .dword 0

.segment "CODE"
.proc WriteHeader
    ; Zero the str
    ldx #0
    lda #0
    sta WriteHeader_str, x
    ; Store "Level" in str
    ZP_STORE_PTR1 WriteHeader_str
    jsr StringLevel
    ; Put space character in Global_string
    StringSpace
    ; Concatenate the space
    ZP_STORE_PTR1 WriteHeader_str
    jsr StringConcat
    ; Write the level number + 1
    DWORD_SET WriteHeader_dword, 0, 0, 0, 0
    ldx #0
    lda Global_level
    inc
    sta WriteHeader_dword, x
    lda #0
    pha
    DWORD_STACK_PUSH WriteHeader_dword
    jsr DWordToStr
    ; Concatenate the number in Global_string to str
    ZP_STORE_PTR1 WriteHeader_str
    jsr StringConcat
    ; Write 4 spaces
    StringSpace
    ZP_STORE_PTR1 WriteHeader_str
    jsr StringConcat
    jsr StringConcat
    jsr StringConcat
    jsr StringConcat
    ; Store "Lives" in Global_string then concatenate to str
    ZP_STORE_PTR1 Global_string
    jsr StringLives
    ZP_STORE_PTR1 WriteHeader_str
    jsr StringConcat
    ; Put a space character in Global_string
    StringSpace
    ; And concatenate to str
    ZP_STORE_PTR1 WriteHeader_str
    jsr StringConcat
    ; Store snakeLives in Global_string
    DWORD_SET WriteHeader_dword, 0, 0, 0, 0
    ldx #0
    lda Global_snakeLives
    sta WriteHeader_dword, x
    lda #0
    pha
    DWORD_STACK_PUSH WriteHeader_dword
    jsr DWordToStr
    ; Concatenate the snakeLives to str
    ZP_STORE_PTR1 WriteHeader_str
    jsr StringConcat
    ; Store space character in Global_string
    StringSpace
    ; Concatenate spaces 4 times in to str
    ZP_STORE_PTR1 WriteHeader_str
    jsr StringConcat
    jsr StringConcat
    jsr StringConcat
    jsr StringConcat
    ; Store the points in to Global_string & make sure the value is clamped to 999,999,999
    DWORD_STACK_PUSH Global_points
    DWORD_SET WriteHeader_dword, $3b, $9a, $c9, $ff
    DWORD_STACK_PUSH WriteHeader_dword
    jsr DWordCompare
    pla
    cmp #1
    beq @ClampScore
    bra @Continue
@ClampScore:
    ARRAY_COPY Global_points, WriteHeader_dword, 4
@Continue:
    lda #0
    pha
    DWORD_STACK_PUSH Global_points
    jsr DWordToStr
    ; Concatenate the points
    ZP_STORE_PTR1 WriteHeader_str
    jsr StringConcat
    ; Copy str to Global_string
    ZP_STORE_PTR1 WriteHeader_str
    jsr StringCopyToGlobal
    ; Write out the result
    lda #0
    pha
    lda #0
    pha
    jsr FontWrite
    rts
.endproc

.segment "DATA"
Render_word: .word 0
Render_calc: .word 0
Render_res: .word 0

.segment "CODE"
.proc Render
    wai
    SNESCopyVRAM Global_map, PPUADDR(BG1MAPADDR), $800, #0
    ; Calculate Snake head x/y position
    ldx #0
    lda Global_snakeX, x
    sta Global_snakeHeadX
    lda Global_snakeY, x
    sta Global_snakeHeadY
    WordSetByte Render_word, Global_snakeHeadX
    WORD_SET Render_calc, 0, 8
    WordMultiply Render_word, Render_calc, Render_res
    WordGetByte Render_res, Global_snakeHeadX
    WordSetByte Render_word, Global_snakeHeadY
    WordMultiply Render_word, Render_calc, Render_res
    WordGetByte Render_res, Global_snakeHeadY
    ; Calculate Snake tail x/y position
    ldx Global_snakeLength
    dex
    dex
    lda Global_snakeX, x
    sta Global_snakeTailX
    lda Global_snakeY, x
    sta Global_snakeTailY
    WordSetByte Render_word, Global_snakeTailX
    WORD_SET Render_calc, 0, 8
    WordMultiply Render_word, Render_calc, Render_res
    WordGetByte Render_res, Global_snakeTailX
    WordSetByte Render_word, Global_snakeTailY
    WordMultiply Render_word, Render_calc, Render_res
    WordGetByte Render_res, Global_snakeTailY
    ; Render Wario
    WarioErase
    lda Global_snakeDraw
    cmp #0
    bne @WarioDraw
    jmp @Continue2
@WarioDraw:
    WarioDraw
    SnakeDrawHead
@Continue2:
    wai
    SpriteCopyOAM
    rts
.endproc

.segment "CODE"
.proc PhaseLogo
    ScreenOff
    wai
    SpriteZero
    SpriteCopyOAM
    lda #3
    sta Global_snakeLives
    DWORD_SET Global_points, 0, 0, 0, 0
    stz Global_level
    wai
    SNESCopyVRAM logo_tiles, PPUADDR(CHRADDR), $8000, #2
    SNESCopyVRAM logo_map, PPUADDR(BG1MAPADDR), $800, #4
    SNESCopyCGRAM logo_palette, 0, 32, #4
    ByteInc Global_phase
    ScreenOn
    rts
.endproc

.segment "CODE"
.proc PhaseLogo1
    ; Check start pressed
    CPU_A16_XY16
.a16
.i16
    lda Global_joypad0
    and #JOYSTART
    cmp #0
    bne @StartPressed
    CPU_A8_XY8
.a8
.i8
    bra @Out
@StartPressed:
    CPU_A8_XY8
.a8
.i8
    lda #PHASE_INITGAME
    sta Global_phase
@Out:
    jsr MathRandom
    DWORD_STACK_PULL_DUMMY
    rts
.endproc

.segment "DATA"
PhaseInitGame_rAddr: .word 0

.segment "CODE"
.proc PhaseInitGame
    RETURN_ADDRESS_PULL PhaseInitGame_rAddr
    ScreenOff
    lda Global_level
    cmp #0
    beq @LoadLevel1Helper
    cmp #1
    beq @LoadLevel2Helper
    cmp #2
    beq @LoadLevel3Helper
    cmp #3
    beq @LoadLevel4Helper
    cmp #4
    beq @LoadLevel5Helper
    cmp #5
    beq @LoadLevel6Helper
    cmp #6
    beq @LoadLevel7Helper
    ; Defaults to level 8
    jmp @LoadLevel8

@LoadLevel1Helper:
    jmp @LoadLevel1
@LoadLevel2Helper:
    jmp @LoadLevel2
@LoadLevel3Helper:
    jmp @LoadLevel3
@LoadLevel4Helper:
    jmp @LoadLevel4
@LoadLevel5Helper:
    jmp @LoadLevel5
@LoadLevel6Helper:
    jmp @LoadLevel6
@LoadLevel7Helper:
    jmp @LoadLevel7

@LoadLevel1:
    wai
    SNESCopyVRAM level_tiles, PPUADDR(CHRADDR), 4096, #4
    SNESCopyCGRAM level1_palette, 0, 32, #4
    SNESCopyCGRAM level1_palette, 128, 32, #4
    MapCreate level1_map, 4
    CollisionCreate level1_collision, 4
    jmp @Continue
@LoadLevel2:
    wai
    SNESCopyVRAM level_tiles, PPUADDR(CHRADDR), 4096, #4
    SNESCopyCGRAM level2_palette, 0, 32, #4
    SNESCopyCGRAM level2_palette, 128, 32, #4
    MapCreate level2_map, 4
    CollisionCreate level2_collision, 4
    jmp @Continue
@LoadLevel3:
    wai
    SNESCopyVRAM level_tiles, PPUADDR(CHRADDR), 4096, #4
    SNESCopyCGRAM level3_palette, 0, 32, #4
    SNESCopyCGRAM level3_palette, 128, 32, #4
    MapCreate level3_map, 4
    CollisionCreate level3_collision, 4
    jmp @Continue
@LoadLevel4:
    wai
    SNESCopyVRAM level_tiles, PPUADDR(CHRADDR), 4096, #4
    SNESCopyCGRAM level4_palette, 0, 32, #6
    SNESCopyCGRAM level4_palette, 128, 32, #6
    MapCreate level4_map, 6
    CollisionCreate level4_collision, 6
    jmp @Continue
@LoadLevel5:
    wai
    SNESCopyVRAM level_tiles, PPUADDR(CHRADDR), 4096, #4
    SNESCopyCGRAM level5_palette, 0, 32, #6
    SNESCopyCGRAM level5_palette, 128, 32, #6
    MapCreate level5_map, 6
    CollisionCreate level5_collision, 6
    jmp @Continue
@LoadLevel6:
    wai
    SNESCopyVRAM level_tiles, PPUADDR(CHRADDR), 4096, #4
    SNESCopyCGRAM level6_palette, 0, 32, #6
    SNESCopyCGRAM level6_palette, 128, 32, #6
    MapCreate level6_map, 6
    CollisionCreate level6_collision, 6
    jmp @Continue
@LoadLevel7:
    wai
    SNESCopyVRAM level_tiles, PPUADDR(CHRADDR), 4096, #4
    SNESCopyCGRAM level7_palette, 0, 32, #6
    SNESCopyCGRAM level7_palette, 128, 32, #6
    MapCreate level7_map, 6
    CollisionCreate level7_collision, 6
    jmp @Continue
@LoadLevel8:
    wai
    SNESCopyVRAM level_tiles, PPUADDR(CHRADDR), 4096, #4
    SNESCopyCGRAM level8_palette, 0, 32, #6
    SNESCopyCGRAM level8_palette, 128, 32, #6
    MapCreate level8_map, 6
    CollisionCreate level8_collision, 6
@Continue:
    wai
    jsr WarioLoad
    lda #10
    pha
    jsr SnakeCreate
    lda #DOWN
    sta Global_snakeDirection
    stz Global_levelFoodEaten
    lda #PHASE_MOVE
    sta Global_phase
    jsr FoodPlot
    jsr Render
    jsr WriteHeader
    ScreenOn
    RETURN_ADDRESS_PUSH PhaseInitGame_rAddr
    rts
.endproc

.segment "DATA"
PhaseMove_calc: .dword 0
PhaseMove_mult: .dword 0
PhaseMove_pressed: .byte 0

.segment "CODE"
.proc PhaseMove
    CPU_A16_XY16
.a16
.i16
    ; Check right pressed
    lda Global_joypad0
    and #JOYRIGHT
    cmp #0
    bne @SnakeDirectionRight
    ; Check left pressed
    lda Global_joypad0
    and #JOYLEFT
    cmp #0
    bne @SnakeDirectionLeft
    ; Check up pressed
    lda Global_joypad0
    and #JOYUP
    cmp #0
    bne @SnakeDirectionUp
    ; Check down pressed
    lda Global_joypad0
    and #JOYDOWN
    cmp #0
    bne @SnakeDirectionDown
    CPU_A8_XY8
.a8
.i8
    bra @Continue
@SnakeDirectionRight:
    CPU_A8_XY8
.a8
.i8
    lda Global_snakeDirection
    cmp #LEFT
    beq @Continue
    lda #RIGHT
    sta Global_snakeDirection
    bra @Continue
@SnakeDirectionLeft:
    CPU_A8_XY8
.a8
.i8
    lda Global_snakeDirection
    cmp #RIGHT
    beq @Continue
    lda #LEFT
    sta Global_snakeDirection
    bra @Continue
@SnakeDirectionUp:
    CPU_A8_XY8
.a8
.i8
    lda Global_snakeDirection
    cmp #DOWN
    beq @Continue
    lda #UP
    sta Global_snakeDirection
    bra @Continue
@SnakeDirectionDown:
    CPU_A8_XY8
.a8
.i8
    lda Global_snakeDirection
    cmp #UP
    beq @Continue
    lda #DOWN
    sta Global_snakeDirection
@Continue:
    SnakeErase
    SnakeMove
    SnakeDraw
    ; Check snake's collision with walls
    SnakeCheckCollision
    pla
    cmp #0
    bne @SnakeCollide
    bra @Continue2
@SnakeCollide:
    lda #0
    sta Global_snakeBlinked
    lda #1
    sta Global_snakeDraw
    lda #PHASE_COLLIDE
    sta Global_phase
    jmp @Out
@Continue2:
    ; Check snake's collision with food
    SnakeCheckCollisionFood
    pla
    cmp #0
    bne @SnakeCollideFood
    jmp @Continue3
@SnakeCollideFood:
    jsr FoodPlot
    lda #4
    pha
    jsr SnakeGrow
    DWORD_SET PhaseMove_calc, 0, 0, 0, 0
    ldx #0
    lda Global_snakeLength
    sta PhaseMove_calc, x
    DWORD_SET PhaseMove_mult, 0, 0, 0, 10
    DWORD_STACK_PUSH PhaseMove_calc
    DWORD_STACK_PUSH PhaseMove_mult
    jsr DWordMultiply
    DWORD_STACK_PUSH Global_points
    jsr DWordAdd
    DWORD_STACK_PULL Global_points
    jsr WriteHeader
    lda Global_levelFoodEaten
    inc
    sta Global_levelFoodEaten
@Continue3:
    lda Global_levelFoodEaten
    cmp #LEVEL_FOOD_COUNT
    bcs @NextLevel
    bra @Out
@NextLevel:
    lda #PHASE_NEXTLEVEL
    sta Global_phase
@Out:
    jsr Render
    rts
.endproc

.segment "CODE"
.proc PhaseCollide
    SnakeErase
    lda Global_snakeDraw
    cmp #0
    bne @SnakeDraw
    jmp @Continue
@SnakeDraw:
    SnakeDraw
@Continue:
    lda Global_snakeDraw
    cmp #0
    beq @SnakeDrawON
    bra @SnakeDrawOFF
@SnakeDrawON:
    lda #1
    sta Global_snakeDraw
    bra @Continue2
@SnakeDrawOFF:
    lda #0
    sta Global_snakeDraw
@Continue2:
    lda Global_snakeBlinked
    inc
    sta Global_snakeBlinked
    cmp #BLINK_COUNT
    bcs @ResetLevel
    jmp @Continue3
@ResetLevel:
    SnakeErase
    lda #10
    pha
    jsr SnakeCreate
    stz Global_levelFoodEaten
    lda Global_snakeLives
    dec
    sta Global_snakeLives
    jsr WriteHeader
    lda Global_snakeLives
    cmp #0
    bne @ResetLevel2
    bra @EndGame
@ResetLevel2:
    lda #DOWN
    sta Global_snakeDirection
    lda #PHASE_MOVE
    sta Global_phase
    bra @Continue3
@EndGame:
    lda #PHASE_LOGO
    sta Global_phase
@Continue3:
    jsr Render
    rts
.endproc

.segment "CODE"
.proc PhaseNextLevel
    lda Global_level
    inc
    sta Global_level
    cmp #8
    bcs @ResetFirstLevel
    bra @Continue
@ResetFirstLevel:
    stz Global_level
@Continue:
    lda #PHASE_INITGAME
    sta Global_phase
    rts
.endproc

.segment "DATA"
Main_dword: .dword 0
Main_dword2: .dword 0

.segment "CODE"
.proc Main
    CPU_A8_XY8
.i8
    jsr SNESInit
    jsr StringZero
    jsr FontInit
    ScreenOff
    NMIEnable
    SNESJoypadClear
    SpriteZero
    wai
    SpriteCopyOAM
    ARRAY_ZERO Global_map, 2048
    lda #PHASE_LOGO
    sta Global_phase
    DWORD_SET Main_dword, 0, 0, 0, 0
@Loop:
    SNESJoypadUpdate
    lda Global_phase
    cmp #PHASE_LOGO
    beq @PhaseLogo
    cmp #(PHASE_LOGO + 1)
    beq @PhaseLogo1
    cmp #PHASE_INITGAME
    beq @PhaseInitGame
    cmp #PHASE_MOVE
    beq @PhaseMove
    cmp #PHASE_COLLIDE
    beq @PhaseCollide
    cmp #PHASE_NEXTLEVEL
    beq @PhaseNextLevel
    bra @Continue

@PhaseLogo:
    jsr PhaseLogo
    bra @Continue

@PhaseLogo1:
    jsr PhaseLogo1
    bra @Continue

@PhaseInitGame:
    jsr PhaseInitGame
    bra @Continue

@PhaseMove:
    jsr PhaseMove
    bra @Continue

@PhaseCollide:
    jsr PhaseCollide
    bra @Continue

@PhaseNextLevel:
    jsr PhaseNextLevel

@Continue:
    SNESDelay $4000
    SNESJoypadClear
    jmp @Loop
    rts
.endproc

 .segment "CODE"
 .proc NMI
    rti
.endproc

.segment "CODE"
.proc IRQ
    rti
.endproc

.segment "CODE"
.proc Unused
    rti
.endproc

.segment "VECTOR1"
.word Unused
.word Unused
.word Unused
.word NMI
.word Unused
.word IRQ

.segment "VECTOR2"
.word Unused
.word Unused
.word Unused
.word NMI
.word Main
.word IRQ
