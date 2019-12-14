.segment "DATA"
MapCreate_bankOld: .byte 0

.macro MapCreate map, bank
.local @Loop
    ; Store old bank
    phb
    pla
    sta MapCreate_bankOld
    ; Switch to new bank
    lda #bank
    pha
    plb
    CPU_A8_XY16
.i16
    ldx #2048
@Loop:
    dex
    lda map, x
    sta Global_map, x
    cpx #0
    bne @Loop
    CPU_A8_XY8
.i8
    ; Switch back to old bank
    lda MapCreate_bankOld
    pha
    plb
.endmacro

.segment "DATA"
MapGetXY_rAddr: .word 0
MapGetXY_xp: .byte 0
MapGetXY_yp: .byte 0
MapGetXY_calc: .word 0
MapGetXY_mult: .word 0
MapGetXY_work: .word 0
MapGetXY_res: .word 0
MapGetXY_entry: .word 0

.segment "CODE"
.proc MapGetXY
    RETURN_ADDRESS_PULL MapGetXY_rAddr
    pla
    sta MapGetXY_xp
    pla
    sta MapGetXY_yp
    ; Calculate the y position
    WordSetByte MapGetXY_calc, MapGetXY_yp
    WORD_SET MapGetXY_mult, 0, 64
    WordMultiply MapGetXY_calc, MapGetXY_mult, MapGetXY_work
    ; Calculate the x position
    WordSetByte MapGetXY_calc, MapGetXY_xp
    ; Multiply x by 2
    WordShiftLeft MapGetXY_calc
    ; Calculate the final offset
    WordAdd MapGetXY_calc, MapGetXY_work, MapGetXY_res
    ; Switch CPU to 16bit index registers
    CPU_A8_XY16
.i16
    ldx MapGetXY_res
    lda Global_map, x
    ldy #0
    sta MapGetXY_entry, y
    inx
    lda Global_map, x
    iny
    sta MapGetXY_entry, y
    ; Switch CPU back to 8bit index registers
    CPU_A8_XY8
.i8
    ; Return the map entry we found at x/y
    WORD_STACK_PUSH MapGetXY_entry
    RETURN_ADDRESS_PUSH MapGetXY_rAddr
    rts
.endproc

.segment "DATA"
MapSetXY_rAddr: .word 0
MapSetXY_xp: .byte 0
MapSetXY_yp: .byte 0
MapSetXY_calc: .word 0
MapSetXY_mult: .word 0
MapSetXY_work: .word 0
MapSetXY_res: .word 0
MapSetXY_entry: .word 0

.segment "CODE"
.proc MapSetXY
    RETURN_ADDRESS_PULL MapSetXY_rAddr
    ; Pull the arguments from stack
    pla
    sta MapSetXY_xp
    pla
    sta MapSetXY_yp
    pla
    ldx #0
    sta MapSetXY_entry, x
    inx
    lda #0
    sta MapSetXY_entry, x
    ; Calculate the y position
    WordSetByte MapSetXY_calc, MapSetXY_yp
    WORD_SET MapSetXY_mult, 0, 64
    WordMultiply MapSetXY_calc, MapSetXY_mult, MapSetXY_work
    ; Calculate the x position
    WordSetByte MapSetXY_calc, MapSetXY_xp
    ; Multiply x by 2
    WordShiftLeft MapSetXY_calc
    ; Calculate the final offset
    WordAdd MapSetXY_calc, MapSetXY_work, MapSetXY_res
    ; Switch CPU to 16bit index registers
    CPU_A8_XY16
.i16
    ldy #0
    lda MapSetXY_entry, y
    ldx MapSetXY_res
    sta Global_map, x
    iny
    lda MapSetXY_entry, y
    inx
    sta Global_map, x
    ; Switch CPU back to 8bit index registers
    CPU_A8_XY8
.i8
    RETURN_ADDRESS_PUSH MapSetXY_rAddr
    rts
.endproc
