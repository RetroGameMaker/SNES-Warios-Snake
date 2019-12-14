.segment "DATA"
DWordGetByte_rAddr: .word 0
DWordGetByte_dword: .dword 0

.segment "CODE"
.proc DWordGetByte
    RETURN_ADDRESS_PULL DWordGetByte_rAddr
    DWORD_STACK_PULL DWordGetByte_dword
    ldx #0
    lda DWordGetByte_dword, x
    pha
    RETURN_ADDRESS_PUSH DWordGetByte_rAddr
    rts
.endproc

.segment "DATA"
DWordGetWord_rAddr: .word 0
DWordGetWord_word: .word 0
DWordGetWord_dword: .dword 0

.segment "CODE"
.proc DWordGetWord
    RETURN_ADDRESS_PULL DWordGetWord_rAddr
    DWORD_STACK_PULL DWordGetWord_dword
    ldx #0
    lda DWordGetWord_dword, x
    sta DWordGetWord_word, x
    inx
    lda DWordGetWord_dword, x
    sta DWordGetWord_word, x
    WORD_STACK_PUSH DWordGetWord_word
    RETURN_ADDRESS_PUSH DWordGetWord_rAddr
    rts
.endproc

.segment "DATA"
DWordSetByte_rAddr: .word 0
DWordSetByte_byte: .byte 0
DWordSetByte_dword: .dword 0

.segment "CODE"
.proc DWordSetByte
    RETURN_ADDRESS_PULL DWordSetByte_rAddr
    pla
    sta DWordSetByte_byte
    DWORD_SET DWordSetByte_dword, 0, 0, 0, 0
    ldx #0
    lda DWordSetByte_byte
    sta DWordSetByte_dword, x
    DWORD_STACK_PUSH DWordSetByte_dword
    RETURN_ADDRESS_PUSH DWordSetByte_rAddr
    rts
.endproc

.segment "DATA"
DWordSetWord_rAddr: .word 0
DWordSetWord_word: .word 0
DWordSetWord_dword: .dword 0

.segment "CODE"
.proc DWordSetWord
    RETURN_ADDRESS_PULL DWordSetWord_rAddr
    WORD_STACK_PULL DWordSetWord_word
    DWORD_SET DWordSetWord_dword, 0, 0, 0, 0
    ldx #0
    lda DWordSetWord_word, x
    sta DWordSetWord_dword, x
    inx
    lda DWordSetWord_word, x
    sta DWordSetWord_dword, x
    DWORD_STACK_PUSH DWordSetWord_dword
    RETURN_ADDRESS_PUSH DWordSetWord_rAddr
    rts
.endproc

.segment "DATA"
DWordBitGet_rAddr: .word 0
DWordBitGet_index: .byte 0
DWordBitGet_val: .dword 0

.segment "CODE"
.proc DWordBitGet
    RETURN_ADDRESS_PULL DWordBitGet_rAddr
    ; Get the bit index we should return (stored as a byte)
    pla
    sta DWordBitGet_index
    ; Retrieve the DWORD value from the stack
    DWORD_STACK_PULL DWordBitGet_val
    ; Figure out where we should jump to
    lda DWordBitGet_index
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
    cmp #15
    beq @Index15Helper
    bra @Continue15
@Index15Helper:
    jmp @Index15
@Continue15:
    cmp #16
    beq @Index16Helper
    bra @Continue16
@Index16Helper:
    jmp @Index16
@Continue16:
    cmp #17
    beq @Index17Helper
    bra @Continue17
@Index17Helper:
    jmp @Index17
@Continue17:
    cmp #18
    beq @Index18Helper
    bra @Continue18
@Index18Helper:
    jmp @Index18
@Continue18:
    cmp #19
    beq @Index19Helper
    bra @Continue19
@Index19Helper:
    jmp @Index19
@Continue19:
    cmp #20
    beq @Index20Helper
    bra @Continue20
@Index20Helper:
    jmp @Index20
@Continue20:
    cmp #21
    beq @Index21Helper
    bra @Continue21
@Index21Helper:
    jmp @Index21
@Continue21:
    cmp #22
    beq @Index22Helper
    bra @Continue22
@Index22Helper:
    jmp @Index22
@Continue22:
    cmp #23
    beq @Index23Helper
    bra @Continue23
@Index23Helper:
    jmp @Index23
@Continue23:
    cmp #24
    beq @Index24Helper
    bra @Continue24
@Index24Helper:
    jmp @Index24
@Continue24:
    cmp #25
    beq @Index25Helper
    bra @Continue25
@Index25Helper:
    jmp @Index25
@Continue25:
    cmp #26
    beq @Index26Helper
    bra @Continue26
@Index26Helper:
    jmp @Index26
@Continue26:
    cmp #27
    beq @Index27Helper
    bra @Continue27
@Index27Helper:
    jmp @Index27
@Continue27:
    cmp #28
    beq @Index28Helper
    bra @Continue28
@Index28Helper:
    jmp @Index28
@Continue28:
    cmp #29
    beq @Index29Helper
    bra @Continue29
@Index29Helper:
    jmp @Index29
@Continue29:
    cmp #30
    beq @Index30Helper
    bra @Continue30
@Index30Helper:
    jmp @Index30
@Continue30:
    ; Defaults to index 31
    jmp @Index31

@Index0:
    ldx #0
    lda #$1
    and DWordBitGet_val, x
    jmp @Out
@Index1:
    ldx #0
    lda #$2
    and DWordBitGet_val, x
    jmp @Out
@Index2:
    ldx #0
    lda #$4
    and DWordBitGet_val, x
    jmp @Out
@Index3:
    ldx #0
    lda #$8
    and DWordBitGet_val, x
    jmp @Out
@Index4:
    ldx #0
    lda #$10
    and DWordBitGet_val, x
    jmp @Out
@Index5:
    ldx #0
    lda #$20
    and DWordBitGet_val, x
    jmp @Out
@Index6:
    ldx #0
    lda #$40
    and DWordBitGet_val, x
    jmp @Out
@Index7:
    ldx #0
    lda #$80
    and DWordBitGet_val, x
    jmp @Out
@Index8:
    ldx #1
    lda #$1
    and DWordBitGet_val, x
    jmp @Out
@Index9:
    ldx #1
    lda #$2
    and DWordBitGet_val, x
    jmp @Out
@Index10:
    ldx #1
    lda #$4
    and DWordBitGet_val, x
    jmp @Out
@Index11:
    ldx #1
    lda #$8
    and DWordBitGet_val, x
    jmp @Out
@Index12:
    ldx #1
    lda #$10
    and DWordBitGet_val, x
    jmp @Out
@Index13:
    ldx #1
    lda #$20
    and DWordBitGet_val, x
    jmp @Out
@Index14:
    ldx #1
    lda #$40
    and DWordBitGet_val, x
    jmp @Out
@Index15:
    ldx #1
    lda #$80
    and DWordBitGet_val, x
    jmp @Out
@Index16:
    ldx #2
    lda #$1
    and DWordBitGet_val, x
    jmp @Out
@Index17:
    ldx #2
    lda #$2
    and DWordBitGet_val, x
    jmp @Out
@Index18:
    ldx #2
    lda #$4
    and DWordBitGet_val, x
    jmp @Out
@Index19:
    ldx #2
    lda #$8
    and DWordBitGet_val, x
    jmp @Out
@Index20:
    ldx #2
    lda #$10
    and DWordBitGet_val, x
    jmp @Out
@Index21:
    ldx #2
    lda #$20
    and DWordBitGet_val, x
    jmp @Out
@Index22:
    ldx #2
    lda #$40
    and DWordBitGet_val, x
    jmp @Out
@Index23:
    ldx #2
    lda #$80
    and DWordBitGet_val, x
    jmp @Out
@Index24:
    ldx #3
    lda #$1
    and DWordBitGet_val, x
    jmp @Out
@Index25:
    ldx #3
    lda #$2
    and DWordBitGet_val, x
    jmp @Out
@Index26:
    ldx #3
    lda #$4
    and DWordBitGet_val, x
    jmp @Out
@Index27:
    ldx #3
    lda #$8
    and DWordBitGet_val, x
    jmp @Out
@Index28:
    ldx #3
    lda #$10
    and DWordBitGet_val, x
    jmp @Out
@Index29:
    ldx #3
    lda #$20
    and DWordBitGet_val, x
    jmp @Out
@Index30:
    ldx #3
    lda #$40
    and DWordBitGet_val, x
    jmp @Out
@Index31:
    ldx #3
    lda #$80
    and DWordBitGet_val, x
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
    pha
    RETURN_ADDRESS_PUSH DWordBitGet_rAddr
    rts
.endproc

.segment "DATA"
DWordBitSet_rAddr: .word 0
DWordBitSet_index: .byte 0
DWordBitSet_set: .byte 0
DWordBitSet_val: .dword 0

.segment "CODE"
.proc DWordBitSet
    RETURN_ADDRESS_PULL DWordBitSet_rAddr
    ; Get the bit index we should return (stored as a byte)
    pla
    sta DWordBitSet_index
    ; Get whether or not we want to set it to zero or one
    pla
    sta DWordBitSet_set
    ; Retrieve the DWORD value from the stack
    DWORD_STACK_PULL DWordBitSet_val
    ; Figure out where we should jump to
    lda DWordBitSet_index
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
    cmp #15
    beq @Index15Helper
    bra @Continue15
@Index15Helper:
    jmp @Index15
@Continue15:
    cmp #16
    beq @Index16Helper
    bra @Continue16
@Index16Helper:
    jmp @Index16
@Continue16:
    cmp #17
    beq @Index17Helper
    bra @Continue17
@Index17Helper:
    jmp @Index17
@Continue17:
    cmp #18
    beq @Index18Helper
    bra @Continue18
@Index18Helper:
    jmp @Index18
@Continue18:
    cmp #19
    beq @Index19Helper
    bra @Continue19
@Index19Helper:
    jmp @Index19
@Continue19:
    cmp #20
    beq @Index20Helper
    bra @Continue20
@Index20Helper:
    jmp @Index20
@Continue20:
    cmp #21
    beq @Index21Helper
    bra @Continue21
@Index21Helper:
    jmp @Index21
@Continue21:
    cmp #22
    beq @Index22Helper
    bra @Continue22
@Index22Helper:
    jmp @Index22
@Continue22:
    cmp #23
    beq @Index23Helper
    bra @Continue23
@Index23Helper:
    jmp @Index23
@Continue23:
    cmp #24
    beq @Index24Helper
    bra @Continue24
@Index24Helper:
    jmp @Index24
@Continue24:
    cmp #25
    beq @Index25Helper
    bra @Continue25
@Index25Helper:
    jmp @Index25
@Continue25:
    cmp #26
    beq @Index26Helper
    bra @Continue26
@Index26Helper:
    jmp @Index26
@Continue26:
    cmp #27
    beq @Index27Helper
    bra @Continue27
@Index27Helper:
    jmp @Index27
@Continue27:
    cmp #28
    beq @Index28Helper
    bra @Continue28
@Index28Helper:
    jmp @Index28
@Continue28:
    cmp #29
    beq @Index29Helper
    bra @Continue29
@Index29Helper:
    jmp @Index29
@Continue29:
    cmp #30
    beq @Index30Helper
    bra @Continue30
@Index30Helper:
    jmp @Index30
@Continue30:
    ; Defaults to index 31
    jmp @Index31

@Index0:
    ldx #0
    lda DWordBitSet_set
    cmp #0
    bne @Index0Set
    bra @Index0Clear
@Index0Set:
    lda #$1
    ora DWordBitSet_val, x
    jmp @Out
@Index0Clear:
    lda DWordBitSet_val, x
    and #$fe
    jmp @Out

@Index1:
    ldx #0
    lda DWordBitSet_set
    cmp #0
    bne @Index1Set
    bra @Index1Clear
@Index1Set:
    lda #$2
    ora DWordBitSet_val, x
    jmp @Out
@Index1Clear:
    lda DWordBitSet_val, x
    and #$fd
    jmp @Out

@Index2:
    ldx #0
    lda DWordBitSet_set
    cmp #0
    bne @Index2Set
    bra @Index2Clear
@Index2Set:
    lda #$4
    ora DWordBitSet_val, x
    jmp @Out
@Index2Clear:
    lda DWordBitSet_val, x
    and #$fb
    jmp @Out

@Index3:
    ldx #0
    lda DWordBitSet_set
    cmp #0
    bne @Index3Set
    bra @Index3Clear
@Index3Set:
    lda #$8
    ora DWordBitSet_val, x
    jmp @Out
@Index3Clear:
    lda DWordBitSet_val, x
    and #$f7
    jmp @Out

@Index4:
    ldx #0
    lda DWordBitSet_set
    cmp #0
    bne @Index4Set
    bra @Index4Clear
@Index4Set:
    lda #$10
    ora DWordBitSet_val, x
    jmp @Out
@Index4Clear:
    lda DWordBitSet_val, x
    and #$ef
    jmp @Out

@Index5:
    ldx #0
    lda DWordBitSet_set
    cmp #0
    bne @Index5Set
    bra @Index5Clear
@Index5Set:
    lda #$20
    ora DWordBitSet_val, x
    jmp @Out
@Index5Clear:
    lda DWordBitSet_val, x
    and #$df
    jmp @Out

@Index6:
    ldx #0
    lda DWordBitSet_set
    cmp #0
    bne @Index6Set
    bra @Index6Clear
@Index6Set:
    lda #$40
    ora DWordBitSet_val, x
    jmp @Out
@Index6Clear:
    lda DWordBitSet_val, x
    and #$bf
    jmp @Out

@Index7:
    ldx #0
    lda DWordBitSet_set
    cmp #0
    bne @Index7Set
    bra @Index7Clear
@Index7Set:
    lda #$80
    ora DWordBitSet_val, x
    jmp @Out
@Index7Clear:
    lda DWordBitSet_val, x
    and #$7f
    jmp @Out

@Index8:
    ldx #1
    lda DWordBitSet_set
    cmp #0
    bne @Index8Set
    bra @Index8Clear
@Index8Set:
    lda #$1
    ora DWordBitSet_val, x
    jmp @Out
@Index8Clear:
    lda DWordBitSet_val, x
    and #$fe
    jmp @Out

@Index9:
    ldx #1
    lda DWordBitSet_set
    cmp #0
    bne @Index9Set
    bra @Index9Clear
@Index9Set:
    lda #$2
    ora DWordBitSet_val, x
    jmp @Out
@Index9Clear:
    lda DWordBitSet_val, x
    and #$fd
    jmp @Out

@Index10:
    ldx #1
    lda DWordBitSet_set
    cmp #0
    bne @Index10Set
    bra @Index10Clear
@Index10Set:
    lda #$4
    ora DWordBitSet_val, x
    jmp @Out
@Index10Clear:
    lda DWordBitSet_val, x
    and #$fb
    jmp @Out

@Index11:
    ldx #1
    lda DWordBitSet_set
    cmp #0
    bne @Index11Set
    bra @Index11Clear
@Index11Set:
    lda #$8
    ora DWordBitSet_val, x
    jmp @Out
@Index11Clear:
    lda DWordBitSet_val, x
    and #$f7
    jmp @Out

@Index12:
    ldx #1
    lda DWordBitSet_set
    cmp #0
    bne @Index12Set
    bra @Index12Clear
@Index12Set:
    lda #$10
    ora DWordBitSet_val, x
    jmp @Out
@Index12Clear:
    lda DWordBitSet_val, x
    and #$ef
    jmp @Out

@Index13:
    ldx #1
    lda DWordBitSet_set
    cmp #0
    bne @Index13Set
    bra @Index13Clear
@Index13Set:
    lda #$20
    ora DWordBitSet_val, x
    jmp @Out
@Index13Clear:
    lda DWordBitSet_val, x
    and #$df
    jmp @Out

@Index14:
    ldx #1
    lda DWordBitSet_set
    cmp #0
    bne @Index14Set
    bra @Index14Clear
@Index14Set:
    lda #$40
    ora DWordBitSet_val, x
    jmp @Out
@Index14Clear:
    lda DWordBitSet_val, x
    and #$bf
    jmp @Out

@Index15:
    ldx #1
    lda DWordBitSet_set
    cmp #0
    bne @Index15Set
    bra @Index15Clear
@Index15Set:
    lda #$80
    ora DWordBitSet_val, x
    jmp @Out
@Index15Clear:
    lda DWordBitSet_val, x
    and #$7f
    jmp @Out

@Index16:
    ldx #2
    lda DWordBitSet_set
    cmp #0
    bne @Index16Set
    bra @Index16Clear
@Index16Set:
    lda #$1
    ora DWordBitSet_val, x
    jmp @Out
@Index16Clear:
    lda DWordBitSet_val, x
    and #$fe
    jmp @Out

@Index17:
    ldx #2
    lda DWordBitSet_set
    cmp #0
    bne @Index17Set
    bra @Index17Clear
@Index17Set:
    lda #$2
    ora DWordBitSet_val, x
    jmp @Out
@Index17Clear:
    lda DWordBitSet_val, x
    and #$fd
    jmp @Out

@Index18:
    ldx #2
    lda DWordBitSet_set
    cmp #0
    bne @Index18Set
    bra @Index18Clear
@Index18Set:
    lda #$4
    ora DWordBitSet_val, x
    jmp @Out
@Index18Clear:
    lda DWordBitSet_val, x
    and #$fb
    jmp @Out

@Index19:
    ldx #2
    lda DWordBitSet_set
    cmp #0
    bne @Index19Set
    bra @Index19Clear
@Index19Set:
    lda #$8
    ora DWordBitSet_val, x
    jmp @Out
@Index19Clear:
    lda DWordBitSet_val, x
    and #$f7
    jmp @Out

@Index20:
    ldx #2
    lda DWordBitSet_set
    cmp #0
    bne @Index20Set
    bra @Index20Clear
@Index20Set:
    lda #$10
    ora DWordBitSet_val, x
    jmp @Out
@Index20Clear:
    lda DWordBitSet_val, x
    and #$ef
    jmp @Out

@Index21:
    ldx #2
    lda DWordBitSet_set
    cmp #0
    bne @Index21Set
    bra @Index21Clear
@Index21Set:
    lda #$20
    ora DWordBitSet_val, x
    jmp @Out
@Index21Clear:
    lda DWordBitSet_val, x
    and #$df
    jmp @Out

@Index22:
    ldx #2
    lda DWordBitSet_set
    cmp #0
    bne @Index22Set
    bra @Index22Clear
@Index22Set:
    lda #$40
    ora DWordBitSet_val, x
    jmp @Out
@Index22Clear:
    lda DWordBitSet_val, x
    and #$bf
    jmp @Out

@Index23:
    ldx #2
    lda DWordBitSet_set
    cmp #0
    bne @Index23Set
    bra @Index23Clear
@Index23Set:
    lda #$80
    ora DWordBitSet_val, x
    jmp @Out
@Index23Clear:
    lda DWordBitSet_val, x
    and #$7f
    jmp @Out

@Index24:
    ldx #3
    lda DWordBitSet_set
    cmp #0
    bne @Index24Set
    bra @Index24Clear
@Index24Set:
    lda #$1
    ora DWordBitSet_val, x
    jmp @Out
@Index24Clear:
    lda DWordBitSet_val, x
    and #$fe
    jmp @Out

@Index25:
    ldx #3
    lda DWordBitSet_set
    cmp #0
    bne @Index25Set
    bra @Index25Clear
@Index25Set:
    lda #$2
    ora DWordBitSet_val, x
    jmp @Out
@Index25Clear:
    lda DWordBitSet_val, x
    and #$fd
    jmp @Out

@Index26:
    ldx #3
    lda DWordBitSet_set
    cmp #0
    bne @Index26Set
    bra @Index26Clear
@Index26Set:
    lda #$4
    ora DWordBitSet_val, x
    jmp @Out
@Index26Clear:
    lda DWordBitSet_val, x
    and #$fb
    jmp @Out

@Index27:
    ldx #3
    lda DWordBitSet_set
    cmp #0
    bne @Index27Set
    bra @Index27Clear
@Index27Set:
    lda #$8
    ora DWordBitSet_val, x
    jmp @Out
@Index27Clear:
    lda DWordBitSet_val, x
    and #$f7
    jmp @Out

@Index28:
    ldx #3
    lda DWordBitSet_set
    cmp #0
    bne @Index28Set
    bra @Index28Clear
@Index28Set:
    lda #$10
    ora DWordBitSet_val, x
    jmp @Out
@Index28Clear:
    lda DWordBitSet_val, x
    and #$ef
    jmp @Out

@Index29:
    ldx #3
    lda DWordBitSet_set
    cmp #0
    bne @Index29Set
    bra @Index29Clear
@Index29Set:
    lda #$20
    ora DWordBitSet_val, x
    jmp @Out
@Index29Clear:
    lda DWordBitSet_val, x
    and #$df
    jmp @Out

@Index30:
    ldx #3
    lda DWordBitSet_set
    cmp #0
    bne @Index30Set
    bra @Index30Clear
@Index30Set:
    lda #$40
    ora DWordBitSet_val, x
    jmp @Out
@Index30Clear:
    lda DWordBitSet_val, x
    and #$bf
    jmp @Out

@Index31:
    ldx #3
    lda DWordBitSet_set
    cmp #0
    bne @Index31Set
    bra @Index31Clear
@Index31Set:
    lda #$80
    ora DWordBitSet_val, x
    jmp @Out
@Index31Clear:
    lda DWordBitSet_val, x
    and #$7f
    jmp @Out

@Out:
    sta DWordBitSet_val, x
    DWORD_STACK_PUSH DWordBitSet_val
    RETURN_ADDRESS_PUSH DWordBitSet_rAddr
    rts
.endproc

.segment "DATA"
DWordNegate_rAddr: .word 0
DWordNegate_val: .dword 0
DWordNegate_count: .byte 0

.segment "CODE"
.proc DWordNegate
    RETURN_ADDRESS_PULL DWordNegate_rAddr
    ; Read the DWORD from stack
    DWORD_STACK_PULL DWordNegate_val
    ; Negate the DWORD one byte at a time
    lda #4
    sta DWordNegate_count
@Loop:
    ldx DWordNegate_count
    dex
    stx DWordNegate_count
    lda DWordNegate_val, x
    pha
    jsr ByteNegate
    ; Pull the byte from stack and save in the variable
    pla
    ldx DWordNegate_count
    sta DWordNegate_val, x
    cpx #0
    bne @Loop
    ;Save return DWORD on stack
    DWORD_STACK_PUSH DWordNegate_val
    RETURN_ADDRESS_PUSH DWordNegate_rAddr
    rts
.endproc

.segment "DATA"
DWordShiftLeft_rAddr: .word 0
DWordShiftLeft_val: .dword 0
DWordShiftLeft_carry: .byte 0, 0, 0, 0

.segment "CODE"
.proc DWordShiftLeft
    RETURN_ADDRESS_PULL DWordShiftLeft_rAddr
    ; Retrieve the DWORD from the stack
    DWORD_STACK_PULL DWordShiftLeft_val
    ldx #0
@LoopShift:
    lda DWordShiftLeft_val, x
    asl
    php
    sta DWordShiftLeft_val, x
    plp
    bcs @CarryOn
    bra @CarryOff

@CarryOn:
    lda #1
    sta DWordShiftLeft_carry, x
    bra @Continue

@CarryOff:
    lda #0
    sta DWordShiftLeft_carry, x

@Continue:
    inx
    cpx #4
    bne @LoopShift
    ; Cycle through and add one to all the positions marked as carry
    ldy #0
    ; Start from 1st byte because the carry doesn't affect the 0th byte
    ldx #1
@LoopCarries:
    lda DWordShiftLeft_carry, y
    cmp #1
    beq @AddOne
    bra @Continue2

@AddOne:
    lda DWordShiftLeft_val, x
    inc
    sta DWordShiftLeft_val, x

@Continue2:
    iny
    inx
    cpx #4
    bne @LoopCarries
    ; Save the DWORD to stack
    DWORD_STACK_PUSH DWordShiftLeft_val
    RETURN_ADDRESS_PUSH DWordShiftLeft_rAddr
    rts
.endproc

.segment "DATA"
DWordShiftRight_rAddr: .word 0
DWordShiftRight_val: .dword 0
DWordShiftRight_carry: .byte 0, 0, 0, 0

.segment "CODE"
.proc DWordShiftRight
    RETURN_ADDRESS_PULL DWordShiftRight_rAddr
    ; Retrieve the DWORD from the stack
    DWORD_STACK_PULL DWordShiftRight_val
    ldx #0
@LoopShift:
    lda DWordShiftRight_val, x
    lsr
    php
    sta DWordShiftRight_val, x
    plp
    bcs @CarryOn
    bra @CarryOff

@CarryOn:
    lda #1
    sta DWordShiftRight_carry, x
    bra @Next

@CarryOff:
    lda #0
    sta DWordShiftRight_carry, x

@Next:
    inx
    cpx #4
    bne @LoopShift
    ; Cycle through and add 128 to all the positions marked as carry
    ldy #0
    ; Start from 1st byte because the carry doesn't affect the 0th byte
    ldx #1
@LoopCarries:
    lda DWordShiftRight_carry, y
    cmp #1
    beq @Add128
    bra @NextCarry

@Add128:
    lda DWordShiftRight_val, x
    clc
    adc #128
    sta DWordShiftRight_val, x

@NextCarry:
    iny
    inx
    cpx #3
    bne @LoopCarries
    ; Save the DWORD to stack
    DWORD_STACK_PUSH DWordShiftRight_val
    RETURN_ADDRESS_PUSH DWordShiftRight_rAddr
    rts
.endproc

.segment "DATA"
DWordCompare_rAddr: .word 0
DWordCompare_left: .dword 0
DWordCompare_right: .dword 0

.segment "CODE"
.proc DWordCompare
    RETURN_ADDRESS_PULL DWordCompare_rAddr
    ; Read the left parameter from stack
    DWORD_STACK_PULL DWordCompare_left
    ; Read the right parameter from stack
    DWORD_STACK_PULL DWordCompare_right
    ; Cycle through and compare each byte (starting at highest byte) until values don't match or we've finished the loop
    ldx #4
@LoopCompare:
    dex
    ; If the loop finish they're equal in value
    cpx #255
    beq @Equal
    lda DWordCompare_left, x
    cmp DWordCompare_right, x
    beq @LoopCompare
    ; Check if right is greater than accumulator (left).
    cmp DWordCompare_right, x
    bcc @GreaterIsRight
    ; Greater is left
    lda #255
    bra @Out
@GreaterIsRight:
    lda #1
    bra @Out
@Equal:
    lda #0
@Out:
    ; Store the result on stack
    pha
    RETURN_ADDRESS_PUSH DWordCompare_rAddr
    rts
.endproc

.segment "DATA"
DWordAdd_rAddr: .word 0
DWordAdd_left: .dword 0
DWordAdd_right: .dword 0
DWordAdd_bit: .byte 0
DWordAdd_carry: .byte 0
DWordAdd_s: .byte 0
DWordAdd_d: .byte 0
DWordAdd_bitArray: .byte 0, 0, 0, 0, 0, 0, 0, 0
DWordAdd_sum: .byte 0
DWordAdd_total: .dword 0

.segment "CODE"
.proc DWordAdd
    RETURN_ADDRESS_PULL DWordAdd_rAddr
    ; Read the DWORD left parameter from stack
    DWORD_STACK_PULL DWordAdd_left
    ; Read the DWORD right parameter from stack
    DWORD_STACK_PULL DWordAdd_right
    stz DWordAdd_carry
    ldx #0
@LoopAdd:
    ; Store out byte counter
    phx
    ; Set start bit at %00000001
    lda #1
    sta DWordAdd_bit
    ; Zero the bitArray
    ARRAY_ZERO DWordAdd_bitArray, 8
    ; Restore our byte counter
    plx
    ; Starting from the 0th bit
    ldy #0
@LoopBit:
    stz DWordAdd_s
    lda DWordAdd_left, x
    and DWordAdd_bit
    cmp #0
    bne @StoreSourOne
    bra @Continue

@StoreSourOne:
    lda #1
    sta DWordAdd_s

@Continue:
    stz DWordAdd_d
    lda DWordAdd_right, x
    and DWordAdd_bit
    cmp #0
    bne @StoreDestOne
    bra @Continue2

@StoreDestOne:
    lda #1
    sta DWordAdd_d

@Continue2:
    lda DWordAdd_s
    clc
    adc DWordAdd_d
    cmp #0
    beq @CarryNormal
    cmp #2
    beq @CarryNormal
    bra @CarryOpposite

@CarryNormal:
    lda DWordAdd_carry
    cmp #1
    beq @AddOne
    bra @AddZero

@CarryOpposite:
    lda DWordAdd_carry
    cmp #1
    beq @AddZero
    bra @AddOne

@AddOne:
    lda #1
    sta DWordAdd_bitArray, y
    bra @StoreCarry

@AddZero:
    lda #0
    sta DWordAdd_bitArray, y

@StoreCarry:
    lda DWordAdd_s
    clc
    adc DWordAdd_d
    cmp #2
    beq @StoreCarryOne
    clc
    adc DWordAdd_carry
    cmp #2
    beq @StoreCarryOne
    bra @StoreCarryZero

@StoreCarryOne:
    lda #1
    sta DWordAdd_carry
    bra @Continue3

@StoreCarryZero:
    stz DWordAdd_carry

@Continue3:
    ; Shift bit to the right and store it
    lda DWordAdd_bit
    asl
    sta DWordAdd_bit
    iny
    cpy #8
    bne @LoopBitHelper
    bra @Continue4

@LoopBitHelper:
    jmp @LoopBit

@Continue4:
    ; Time to store the bitArray as a single byte in to sum
    stz DWordAdd_sum
    lda #1
    sta DWordAdd_bit
    ldy #0
@StoreBitArray:
    lda DWordAdd_bitArray, y
    cmp #1
    beq @AddIt
    bra @Continue5

@AddIt:
    lda DWordAdd_bit
    clc
    adc DWordAdd_sum
    sta DWordAdd_sum

@Continue5:
    lda DWordAdd_bit
    asl
    sta DWordAdd_bit
    iny
    cpy #8
    bne @StoreBitArray
    ; Store the sum in the left variable location
    lda DWordAdd_sum
    sta DWordAdd_total, x
    ; Increment the byte counter
    inx
    cpx #4
    beq @Out
    jmp @LoopAdd
@Out:
    ; Store the DWORD return value on stack
    DWORD_STACK_PUSH DWordAdd_total
    RETURN_ADDRESS_PUSH DWordAdd_rAddr
    rts
.endproc

.segment "DATA"
DWordSubtract_rAddr: .word 0
DWordSubtract_left: .dword 0
DWordSubtract_right: .dword 0

.segment "CODE"
.proc DWordSubtract
    RETURN_ADDRESS_PULL DWordSubtract_rAddr
    ; Read the left parameter from stack
    DWORD_STACK_PULL DWordSubtract_left
    ; Read the right parameter from stack
    DWORD_STACK_PULL DWordSubtract_right
    ; Push the right argument back on stack
    DWORD_STACK_PUSH DWordSubtract_right
    ; Negate the DWORD (right argument)
    jsr DWordNegate
    ; Push the DWORD value one to stack
    DWORD_STACK_ONE
    ; Add one to it for two's compliment (right argument)
    jsr DWordAdd
    ; Store the left argument on stack (right one is already there)
    DWORD_STACK_PUSH DWordSubtract_left
    ; Add left and right together
    jsr DWordAdd
    RETURN_ADDRESS_PUSH DWordSubtract_rAddr
    rts
.endproc

.segment "DATA"
DWordMultiply_rAddr: .word 0
DWordMultiply_left: .dword 0
DWordMultiply_right: .dword 0
DWordMultiply_orig: .dword 0
DWordMultiply_i: .byte 0

.segment "CODE"
.proc DWordMultiply
    RETURN_ADDRESS_PULL DWordMultiply_rAddr
    ; Read the DWORD left parameter from stack
    DWORD_STACK_PULL DWordMultiply_left
    ; Read the DWORD right parameter from stack
    DWORD_STACK_PULL DWordMultiply_right
    ; Start from bit 0
    stz DWordMultiply_i
    ; Store the original right argument for later
    ARRAY_COPY DWordMultiply_orig, DWordMultiply_right, 4
    ; Zero the right argument
    DWORD_SET DWordMultiply_right, 0, 0, 0, 0
@Loop:
    DWORD_STACK_PUSH DWordMultiply_orig
    lda DWordMultiply_i
    pha
    jsr DWordBitGet
    pla
    cmp #0
    beq @LoopNext
    ; Add left and right together
    DWORD_STACK_PUSH DWordMultiply_right
    DWORD_STACK_PUSH DWordMultiply_left
    jsr DWordAdd
    DWORD_STACK_PULL DWordMultiply_right
@LoopNext:
    ; Shift the left argument left by one position
    DWORD_STACK_PUSH DWordMultiply_left
    jsr DWordShiftLeft
    DWORD_STACK_PULL DWordMultiply_left
    ; Increment our bit counter
    lda DWordMultiply_i
    inc
    sta DWordMultiply_i
    cmp #32
    beq @Out
    jmp @Loop
@Out:
    ; Store the total as the return value
    DWORD_STACK_PUSH DWordMultiply_right
    RETURN_ADDRESS_PUSH DWordMultiply_rAddr
    rts
.endproc

.segment "DATA"
DWordDivide_rAddr: .word 0
DWordDivide_left: .dword 0
DWordDivide_right: .dword 0
DWordDivide_res: .dword 0
DWordDivide_work: .dword 0
DWordDivide_status: .byte 0
DWordDivide_index: .byte 0

.segment "CODE"
.proc DWordDivide
    RETURN_ADDRESS_PULL DWordDivide_rAddr
    ; Read the left parameter from stack
    DWORD_STACK_PULL DWordDivide_left
    ; Read the right parameter from stack
    DWORD_STACK_PULL DWordDivide_right
    ; Zero the res value
    DWORD_SET DWordDivide_res, 0, 0, 0, 0
    ; Zero the work value
    DWORD_SET DWordDivide_work, 0, 0, 0, 0
    ; Check division by zero
    ; Store right as zero
    DWORD_STACK_ZERO
    ; Store left argument
    DWORD_STACK_PUSH DWordDivide_right
    ; Perform the comparison
    jsr DWordCompare
    ; Pull the return value from stack and check if right argument is equal to zero
    pla
    cmp #0
    beq @DivideByZero
    bra @Continue

@DivideByZero:
    jmp @Out

@Continue:
    ; Check if left argument is zero
    ; Store right as zero
    DWORD_STACK_ZERO
    ; Store left argument
    DWORD_STACK_PUSH DWordDivide_left
    ; Perform the comparison
    jsr DWordCompare
    ; Pull the return value from stack and check if left argument is equal to zero
    pla
    cmp #0
    beq @DivisionOfZero
    bra @Continue2

@DivisionOfZero:
    jmp @Out

@Continue2:
    ; Index contains our bit counter
    lda #31
    sta DWordDivide_index
@LoopDivide:
    ; Parameter 2 (DWORD)
    DWORD_STACK_PUSH DWordDivide_left
    ; Parameter 1 (the bit index)
    lda DWordDivide_index
    pha
    ; Get this bit's on/off status
    jsr DWordBitGet
    ; Get the status of that bit from stack and store it
    pla
    sta DWordDivide_status
    ; Parameter 3 (DWORD)
    DWORD_STACK_PUSH DWordDivide_work
    ; Set it to the same status (on/off)
    ; Parameter 2 (on/off)
    lda DWordDivide_status
    pha
    ; Parameter 1 (bit index)
    lda #0
    pha
    ; Set the bit
    jsr DWordBitSet
    ; Read the result DWORD
    DWORD_STACK_PULL DWordDivide_work
    ; Shift the result
    DWORD_STACK_PUSH DWordDivide_res
    jsr DWordShiftLeft
    DWORD_STACK_PULL DWordDivide_res
    ; Now it's time to call DWordCompare, by passing two DWORDs
    ; Parameter 2 (right)
    DWORD_STACK_PUSH DWordDivide_work
    ; Parameter 1 (left)
    DWORD_STACK_PUSH DWordDivide_right
    ; Call the comparison routine
    jsr DWordCompare
    ; Get the result from from comparison
    pla
    ; Is left greater than right?
    cmp #255
    beq @GreaterIsLeft
    bra @GreaterIsRight

@GreaterIsLeft:
    ; Shift the bits in DWordDivide_work 1 position to the left
    DWORD_STACK_PUSH DWordDivide_work
    ; Shift DWordDivide_work 1 position to the left
    jsr DWordShiftLeft
    ; Get back the result DWORD from the stack
    DWORD_STACK_PULL DWordDivide_work
    ; Restore our bit counter
    lda DWordDivide_index
    dec
    sta DWordDivide_index
    cmp #255
    beq @OutHelper
    jmp @LoopDivide

@OutHelper:
    jmp @Out

@GreaterIsRight:
    ; Parameter 3 (DWORD)
    DWORD_STACK_PUSH DWordDivide_res
    ; Parameter 2 (on/off). In this case it's on
    lda #1
    pha
    ; Parameter 1 (bit index)
    lda #0
    pha
    ; Call the routine DWordBitSet set the bit to on
    jsr DWordBitSet
    ; Pull the result
    DWORD_STACK_PULL DWordDivide_res
    ; We now need to call DWordSubtract
    ; Parameter 2 (right)
    DWORD_STACK_PUSH DWordDivide_right
    ; Parameter 1 (left)
    DWORD_STACK_PUSH DWordDivide_work
    ; Call the subtraction routine
    jsr DWordSubtract
    ; Shift the result on the stack left by one
    jsr DWordShiftLeft
    ; Retrieve the final result in to work
    DWORD_STACK_PULL DWordDivide_work
    ; Decrement out bit index counter
    lda DWordDivide_index
    dec
    sta DWordDivide_index
    cmp #255
    beq @Out
    jmp @LoopDivide
@Out:
    DWORD_STACK_PUSH DWordDivide_res
    RETURN_ADDRESS_PUSH DWordDivide_rAddr
    rts
.endproc

.segment "DATA"
DWordModulus_rAddr: .word 0
DWordModulus_left: .dword 0
DWordModulus_right: .dword 0
DWordModulus_res: .dword 0
DWordModulus_work: .dword 0
DWordModulus_status: .byte 0
DWordModulus_index: .byte 0

.segment "CODE"
.proc DWordModulus
    RETURN_ADDRESS_PULL DWordModulus_rAddr
    ; Read the left parameter from stack
    DWORD_STACK_PULL DWordModulus_left
    ; Read the right parameter from stack
    DWORD_STACK_PULL DWordModulus_right
    ; Zero the res value
    DWORD_SET DWordModulus_res, 0, 0, 0, 0
    ; Zero the work value
    DWORD_SET DWordModulus_work, 0, 0, 0, 0
    ; Check division by zero
    ; Store right as zero
    DWORD_STACK_ZERO
    ; Store left argument
    DWORD_STACK_PUSH DWordModulus_right
    ; Perform the comparison
    jsr DWordCompare
    ; Pull the return value from stack and check if right argument is equal to zero
    pla
    cmp #0
    beq @ModulusByZero
    bra @Continue

@ModulusByZero:
    jmp @Out

@Continue:
    ; Check if left argument is zero
    ; Store right as zero
    DWORD_STACK_ZERO
    ; Store left argument
    DWORD_STACK_PUSH DWordModulus_left
    ; Perform the comparison
    jsr DWordCompare
    ; Pull the return value from stack and check if left argument is equal to zero
    pla
    cmp #0
    beq @DivisionOfZero
    bra @Continue2

@DivisionOfZero:
    jmp @Out

@Continue2:
    ; Index contains our bit counter
    lda #31
    sta DWordModulus_index
@LoopModulus:
    ; Parameter 2 (DWORD)
    DWORD_STACK_PUSH DWordModulus_left
    ; Parameter 1 (the bit index)
    lda DWordModulus_index
    pha
    ; Get this bit's on/off status
    jsr DWordBitGet
    ; Get the status of that bit from stack and store it
    pla
    sta DWordModulus_status
    ; Parameter 3 (DWORD)
    DWORD_STACK_PUSH DWordModulus_work
    ; Set it to the same status (on/off)
    ; Parameter 2 (on/off)
    lda DWordModulus_status
    pha
    ; Parameter 1 (bit index)
    lda #0
    pha
    ; Set the bit
    jsr DWordBitSet
    ; Read the result DWORD
    DWORD_STACK_PULL DWordModulus_work
    ; Shift the result
    DWORD_STACK_PUSH DWordModulus_res
    jsr DWordShiftLeft
    DWORD_STACK_PULL DWordModulus_res
    ; Now it's time to call DWordCompare, by passing two DWORDs
    ; Parameter 2 (right)
    DWORD_STACK_PUSH DWordModulus_work
    ; Parameter 1 (left)
    DWORD_STACK_PUSH DWordModulus_right
    ; Call the comparison routine
    jsr DWordCompare
    ; Get the result from from comparison
    pla
    ; Is left greater than right?
    cmp #255
    beq @GreaterIsLeft
    bra @GreaterIsRight

@GreaterIsLeft:
    lda DWordModulus_index
    cmp #0
    beq @OutHelper
    ; Shift the bits in DWordModulus_work 1 position to the left
    DWORD_STACK_PUSH DWordModulus_work
    ; Shift DWordModulus_work 1 position to the left
    jsr DWordShiftLeft
    ; Get back the result DWORD from the stack
    DWORD_STACK_PULL DWordModulus_work
    ; Restore our bit counter
    lda DWordModulus_index
    dec
    sta DWordModulus_index
    jmp @LoopModulus

@OutHelper:
    jmp @Out

@GreaterIsRight:
    ; Parameter 3 (DWORD)
    DWORD_STACK_PUSH DWordModulus_res
    ; Parameter 2 (on/off). In this case it's on
    lda #1
    pha
    ; Parameter 1 (bit index)
    lda #0
    pha
    ; Call the routine DWordBitSet set the bit to on
    jsr DWordBitSet
    ; Pull the result
    DWORD_STACK_PULL DWordModulus_res
    ; We now need to call DWordSubtract
    ; Parameter 2 (right)
    DWORD_STACK_PUSH DWordModulus_right
    ; Parameter 1 (left)
    DWORD_STACK_PUSH DWordModulus_work
    ; Call the subtraction routine
    jsr DWordSubtract
    ; Retrieve the final result in to work
    DWORD_STACK_PULL DWordModulus_work
    lda DWordModulus_index
    cmp #0
    beq @Out
    ; Shift the result on the stack left by one
    DWORD_STACK_PUSH DWordModulus_work
    jsr DWordShiftLeft
    ; Retrieve the final result in to work
    DWORD_STACK_PULL DWordModulus_work
    ; Decrement out bit index counter
    lda DWordModulus_index
    dec
    sta DWordModulus_index
    jmp @LoopModulus
@Out:
    DWORD_STACK_PUSH DWordModulus_work
    RETURN_ADDRESS_PUSH DWordModulus_rAddr
    rts
.endproc

.segment "DATA"
DWordInc_rAddr: .word 0

.segment "CODE"
.proc DWordInc
    RETURN_ADDRESS_PULL DWordInc_rAddr
    ; Push one on to stack
    DWORD_STACK_ONE
    ; Add it with the incoming parameter
    jsr DWordAdd
    RETURN_ADDRESS_PUSH DWordInc_rAddr
    rts
.endproc

.segment "DATA"
DWordDec_rAddr: .word 0
DWordDec_val: .dword 0

.segment "CODE"
.proc DWordDec
    RETURN_ADDRESS_PULL DWordDec_rAddr
    ; Pull the incoming DWORD from stack
    DWORD_STACK_PULL DWordDec_val
    ; Push one on to stack (right argument)
    DWORD_STACK_ONE
    ; Push the DWORD back on to stack (left argument)
    DWORD_STACK_PULL DWordDec_val
    ; Subtract one and return
    jsr DWordSubtract
    RETURN_ADDRESS_PUSH DWordDec_rAddr
    rts
.endproc

.segment "DATA"
DWordToStr_rAddr: .word 0
DWordToStr_val: .dword 0
DWordToStr_numbers: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DWordToStr_minus: .byte 0
DWordToStr_i: .byte 0
DWordToStr_j: .byte 0
DWordToStr_r: .dword 1000000000
DWordToStr_storeZeros: .byte 0
DWordToStr_char: .byte 0
DWordToStr_numHit: .byte 0
DWordToStr_count: .byte 0

.segment "CODE"
.proc DWordToStr
    RETURN_ADDRESS_PULL DWordToStr_rAddr
    ; Read the val parameter from stack
    DWORD_STACK_PULL DWordToStr_val
    ; Read if we should store leading zeros
    pla
    sta DWordToStr_storeZeros
    ; Zero the global string
    ldx #0
    lda #0
    sta Global_string, x
    ; Zero the variables
    stz DWordToStr_minus
    stz DWordToStr_j
    ; Store 1000000000 in to r
    DWORD_SET DWordToStr_r, $3b, $9a, $ca, $0
    ; Test whether or not the sign bit is set on the value
    ldx #3
    lda DWordToStr_val, x
    and #128
    cmp #0
    beq @IsPositiveNumber
    ; incoming value is negative
    lda #1
    sta DWordToStr_minus
    ; Push the DWORD on to stack
    DWORD_STACK_PUSH DWordToStr_val
    ; Negate the DWORD
    jsr DWordNegate
    ; Push one to tack as left parameter (right parameter already on stack)
    DWORD_STACK_ONE
    ; Add one to two's compliment it
    jsr DWordAdd
    ; Retrieve the value from the stack
    DWORD_STACK_PULL DWordToStr_val

@IsPositiveNumber:
    ; Zero the numbers array
    ARRAY_ZERO DWordToStr_numbers, 10
    stz DWordToStr_i
@LoopMain:
    ; Push val and r to stack
    DWORD_STACK_PUSH DWordToStr_r
    DWORD_STACK_PUSH DWordToStr_val
    jsr DWordCompare
    pla
    cmp #0
    beq @BiggerIsVal
    cmp #255
    beq @BiggerIsVal
    jmp @Continue

@BiggerIsVal:
    ldx DWordToStr_j
    lda DWordToStr_numbers, x
    inc
    sta DWordToStr_numbers, x

    DWORD_STACK_PUSH DWordToStr_r
    DWORD_STACK_PUSH DWordToStr_val
    jsr DWordSubtract
    DWORD_STACK_PULL DWordToStr_val
    ; Check if val is negative
    DWORD_STACK_PUSH DWordToStr_val
    lda #31
    pha
    jsr DWordBitGet
    pla
    cmp #1
    beq @Continue

    DWORD_STACK_PUSH DWordToStr_r
    DWORD_STACK_PUSH DWordToStr_val
    jsr DWordCompare
    pla
    cmp #0
    beq @BiggerIsValHelper
    cmp #255
    beq @BiggerIsValHelper
    bra @Continue

@BiggerIsValHelper:
    jmp @BiggerIsVal

@Continue:
    ; Parameter 2 (10 on stack)
    DWORD_STACK_TEN
    ; Parameter 1 (DWORD on stack)
    DWORD_STACK_PUSH DWordToStr_r
    ; Make the division
    jsr DWordDivide
    ; Retrieve r from stack
    DWORD_STACK_PULL DWordToStr_r
    lda DWordToStr_j
    inc
    sta DWordToStr_j
    lda DWordToStr_i
    inc
    sta DWordToStr_i
    cmp #10
    bne @LoopMainHelper
    bra @Continue2

@LoopMainHelper:
    jmp @LoopMain

@Continue2:
    lda DWordToStr_minus
    cmp #1
    beq @StoreStrMinus

    stz DWordToStr_i
    lda DWordToStr_storeZeros
    cmp #0
    bne @StoreStr
    jmp @StoreStrNoZeros

@StoreStrMinus:
    ldx #0
    ; ASCII symbol "-"
    lda #45
    sta Global_string, x
    inx
    stx DWordToStr_i

@StoreStr:
    stz DWordToStr_j

@LoopStoreStr:
    ldx DWordToStr_j
    ; Get the next character from numbers
    lda DWordToStr_numbers, x
    clc
    ; Add the ASCII symbol "0"
    adc #48
    ; Store the accumulator containing the character we want to store in Global_string
    ; The character was taken from numbers array
    sta DWordToStr_char
    ; Calculate the offset for Global_string and place it in to X
    lda DWordToStr_j
    clc
    adc DWordToStr_i
    tax
    ; Get the accumulator back
    lda DWordToStr_char
    ; Store the character from accumulator in Global_string offset x
    sta Global_string, x
    lda DWordToStr_j
    inc
    sta DWordToStr_j
    cmp #10
    bne @LoopStoreStr

    ; Don't forget to add the string terminator
    lda DWordToStr_j
    clc
    adc DWordToStr_i
    tax
    lda #0
    sta Global_string, x

    bra @Out

@StoreStrNoZeros:
    stz DWordToStr_j
    stz DWordToStr_count
    lda #0
    sta DWordToStr_numHit

@LoopStoreStrNoZeros:
    ldx DWordToStr_j
    ; Get the next character from numbers
    lda DWordToStr_numbers, x
    cmp #0
    beq @CheckNumHit
    lda #1
    sta DWordToStr_numHit
    bra @Continue3

@CheckNumHit:
    lda DWordToStr_numHit
    cmp #1
    bne @NextLoop

@Continue3:
    lda DWordToStr_numbers, x
    clc
    ; Add the ASCII symbol "0"
    adc #48
    ; Store the accumulator containing the character we want to store in Global_string
    ; The character was taken from numbers array
    sta DWordToStr_char
    ; Calculate the offset for Global_string and place it in to X
    lda DWordToStr_j
    clc
    adc DWordToStr_i
    tax
    ; Store the character from accumulator in Global_string offset x
    lda DWordToStr_char
    ldx DWordToStr_count
    sta Global_string, x
    inx
    stx DWordToStr_count
@NextLoop:
    lda DWordToStr_j
    inc
    sta DWordToStr_j
    cmp #10
    bne @LoopStoreStrNoZeros
    ; Check we have at least one zero in the string
    ldx #0
    lda Global_string, x
    cmp #0
    beq @StoreZero
    ; Store the string terminator
    ldx DWordToStr_count
    lda #0
    sta Global_string, x
    bra @Out

@StoreZero:
    ldx #0
    lda #48
    sta Global_string, x
    inx
    lda #0
    sta Global_string, x
@Out:
    RETURN_ADDRESS_PUSH DWordToStr_rAddr
    rts
.endproc

.segment "DATA"
DWordToStrBinary_rAddr: .word 0
DWordToStrBinary_val: .dword 0
DWordToStrBinary_numbers: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
DWordToStrBinary_i: .byte 0
DWordToStrBinary_j: .byte 0

.segment "CODE"
.proc DWordToStrBinary
    RETURN_ADDRESS_PULL DWordToStrBinary_rAddr
    ; Read the val parameter from stack
    DWORD_STACK_PULL DWordToStrBinary_val
    ; Store the bits in numbers array
    lda #31
    sta DWordToStrBinary_i
    stz DWordToStrBinary_j
@Loop:
    DWORD_STACK_PUSH DWordToStrBinary_val
    lda DWordToStrBinary_i
    pha
    jsr DWordBitGet
    pla
    ldx DWordToStrBinary_j
    sta DWordToStrBinary_numbers, x
    inx
    stx DWordToStrBinary_j
    lda DWordToStrBinary_i
    dec
    sta DWordToStrBinary_i
    cmp #255
    bne @Loop
    ; Store the character indexes in Global_string
    ldx #0
@Store:
    ; Get the next character from numbers
    lda DWordToStrBinary_numbers, x
    clc
    ; Add the ASCII symbol "0"
    adc #48
    ; Store the character from accumulator in Global_string offset x
    sta Global_string, x
    inx
    cpx #32
    bne @Store
    ; Don't forget to add the string terminator
    lda #0
    sta Global_string, x
    RETURN_ADDRESS_PUSH DWordToStrBinary_rAddr
    rts
.endproc

.segment "DATA"
DWordFromStr_rAddr: .word 0
DWordFromStr_num: .dword 0
DWordFromStr_calc: .dword 0
DWordFromStr_base: .dword 0
DWordFromStr_i: .byte 0
DWordFromStr_byte: .byte 0
DWordFromStr_minus: .byte 0
DWordFromStr_index: .byte 0

.segment "CODE"
.proc DWordFromStr
    RETURN_ADDRESS_PULL DWordFromStr_rAddr
    DWORD_SET DWordFromStr_num, 0, 0, 0, 0
    DWORD_SET DWordFromStr_base, 0, 0, 0, 1
	stz DWordFromStr_i
    stz DWordFromStr_minus
    ; Loop through global string and ignore leading spacers
    stz DWordFromStr_index
@LoopSpace:
    ldx DWordFromStr_index
    lda Global_string, x
    ; Compare accumulator to space character
    cmp #32
    beq @LoopSpaceNext
    ; Compare accumulator to tab character
    cmp #9
    beq @LoopSpaceNext
    ; Compare accumulator to string terminator character
    cmp #0
    beq @OutHelper
    bra @Continue

@LoopSpaceNext:
    ; Increment index counter and check for maximum string limit breach
    lda DWordFromStr_index
    inc
    sta DWordFromStr_index
    cpx #255
    beq @OutHelper
    bra @LoopSpace

@OutHelper:
    jmp @Out

@Continue:
    ; Compare accumulator to "-" minus character
    ldx DWordFromStr_index
    lda Global_string, x
    cmp #45
    beq @StoreMinus
    bra @Continue2

@StoreMinus:
    lda #1
    sta DWordFromStr_minus
    lda DWordFromStr_index
    inc
    sta DWordFromStr_index

@Continue2:
    ; Get the Global_string length and subtract our starting index from it to get the actual length.
    ZP_STORE_PTR1 Global_string
    jsr StringLength
    pla
    ; Subtract the starting string index
    sec
    sbc DWordFromStr_index
    ; Store the last character index in to i (len - 1)
    dec
    sta DWordFromStr_i
@Loop:
    ldx DWordFromStr_i
    lda Global_string, x
    ; Check if accumulator is less than "0" character
    cmp #48
    bcc @OutHelper2
    ; Check if accumulator is greater than "9" character
    cmp #58
    bcs @OutHelper2
    bra @Continue3

@OutHelper2:
    jmp @Out

@Continue3:
    ; Subtract the "0" character from accumulator
    sec
    sbc #48
    sta DWordFromStr_byte
    ; Zero the calc and store "byte" to it's lowest position
    DWORD_SET DWordFromStr_calc, 0, 0, 0, 0
    ldx #0
    lda DWordFromStr_byte
    sta DWordFromStr_calc, x
    ; Multiply base and calc together
    DWORD_STACK_PUSH DWordFromStr_calc
    DWORD_STACK_PUSH DWordFromStr_base
    jsr DWordMultiply
    ; Add the multiplication result to num (already on stack)
    DWORD_STACK_PUSH DWordFromStr_num
    jsr DWordAdd
    DWORD_STACK_PULL DWordFromStr_num
    ; Multiply base by 10
    DWORD_STACK_TEN
    DWORD_STACK_PUSH DWordFromStr_base
    jsr DWordMultiply
    DWORD_STACK_PULL DWordFromStr_base
    ; Decrement our counter
    lda DWordFromStr_i
    dec
    sta DWordFromStr_i
    cmp #255
    beq @Out
    jmp @Loop
@Out:
    lda DWordFromStr_minus
    cmp #0
    beq @End
    ; Get the absolute value of num (non negative).
    DWORD_STACK_PUSH DWordFromStr_num
    jsr DWordNegate
    DWORD_STACK_ONE
    jsr DWordAdd
    DWORD_STACK_PULL DWordFromStr_num
@End:
    DWORD_STACK_PUSH DWordFromStr_num
    RETURN_ADDRESS_PUSH DWordFromStr_rAddr
    rts
.endproc
