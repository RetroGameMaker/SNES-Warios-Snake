.macro WordGetByte word, byte
    ldx #0
    lda word, x
    sta byte
.endmacro

.macro WordGetDWord word, dword
    ldx #0
    lda word, x
    sta dword, x
    inx
    lda word, x
    sta dword, x
.endmacro

.macro WordSetByte word, byte
    ldx #0
    lda byte
    sta word, x
    ldx #1
    lda #0
    sta word, x
.endmacro

.macro WordSetDWord word, dword
    ldx #0
    lda dword, x
    sta word, x
    inx
    lda dword, x
    sta word, x
.endmacro

.macro WordBitGet index, word, bit
.local @Index0Helper
.local @Index1Helper
.local @Index2Helper
.local @Index3Helper
.local @Index4Helper
.local @Index5Helper
.local @Index6Helper
.local @Index7Helper
.local @Index8Helper
.local @Index9Helper
.local @Index10Helper
.local @Index11Helper
.local @Index12Helper
.local @Index13Helper
.local @Index14Helper
.local @Continue0
.local @Continue1
.local @Continue2
.local @Continue3
.local @Continue4
.local @Continue5
.local @Continue6
.local @Continue7
.local @Continue8
.local @Continue9
.local @Continue10
.local @Continue11
.local @Continue12
.local @Continue13
.local @Continue14
.local @Index0
.local @Index1
.local @Index2
.local @Index3
.local @Index4
.local @Index5
.local @Index6
.local @Index7
.local @Index8
.local @Index9
.local @Index10
.local @Index11
.local @Index12
.local @Index13
.local @Index14
.local @Index15
.local @Out
.local @StoreOne
.local @StoreZero
.local @Store
    lda index
    cmp #0
    beq @Index0Helper
    bra @Continue0
@Index0Helper:
    jmp @Index0
@Continue0:
    cmp #1
    beq @Index1Helper
    bra @Continue1
@Index1Helper:
    jmp @Index1
@Continue1:
    cmp #2
    beq @Index2Helper
    bra @Continue2
@Index2Helper:
    jmp @Index2
@Continue2:
    cmp #3
    beq @Index3Helper
    bra @Continue3
@Index3Helper:
    jmp @Index3
@Continue3:
    cmp #4
    beq @Index4Helper
    bra @Continue4
@Index4Helper:
    jmp @Index4
@Continue4:
    cmp #5
    beq @Index5Helper
    bra @Continue5
@Index5Helper:
    jmp @Index5
@Continue5:
    cmp #6
    beq @Index6Helper
    bra @Continue6
@Index6Helper:
    jmp @Index6
@Continue6:
    cmp #7
    beq @Index7Helper
    bra @Continue7
@Index7Helper:
    jmp @Index7
@Continue7:
    cmp #8
    beq @Index8Helper
    bra @Continue8
@Index8Helper:
    jmp @Index8
@Continue8:
    cmp #9
    beq @Index9Helper
    bra @Continue9
@Index9Helper:
    jmp @Index9
@Continue9:
    cmp #10
    beq @Index10Helper
    bra @Continue10
@Index10Helper:
    jmp @Index10
@Continue10:
    cmp #11
    beq @Index11Helper
    bra @Continue11
@Index11Helper:
    jmp @Index11
@Continue11:
    cmp #12
    beq @Index12Helper
    bra @Continue12
@Index12Helper:
    jmp @Index12
@Continue12:
    cmp #13
    beq @Index13Helper
    bra @Continue13
@Index13Helper:
    jmp @Index13
@Continue13:
    cmp #14
    beq @Index14Helper
    bra @Continue14
@Index14Helper:
    jmp @Index14
@Continue14:
    ; Defaults to index 15
    jmp @Index15

@Index0:
    ldx #0
    lda #$1
    and word, x
    jmp @Out
@Index1:
    ldx #0
    lda #$2
    and word, x
    jmp @Out
@Index2:
    ldx #0
    lda #$4
    and word, x
    jmp @Out
@Index3:
    ldx #0
    lda #$8
    and word, x
    jmp @Out
@Index4:
    ldx #0
    lda #$10
    and word, x
    jmp @Out
@Index5:
    ldx #0
    lda #$20
    and word, x
    jmp @Out
@Index6:
    ldx #0
    lda #$40
    and word, x
    jmp @Out
@Index7:
    ldx #0
    lda #$80
    and word, x
    jmp @Out
@Index8:
    ldx #1
    lda #$1
    and word, x
    jmp @Out
@Index9:
    ldx #1
    lda #$2
    and word, x
    jmp @Out
@Index10:
    ldx #1
    lda #$4
    and word, x
    jmp @Out
@Index11:
    ldx #1
    lda #$8
    and word, x
    jmp @Out
@Index12:
    ldx #1
    lda #$10
    and word, x
    jmp @Out
@Index13:
    ldx #1
    lda #$20
    and word, x
    jmp @Out
@Index14:
    ldx #1
    lda #$40
    and word, x
    jmp @Out
@Index15:
    ldx #1
    lda #$80
    and word, x
    jmp @Out
@Out:
    cmp #0
    beq @StoreZero
    bra @StoreOne
@StoreOne:
    lda #1
    bra @Store
@StoreZero:
    lda #0
@Store:
    sta bit
.endmacro

.macro WordBitSet index, set, word
.local @Index0Helper
.local @Index1Helper
.local @Index2Helper
.local @Index3Helper
.local @Index4Helper
.local @Index5Helper
.local @Index6Helper
.local @Index7Helper
.local @Index8Helper
.local @Index9Helper
.local @Index10Helper
.local @Index11Helper
.local @Index12Helper
.local @Index13Helper
.local @Index14Helper
.local @Continue0
.local @Continue1
.local @Continue2
.local @Continue3
.local @Continue4
.local @Continue5
.local @Continue6
.local @Continue7
.local @Continue8
.local @Continue9
.local @Continue10
.local @Continue11
.local @Continue12
.local @Continue13
.local @Continue14
.local @Index0
.local @Index1
.local @Index2
.local @Index3
.local @Index4
.local @Index5
.local @Index6
.local @Index7
.local @Index8
.local @Index9
.local @Index10
.local @Index11
.local @Index12
.local @Index13
.local @Index14
.local @Index15
.local @Index0Set
.local @Index1Set
.local @Index2Set
.local @Index3Set
.local @Index4Set
.local @Index5Set
.local @Index6Set
.local @Index7Set
.local @Index8Set
.local @Index9Set
.local @Index10Set
.local @Index11Set
.local @Index12Set
.local @Index13Set
.local @Index14Set
.local @Index15Set
.local @Index0Clear
.local @Index1Clear
.local @Index2Clear
.local @Index3Clear
.local @Index4Clear
.local @Index5Clear
.local @Index6Clear
.local @Index7Clear
.local @Index8Clear
.local @Index9Clear
.local @Index10Clear
.local @Index11Clear
.local @Index12Clear
.local @Index13Clear
.local @Index14Clear
.local @Index15Clear
.local @Out
    ; Figure out where we should jump to
    lda index
    cmp #0
    beq @Index0Helper
    bra @Continue0
@Index0Helper:
    jmp @Index0
@Continue0:
    cmp #1
    beq @Index1Helper
    bra @Continue1
@Index1Helper:
    jmp @Index1
@Continue1:
    cmp #2
    beq @Index2Helper
    bra @Continue2
@Index2Helper:
    jmp @Index2
@Continue2:
    cmp #3
    beq @Index3Helper
    bra @Continue3
@Index3Helper:
    jmp @Index3
@Continue3:
    cmp #4
    beq @Index4Helper
    bra @Continue4
@Index4Helper:
    jmp @Index4
@Continue4:
    cmp #5
    beq @Index5Helper
    bra @Continue5
@Index5Helper:
    jmp @Index5
@Continue5:
    cmp #6
    beq @Index6Helper
    bra @Continue6
@Index6Helper:
    jmp @Index6
@Continue6:
    cmp #7
    beq @Index7Helper
    bra @Continue7
@Index7Helper:
    jmp @Index7
@Continue7:
    cmp #8
    beq @Index8Helper
    bra @Continue8
@Index8Helper:
    jmp @Index8
@Continue8:
    cmp #9
    beq @Index9Helper
    bra @Continue9
@Index9Helper:
    jmp @Index9
@Continue9:
    cmp #10
    beq @Index10Helper
    bra @Continue10
@Index10Helper:
    jmp @Index10
@Continue10:
    cmp #11
    beq @Index11Helper
    bra @Continue11
@Index11Helper:
    jmp @Index11
@Continue11:
    cmp #12
    beq @Index12Helper
    bra @Continue12
@Index12Helper:
    jmp @Index12
@Continue12:
    cmp #13
    beq @Index13Helper
    bra @Continue13
@Index13Helper:
    jmp @Index13
@Continue13:
    cmp #14
    beq @Index14Helper
    bra @Continue14
@Index14Helper:
    jmp @Index14
@Continue14:
    ; Defaults to index 15
    jmp @Index15

@Index0:
    ldx #0
    lda set
    cmp #0
    bne @Index0Set
    bra @Index0Clear
@Index0Set:
    lda #$1
    ora word, x
    jmp @Out
@Index0Clear:
    lda word, x
    and #$fe
    jmp @Out

@Index1:
    ldx #0
    lda set
    cmp #0
    bne @Index1Set
    bra @Index1Clear
@Index1Set:
    lda #$2
    ora word, x
    jmp @Out
@Index1Clear:
    lda word, x
    and #$fd
    jmp @Out

@Index2:
    ldx #0
    lda set
    cmp #0
    bne @Index2Set
    bra @Index2Clear
@Index2Set:
    lda #$4
    ora word, x
    jmp @Out
@Index2Clear:
    lda word, x
    and #$fb
    jmp @Out

@Index3:
    ldx #0
    lda set
    cmp #0
    bne @Index3Set
    bra @Index3Clear
@Index3Set:
    lda #$8
    ora word, x
    jmp @Out
@Index3Clear:
    lda word, x
    and #$f7
    jmp @Out

@Index4:
    ldx #0
    lda set
    cmp #0
    bne @Index4Set
    bra @Index4Clear
@Index4Set:
    lda #$10
    ora word, x
    jmp @Out
@Index4Clear:
    lda word, x
    and #$ef
    jmp @Out

@Index5:
    ldx #0
    lda set
    cmp #0
    bne @Index5Set
    bra @Index5Clear
@Index5Set:
    lda #$20
    ora word, x
    jmp @Out
@Index5Clear:
    lda word, x
    and #$df
    jmp @Out

@Index6:
    ldx #0
    lda set
    cmp #0
    bne @Index6Set
    bra @Index6Clear
@Index6Set:
    lda #$40
    ora word, x
    jmp @Out
@Index6Clear:
    lda word, x
    and #$bf
    jmp @Out

@Index7:
    ldx #0
    lda set
    cmp #0
    bne @Index7Set
    bra @Index7Clear
@Index7Set:
    lda #$80
    ora word, x
    jmp @Out
@Index7Clear:
    lda word, x
    and #$7f
    jmp @Out

@Index8:
    ldx #1
    lda set
    cmp #0
    bne @Index8Set
    bra @Index8Clear
@Index8Set:
    lda #$1
    ora word, x
    jmp @Out
@Index8Clear:
    lda word, x
    and #$fe
    jmp @Out

@Index9:
    ldx #1
    lda set
    cmp #0
    bne @Index9Set
    bra @Index9Clear
@Index9Set:
    lda #$2
    ora word, x
    jmp @Out
@Index9Clear:
    lda word, x
    and #$fd
    jmp @Out

@Index10:
    ldx #1
    lda set
    cmp #0
    bne @Index10Set
    bra @Index10Clear
@Index10Set:
    lda #$4
    ora word, x
    jmp @Out
@Index10Clear:
    lda word, x
    and #$fb
    jmp @Out

@Index11:
    ldx #1
    lda set
    cmp #0
    bne @Index11Set
    bra @Index11Clear
@Index11Set:
    lda #$8
    ora word, x
    jmp @Out
@Index11Clear:
    lda word, x
    and #$f7
    jmp @Out

@Index12:
    ldx #1
    lda set
    cmp #0
    bne @Index12Set
    bra @Index12Clear
@Index12Set:
    lda #$10
    ora word, x
    jmp @Out
@Index12Clear:
    lda word, x
    and #$ef
    jmp @Out

@Index13:
    ldx #1
    lda set
    cmp #0
    bne @Index13Set
    bra @Index13Clear
@Index13Set:
    lda #$20
    ora word, x
    jmp @Out
@Index13Clear:
    lda word, x
    and #$df
    jmp @Out

@Index14:
    ldx #1
    lda set
    cmp #0
    bne @Index14Set
    bra @Index14Clear
@Index14Set:
    lda #$40
    ora word, x
    jmp @Out
@Index14Clear:
    lda word, x
    and #$bf
    jmp @Out

@Index15:
    ldx #1
    lda set
    cmp #0
    bne @Index15Set
    bra @Index15Clear
@Index15Set:
    lda #$80
    ora word, x
    jmp @Out
@Index15Clear:
    lda word, x
    and #$7f
@Out:
    sta word, x
.endmacro

.segment "DATA"
WordNegate_count: .byte 0

.macro WordNegate word
.local @Loop
    lda #2
    sta WordNegate_count
@Loop:
    ldx WordNegate_count
    dex
    stx WordNegate_count
    lda word, x
    pha
    jsr ByteNegate
    ; Pull the byte from stack and save in the variable
    pla
    ldx WordNegate_count
    sta word, x
    cpx #0
    bne @Loop
.endmacro

.macro WordShiftLeft word
    CPU_A16_XY16
.a16
.i16
    lda word
    asl
    sta word
    CPU_A8_XY8
.a8
.i8
.endmacro

.macro WordShiftRight word
    CPU_A16_XY16
.a16
.i16
    lda word
    lsr
    sta word
    CPU_A8_XY8
.a8
.i8
.endmacro

.macro WordCompare wordl, wordr, res
.local @Equal
.local @GreaterIsRight
.local @GreaterIsLeft
.local @Out
    CPU_A16_XY16
.a16
.i16
    lda wordl
    cmp wordr
    beq @Equal
    cmp wordr
    bcc @GreaterIsRight
    bra @GreaterIsLeft
@Equal:
    CPU_A8_XY8
.a8
.i8
    lda #0
    bra @Out
@GreaterIsRight:
    CPU_A8_XY8
.a8
.i8
    lda #1
    bra @Out
@GreaterIsLeft:
    CPU_A8_XY8
.a8
.i8
    lda #255
@Out:
    sta res
.endmacro

.macro WordAdd wordl, wordr, res
    CPU_A16_XY16
.a16
.i16
    lda wordl
    clc
    adc wordr
    sta res
    CPU_A8_XY8
.a8
.i8
.endmacro

.macro WordSubtract wordl, wordr, res
    CPU_A16_XY16
.a16
.i16
    lda wordl
    sec
    sbc wordr
    sta res
    CPU_A8_XY8
.a8
.i8
.endmacro

.segment "DATA"
WordMultiply_index: .byte 0
WordMultiply_bit: .byte 0
WordMultiply_left: .word 0

.macro WordMultiply wordl, wordr, res
.local @Loop
.local @LoopNext
.local @Out
    ; Start from bit 0
    stz WordMultiply_index
    ; Clone the left argument
    ARRAY_COPY WordMultiply_left, wordl, 2
    ; Zero the right argument
    WORD_SET res, 0, 0
@Loop:
    WordBitGet WordMultiply_index, wordr, WordMultiply_bit
    lda WordMultiply_bit
    cmp #0
    beq @LoopNext
    ; Add left and right together
    WordAdd WordMultiply_left, res, res
@LoopNext:
    ; Shift the left argument left by one position
    WordShiftLeft WordMultiply_left
    ; Increment our bit counter
    lda WordMultiply_index
    inc
    sta WordMultiply_index
    cmp #16
    beq @Out
    jmp @Loop
@Out:
.endmacro

.segment "DATA"
WordDivide_work: .word 0
WordDivide_status: .byte 0
WordDivide_index: .byte 0
WordDivide_zero: .byte 0

.macro WordDivide wordl, wordr, res
.local @DivideByZero
.local @Continue
.local @DivisionOfZero
.local @Continue2
.local @LoopDivide
.local @GreaterIsLeft
.local @GreaterIsRight
.local @OutHelper
.local @Out
    ; Zero the res value
    WORD_SET res, 0, 0
    ; Zero the work value
    WORD_SET WordDivide_work, 0, 0
    ; Zero the byte
    lda #0
    sta WordDivide_zero
    ; Compare right argument to zero (division by zero)
    WordCompare wordr, res, WordDivide_status
    lda WordDivide_status
    cmp #0
    beq @DivideByZero
    bra @Continue

@DivideByZero:
    jmp @Out

@Continue:
    ; Compare right argument to zero (division of zero)
    WordCompare wordl, res, WordDivide_status
    lda WordDivide_status
    cmp #0
    beq @DivisionOfZero
    bra @Continue2

@DivisionOfZero:
    jmp @Out

@Continue2:
    ; Index contains our bit counter
    lda #15
    sta WordDivide_index
@LoopDivide:
    ; Get the status of the index bit
    WordBitGet WordDivide_index, wordl, WordDivide_status
    ; Set 0th bit of work to that status
    WordBitSet WordDivide_zero, WordDivide_status, WordDivide_work
    ; Shift the result left
    WordShiftLeft res
    ; Compare work to right argument
    WordCompare wordr, WordDivide_work, WordDivide_status
    lda WordDivide_status
    cmp #255
    beq @GreaterIsLeft
    bra @GreaterIsRight

@GreaterIsLeft:
    ; Shift the bits in WordDivide_work 1 position to the left
    WordShiftLeft WordDivide_work
    ; Restore our bit counter
    lda WordDivide_index
    dec
    sta WordDivide_index
    cmp #255
    beq @OutHelper
    jmp @LoopDivide

@OutHelper:
    jmp @Out

@GreaterIsRight:
    ; Set the 0th bit to on on res
    lda #1
    sta WordDivide_status
    WordBitSet WordDivide_zero, WordDivide_status, res
    ; We now need to call WordSubtract
    WordSubtract WordDivide_work, wordr, WordDivide_work
    ; Shift the result on the stack left by one
    WordShiftLeft WordDivide_work
    ; Decrement out bit index counter
    lda WordDivide_index
    dec
    sta WordDivide_index
    cmp #255
    beq @Out
    jmp @LoopDivide
@Out:
.endmacro

.segment "DATA"
WordModulus_work: .word 0
WordModulus_status: .byte 0
WordModulus_index: .byte 0
WordModulus_zero: .byte 0

.macro WordModulus wordl, wordr, res
.local @DivideByZero
.local @Continue
.local @DivisionOfZero
.local @Continue2
.local @LoopDivide
.local @GreaterIsLeft
.local @GreaterIsRight
.local @OutHelper
.local @Out
    ; Zero the res value
    WORD_SET res, 0, 0
    ; Zero the work value
    WORD_SET WordModulus_work, 0, 0
    ; Zero the byte
    lda #0
    sta WordModulus_zero
    ; Compare right argument to zero (division by zero)
    WordCompare wordr, res, WordModulus_status
    lda WordModulus_status
    cmp #0
    beq @DivideByZero
    bra @Continue

@DivideByZero:
    jmp @Out

@Continue:
    ; Compare right argument to zero (division of zero)
    WordCompare wordl, res, WordModulus_status
    lda WordModulus_status
    cmp #0
    beq @DivisionOfZero
    bra @Continue2

@DivisionOfZero:
    jmp @Out

@Continue2:
    ; Index contains our bit counter
    lda #15
    sta WordModulus_index
@LoopDivide:
    ; Get the status of the index bit
    WordBitGet WordModulus_index, wordl, WordModulus_status
    ; Set 0th bit of work to that status
    WordBitSet WordModulus_zero, WordModulus_status, WordModulus_work
    ; Shift the result left
    WordShiftLeft res
    ; Compare work to right argument
    WordCompare WordModulus_work, wordr, WordModulus_status
    lda WordModulus_status
    cmp #255
    beq @GreaterIsLeft
    bra @GreaterIsRight

@GreaterIsLeft:
    ; Check if we need to exit
    lda WordModulus_index
    cmp #0
    beq @OutHelper
    ; Shift the bits in WordModulus_work 1 position to the left
    WordShiftLeft WordModulus_work
    ; Restore our bit counter
    lda WordModulus_index
    dec
    sta WordModulus_index
    jmp @LoopDivide

@OutHelper:
    jmp @Out

@GreaterIsRight:
    ; Set the 0th bit to on on res
    lda #1
    sta WordModulus_status
    WordBitSet WordModulus_zero, WordModulus_status, res
    ; We now need to call WordSubtract
    WordSubtract WordModulus_work, wordr, WordModulus_work
    ; Check if we need to exit
    lda WordModulus_index
    cmp #0
    beq @Out
    ; Shift the result on the stack left by one
    WordShiftLeft WordModulus_work
    ; Decrement out bit index counter
    lda WordModulus_index
    dec
    sta WordModulus_index
    jmp @LoopDivide
@Out:
    ARRAY_COPY res, WordModulus_work, 2
.endmacro

.macro WordInc word
    CPU_A16_XY16
.a16
.i16
    lda word
    inc
    sta word
    CPU_A8_XY8
.a8
.i8
.endmacro

.macro WordDec word
    CPU_A16_XY16
.a16
.i16
    lda word
    dec
    sta word
    CPU_A8_XY8
.a8
.i8
.endmacro
