.segment "CODE"
.proc FontInit
    ; Store the ASCII numbers
    ldx #0
    lda #32 ; Space
    sta Global_fontChars, x
    inx
    lda #48 ; 0
@LoopNumbers:
    sta Global_fontChars, x
    inc
    inx
    cpx #11
    bne @LoopNumbers
    ; Store the ASCII upper case letters
    lda #65 ; A
@LoopLetters:
    sta Global_fontChars, x
    inc
    inx
    cpx #37
    bne @LoopLetters
    ; Store the string terminator
    lda #0
    sta Global_fontChars, x
    ; Initialize numChars
    lda #37
    sta Global_fontNumChars
    ; Initialize startIndex
    lda #63
    sta Global_fontStartIndex
    rts
.endproc

.segment "DATA"
FontWrite_rAddr: .word 0
FontWrite_startSprite: .byte 0
FontWrite_spriteIndex: .byte 255
FontWrite_j: .byte 0
FontWrite_len: .byte 0
FontWrite_x: .byte 0
FontWrite_y: .byte 0
FontWrite_charLeft: .byte 0
FontWrite_charRight: .byte 0
FontWrite_index: .byte 0
FontWrite_tile: .byte 0

.segment "CODE"
.proc FontWrite
    RETURN_ADDRESS_PULL FontWrite_rAddr
    ; Retrieve our parameters from stack
    pla
    sta FontWrite_x
    pla
    sta FontWrite_y
    ; Zero the variables
    lda #64
    sta FontWrite_startSprite
    lda #255
    sta FontWrite_spriteIndex
    stz FontWrite_j
    stz FontWrite_len
    ; Find out the length of Global_string
    ldx #0
@LoopStrLen:
    lda Global_string, x
    inx
    cmp #0
    bne @LoopStrLen
    ; Don't count the terminator character 0
    dex
    ; Store the length of the string
    stx FontWrite_len
    ; If length is zero, exit
    cpx #0
    beq @OutHelper
    bra @Continue

@OutHelper:
    jmp @Out

@Continue:
    ; Cycle the string and print out the sprites
    stz FontWrite_index
@Loop:
    lda #255
    sta FontWrite_spriteIndex
    lda Global_string, x
    ; Line-Feed (\n)
    cmp #10
    beq @IsNewLine
    ; Tab (\t)
    cmp #9
    beq @IsSpace
    ; Space
    cmp #32
    beq @IsSpace

    stz FontWrite_j
@LoopChars:
    ldx FontWrite_j
    cpx Global_fontNumChars
    beq @NextLoop
    ldx FontWrite_index
    lda Global_string, x
    sta FontWrite_charLeft
    ldx FontWrite_j
    lda Global_fontChars, x
    sta FontWrite_charRight
    cmp FontWrite_charLeft
    beq @LeftRightCharEqual
    inx
    stx FontWrite_j
    bra @LoopChars

@LeftRightCharEqual:
    lda FontWrite_j
    sta FontWrite_spriteIndex
    lda FontWrite_startSprite
    inc
    sta FontWrite_startSprite
    bra @NextLoop

@IsNewLine:
    lda FontWrite_y
    clc
    adc #8
    sta FontWrite_y
    bra @NextLoop

@IsSpace:
    lda FontWrite_x
    clc
    adc #8
    sta FontWrite_x

@NextLoop:
    lda FontWrite_spriteIndex
    cmp #255
    bne @SpriteSet
    jmp @Continue2

@SpriteSet:
    lda FontWrite_spriteIndex
    clc
    adc Global_fontStartIndex
    sta FontWrite_tile
    ; Set the new x/y & tile for this sprite
    SpriteSetXYTile FontWrite_startSprite, FontWrite_x, FontWrite_y, FontWrite_tile, #(16 | 32)
    ; Move the x position 8 pixels to the right
    lda FontWrite_x
    clc
    adc #8
    sta FontWrite_x

@Continue2:
    ldx FontWrite_index
    inx
    stx FontWrite_index
    cpx FontWrite_len
    beq @Out
    jmp @Loop
@Out:
    RETURN_ADDRESS_PUSH FontWrite_rAddr
    rts
.endproc
