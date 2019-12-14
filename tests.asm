.p816
.a8
.i8

.include "data.asm"
.include "define.asm"
.include "macro.asm"
.include "snes.asm"
.include "global.asm"
.include "byte.asm"
.include "dword.asm"
.include "word.asm"
.include "string.asm"
.include "sprite.asm"
.include "font.asm"
.include "map.asm"

.segment "HEADER"
.byte "SNES TESTS  "

.segment "ROMINFO"
.byte $30            ; LoROM, fast-capable
.byte 0              ; no battery RAM
.byte $07            ; 128K ROM
.byte 0,0,$33,0
.word $AAAA,$5555    ; dummy checksum and complement

.segment "DATA"
SNESCopyPixels_rAddr: .word 0
SNESCopyPixels_bank: .byte 0
SNESCopyPixels_bankOld: .byte 0
SNESCopyPixels_size: .word 0

.segment "CODE"
.proc SNESCopyPixels
    RETURN_ADDRESS_PULL SNESCopyPixels_rAddr
    BYTE_STACK_PULL SNESCopyPixels_bank
    WORD_STACK_PULL SNESCopyPixels_size

    phb
    pla
    sta SNESCopyPixels_bankOld
    lda SNESCopyPixels_bank
    pha
    plb

    lda #$10
    sta VMADDH
    stz VMADDL
    lda #$80
    sta VMAINC
    ; Switch the index registers to 16-bit mode
    CPU_A8_XY16
.i16
    ldy #0
@Loop:
    lda logo_tiles, y
    sta VMDATAL
    iny
    lda logo_tiles, y
    sta VMDATAH
    iny
    cpy SNESCopyPixels_size
    bne @Loop
    ; Switch the index registers back to 8-bit mode
    CPU_A8_XY8
.i8
    lda SNESCopyPixels_bankOld
    pha
    plb
    RETURN_ADDRESS_PUSH SNESCopyPixels_rAddr
    rts
.endproc

.segment "CODE"
.proc SNESCopyPalette
    lda #128
    sta CGADD
    ldy #0
@Loop:
    lda (ZP_PTR1), y
    sta CGDATA
    inx
    lda (ZP_PTR1), y
    sta CGDATA
    iny
    cpy #32
    bne @Loop
    rts
.endproc

.segment "CODE"
.proc SNESCopyMap
    stz VMADDH
    lda #0
	sta VMADDL
    lda #$80
    sta VMAINC
    ; Switch the index registers to 16-bit mode
    CPU_A8_XY16
.i16
    ldx #0
@Loop:
    lda Global_map, x
    sta VMDATAL
    inx
    lda Global_map, x
    sta VMDATAH
    inx
    cpx #2048
    bne @Loop
    ; Switch the index registers back to 8-bit mode
    CPU_A8_XY8
.i8
    rts
.endproc

.segment "CODE"
.proc SNESCopyMap2
    lda #$8
    sta VMADDH
	stz VMADDL
    lda #$80
    sta VMAINC
    ; Switch the index registers to 16-bit mode
    CPU_A8_XY16
.i16
    ldx #0
@Loop:
    lda Global_map, x
    sta VMDATAL
    inx
    lda Global_map, x
    sta VMDATAH
    inx
    cpx #2048
    bne @Loop
    ; Switch the index registers back to 8-bit mode
    CPU_A8_XY8
.i8
    rts
.endproc

.segment "DATA"
CollisionCreate_rAddr: .word 0
CollisionCreate_xp: .byte 0
CollisionCreate_yp: .byte 0
CollisionCreate_i: .byte 0
CollisionCreate_index: .word 0
CollisionCreate_char: .byte 0
CollisionCreate_calc: .dword 0
CollisionCreate_mult: .dword 0
CollisionCreate_res: .word 0
CollisionCreate_bankOld: .byte 0

.segment "CODE"
.proc CollisionCreateOld
    RETURN_ADDRESS_PULL CollisionCreate_rAddr
    WORD_SET CollisionCreate_index, 0, 0
    stz CollisionCreate_yp
@LoopY:
    stz CollisionCreate_xp
@LoopX:
    stz CollisionCreate_i
    ; Zero the global string
    jsr StringZero
@ReadNum:
    ; Switch CPU to 16bit index registers
    CPU_A8_XY16
.i16
    ; Read the next char from the address pointed by the zero page pointer
    ldy CollisionCreate_index
    lda (ZP_PTR1), y
    sta CollisionCreate_char
    ; Switch CPU back to 8bit index registers
    CPU_A8_XY8
.i8
    ; Compare to comma character
    cmp #44
    beq @Continue
    ldx CollisionCreate_i
    lda CollisionCreate_char
    sta Global_string, x
    CPU_A8_XY16
    ldx CollisionCreate_index
    inc
    stx CollisionCreate_index
    CPU_A8_XY8
    ldx CollisionCreate_i
    inx
    stx CollisionCreate_i
    bra @ReadNum

@Continue:
    ; Move past the comma character
    CPU_A8_XY16
.i16
    ldx CollisionCreate_index
    inx
    stx CollisionCreate_index
    CPU_A8_XY8
.i8
    ; Store the string terminator character
    ldx CollisionCreate_i
    lda #0
    sta Global_string, x
    ; Zero the index pointer
    stz CollisionCreate_i
    ; Convert the string in to a DWORD, then to a byte and store it in char
    jsr DWordFromStr
    jsr DWordGetByte
    pla
    sta CollisionCreate_char
    ; Calculate the offset position to Global_collision
    DWORD_SET CollisionCreate_calc, 0, 0, 0, 0
    ldx #0
    lda CollisionCreate_yp
    sta CollisionCreate_calc, x
    DWORD_SET CollisionCreate_mult, 0, 0, 0, 32
    DWORD_STACK_PUSH CollisionCreate_calc
    DWORD_STACK_PUSH CollisionCreate_mult
    jsr DWordMultiply
    DWORD_STACK_PULL CollisionCreate_mult
    DWORD_SET CollisionCreate_calc, 0, 0, 0, 0
    ldx #0
    lda CollisionCreate_xp
    sta CollisionCreate_calc, x
    DWORD_STACK_PUSH CollisionCreate_calc
    DWORD_STACK_PUSH CollisionCreate_mult
    jsr DWordAdd
    jsr DWordGetWord
    DWORD_STACK_PULL CollisionCreate_res
    ; Switch CPU to 16bit index registers
    CPU_A8_XY16
.i16
    ; Store the number in to Global_collision
    ldx CollisionCreate_res
    lda CollisionCreate_char
    sta Global_collision, x
    ; Switch CPU back to 8bit index registers
    CPU_A8_XY8
.i8
    ; Increment the x counter
    ldx CollisionCreate_xp
    inx
    stx CollisionCreate_xp
    cpx #32
    bne @LoopXHelper
    ; Increment the y counter
    ldx CollisionCreate_yp
    inx
    stx CollisionCreate_yp
    cpx #32
    bne @LoopYHelper
    bra @Out

@LoopXHelper:
    jmp @LoopX

@LoopYHelper:
    jmp @LoopY

@Out:
    RETURN_ADDRESS_PUSH CollisionCreate_rAddr
    rts
.endproc

.segment "DATA"
MapCreate_xp: .byte 0
MapCreate_yp: .byte 0
MapCreate_i: .byte 0
MapCreate_index: .word 0
MapCreate_entry: .word 0
MapCreate_calc: .dword 0
MapCreate_mult: .dword 0
MapCreate_res: .word 0
MapCreate_word: .word 0
MapCreate_dword: .dword 0
MapCreate_bankOldx: .byte 0

.macro MapCreateOld map, bank
.local @LoopX
.local @LoopY
.local @ReadNum
.local @Continue
.local @LoopXHelper
.local @LoopYHelper
.local @Out
    WORD_SET MapCreate_index, 0, 0
    DWORD_SET MapCreate_dword, 0, 0, 0, 0
    ; Switch banks
    phb
    pla
    sta MapCreate_bankOld
    stz MapCreate_i
    stz MapCreate_yp
@LoopY:
    stz MapCreate_xp
@LoopX:

@ReadNum:
    ; Switch to new bank
    lda #bank
    pha
    plb
    ; Switch CPU to 16bit index registers
    CPU_A8_XY16
.i16
    ; Read the character from the address pointed by the zero page pointer
    ldy MapCreate_index
    lda map, y
    sta MapCreate_byte
    ; Switch bank back to old
    lda MapCreate_bankOld
    pha
    plb
    ; Switch CPU back to 8bit index registers
    CPU_A8_XY8
.i8
    ; Compare to comma character
    lda MapCreate_byte
    cmp #44
    beq @Continue
    ldx MapCreate_i
    sta Global_string, x

    CPU_A8_XY16
.i16
    ldx MapCreate_index
    inx
    stx MapCreate_index
    CPU_A8_XY8
.i8
    ldx MapCreate_i
    inx
    stx MapCreate_i
    bra @ReadNum

@Continue:
    ; Go past the comma character
    CPU_A8_XY16
.i16
    ldx MapCreate_index
    inx
    stx MapCreate_index
    CPU_A8_XY8
.i8
    ; Store the string terminator character
    ldx MapCreate_i
    lda #0
    sta Global_string, x
    ; Reset the Global_string index
    stz MapCreate_i
    ; Convert the string in to a DWORD
    jsr DWordFromStr
    ; Cast to word
    jsr DWordGetWord
    ; Pull the result and store in word
    WORD_STACK_PULL MapCreate_word
    ; Calculate the offset position to Global_map
    DWORD_SET MapCreate_calc, 0, 0, 0, 0
    ldx #0
    lda MapCreate_yp
    sta MapCreate_calc, x
    DWORD_SET MapCreate_mult, 0, 0, 0, 64
    DWORD_STACK_PUSH MapCreate_calc
    DWORD_STACK_PUSH MapCreate_mult
    jsr DWordMultiply
    DWORD_STACK_PULL MapCreate_mult
    DWORD_SET MapCreate_calc, 0, 0, 0, 0
    ldx #0
    lda MapCreate_xp
    sta MapCreate_calc, x
    DWORD_STACK_PUSH MapCreate_calc
    DWORD_STACK_PUSH MapCreate_mult
    jsr DWordAdd
    jsr DWordGetWord
    WORD_STACK_PULL MapCreate_res
    ; Switch CPU to 16bit index registers
    CPU_A8_XY16
.i16
    ; Store the number in to Global_map (low byte first)
    ldx #0
    lda MapCreate_word, x
    ldx MapCreate_res
    sta Global_map, x
    ldx #1
    lda MapCreate_word, x
    ldx MapCreate_res
    inx
    sta Global_map, x
    ; Switch CPU back to 8bit index registers
    CPU_A8_XY8
.i8
    ; Increment the x counter
    ldx MapCreate_xp
    ; Add 2 to x
    inx
    inx
    stx MapCreate_xp
    cpx #64
    bne @LoopXHelper
    ; Increment the y counter
    ldx MapCreate_yp
    inx
    stx MapCreate_yp
    cpx #32
    bne @LoopYHelper
    bra @Out

@LoopXHelper:
    jmp @LoopX

@LoopYHelper:
    jmp @LoopY

@Out:
.endmacro

.segment "DATA"
ZPTest_rAddr: .word 0
ZPTest_dummy: .byte 0
ZPTest_dummy1: .dword 0
ZPTest_values: .byte $1f, $2f
ZPTest_read: .byte 0
ZPTest_write: .word 0
ZPTest_dword: .dword 0

.segment "CODE"
.proc ZPTest
    RETURN_ADDRESS_PULL ZPTest_rAddr
    ZP_STORE_PTR1 ZPTest_write
    WORD_SET ZPTest_write, $fe, $b2
    ldy #0
    ;lda #$ab
    lda (ZP_PTR1), y
    pha
    iny
    ;lda #$cc
    lda (ZP_PTR1), y
    pha
    ;lda #$ab
    ;sta (ZP_PTR1), y
    ;iny
    ;lda #$cc
    ;sta (ZP_PTR1), y
    ;WORD_STACK_PUSH ZPTest_write
    jsr DWordSetWord
    DWORD_STACK_PULL ZPTest_dword
    lda #0
    pha
    DWORD_STACK_PUSH ZPTest_dword
    jsr DWordToStr
    RETURN_ADDRESS_PUSH ZPTest_rAddr
    rts
.endproc



.segment "CODE"
.proc ChangeBgColor
    ; Set the background colour to green.
    lda #%10000000  ; Force VBlank by turning off the screen.
    sta $2100
    lda #%11100000  ; Load the low byte of the green color.
    sta $2122
    lda #%00000000  ; Load the high byte of the green color.
    sta $2122
    lda #%00001111  ; End VBlank, setting brightness to 15 (100%).
    sta $2100
    rts
.endproc

.segment "DATA"
Main_dwordLeft: .dword 0
Main_dwordRight: .dword 0
Main_dwordResult: .dword 0
Main_count: .byte 0
Main_index: .word 0
Main_wordl: .word 0
Main_wordr: .word 0
Main_res: .word 0
Main_sz: .word 0
Main_dw: .dword 0

.segment "CODE"
.proc Main
    CPU_A8_XY8
.i8
    jsr StringZero
    jsr SNESInit
    ScreenOff
    NMIEnable
    wai
    SNESCopyVRAM level_tiles, PPUADDR(CHRADDR), $8000, 4
    CPU_A8_XY16
.i16
    ldx #0
@LoopStore:
    lda logo_map, x
    sta Global_map, x
    inx
    cpx #2048
    bne @LoopStore
    CPU_A8_XY8
.i8
    wai
    ;SNESCopyVRAM Global_map, $0, $800, $7e
    ;SNESCopyVRAM Global_map, PPUADDR(BG1MAPADDR), $800, $7e
    SNESCopyCGRAM level1_palette, 0, $20, 4
    SNESCopyCGRAM level1_palette, 128, $20, 4
    ScreenOn

    ;jsr SNESCopySetup

    ; Initialize the font
    jsr FontInit
    jmp @Forever

@Forever:
    CPU_A8_XY16
.i16
    ldx #0
    stx Main_index
    CPU_A8_XY8
.i8
    WORD_SET Main_wordl, $20, $0
    WORD_SET Main_wordr, 0, $3
@Loop:
    WordAdd Main_wordl, Main_wordr, Main_res
    ;WordShiftRight Main_res
    WORD_STACK_PUSH Main_res
    jsr DWordSetWord
    DWORD_STACK_PULL Main_dw
    lda #0
    pha
    DWORD_STACK_PUSH Main_dw
    jsr DWordToStr
    lda #100
    pha
    lda #0
    pha
    jsr FontWrite
    wai
    SpriteCopyOAM
    jmp @Loop
    rts
 .endproc

 .segment "DATA"
 NMI_called: .byte 0

 .segment "CODE"
 .proc NMI
;    php
;    CPU_A8_XY8
;.a8
;.i8
    ;phb
    ;phd
    ;pha
    ;phx
    ;phy
    ;lda #$00
    ;tcd
    ;phk
    ;plb
    ;SpriteCopyOAM
    ;ply
    ;plx
    ;pla
    ;pld
    ;plb
    ;plp
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
