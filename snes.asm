;----- Address Bus B Registers -------------------------
INIDISP      = $2100 ; Screen Display
;----- OAM Registers ------------------------------------
OBJSEL       = $2101 ; Object Size and Character Size
OAMADDL      = $2102 ; OAM Address Low
OAMADDH      = $2103 ; OAM Address High
OAMDATA      = $2104 ; OAM Data Write
;----- BG Registers -------------------------------------
BGMODE	     = $2105 ; BG Mode and Character Size
MOSAIC	     = $2106 ; Mosaic Register
BG1SC	     = $2107 ; BG 1 Tilemap Address and Size
BG2SC	     = $2108 ; BG 2 Tilemap Address and Size
BG3SC	     = $2109 ; BG 3 Tilemap Address and Size
BG4SC	     = $210a ; BG 4 Tilemap Address and Size
BG12NBA      = $210b ; BG 1, 2 CHR Address
BG34NBA      = $210c ; BG 3, 4 CHR Address
BG1HOFS	     = $210d ; BG1 Horizontal Scroll Registers
BG1VOFS	     = $210e ; BG1 Vertical Scroll Register
BG2HOFS	     = $210f ; BG2 Horizontal Scroll Registers
BG2VOFS	     = $2110 ; BG2 Vertical Scroll Register
BG3HOFS	     = $2111 ; BG3 Horizontal Scroll Registers
BG3VOFS	     = $2112 ; BG3 Vertical Scroll Register
BG4HOFS	     = $2113 ; BG4 Horizontal Scroll Registers
BG4VOFS	     = $2114 ; BG4 Vertical Scroll Register
;----- VRAM Registers -----------------------------------
VMAINC       = $2115 ; Video Port Control
VMADDL       = $2116 ; VRAM Address Low
VMADDH       = $2117 ; VRAM Address High
VMDATAL      = $2118 ; VRAM Data Low
VMDATAH      = $2119 ; VRAM Data High
;----- CGRAM Registers ----------------------------------
CGADD        = $2121 ; CGRAM Address
CGDATA       = $2122 ; CGRAM DATA WRITE
;------Main/Sub screen designations----------------------
TM           = $212c ; Main Screen Destination
TS	         = $212d ; Sub Screen Destination
;------Main/Sub screen designations----------------------
TMW          = $212e ; Window mask main screen
TSW	         = $212f ; Window mas sub screen
;----- SCREEN LATERS-------------------------------------
BG1          = $01
BG2          = $02
BG3          = $04
BG4          = $08
OBJ          = $10
;----- Internal CPU Registers ---------------------------
NMITIMEN     = $4200 ; Interrupt Enable
RDNMI        = $4210 ; Interrupt Flag
TIMEUP	     = $4211 ; Interrupt Flag
HVBJOY       = $4212 ; PPU Status
MDMAEN       = $420b ; DMA Enable Reg
;----- DMA0 Registers -----------------------------------
DMAP0	     = $4300 ; DMA Control
BBAD0 	     = $4301 ; DMA Destination ($21xx) (B Bus)
A1T0L        = $4302 ; DMA Source Address Low  (A Bus)
A1T0H        = $4303 ; DMA Source Address High (A Bus)
A1B0         = $4304 ; DMA Source Address Bank (A Bus)
DAS0L        = $4305 ; DMA Transfer Size Low
DAS0H        = $4306 ; DMA Transfer Size High
;----- DMA1 Registers -----------------------------------
DMAP1        = $4310 ; DMA1 DMA/HDMA Parameters                              1B/RW
BBAD1        = $4311 ; DMA1 DMA/HDMA I/O-Bus Address (PPU-Bus AKA B-Bus)     1B/RW
A1T1L        = $4312 ; DMA1 DMA/HDMA Table Start Address (Lower 8-Bit)       2B/RW
A1T1H        = $4313 ; DMA1 DMA/HDMA Table Start Address (Upper 8-Bit)       1B/RW
A1B1         = $4314 ; DMA1 DMA/HDMA Table Start Address (Bank)              1B/RW
DAS1L        = $4315 ; DMA1 DMA Count / Indirect HDMA Address (Lower 8-Bit)  2B/RW
DAS1H        = $4316 ; DMA1 DMA Count / Indirect HDMA Address (Upper 8-Bit)  1B/RW
DASB1        = $4317 ; DMA1 Indirect HDMA Address (Bank)                     1B/RW
A2A1L        = $4318 ; DMA1 HDMA Table Current Address (Lower 8-Bit)         2B/RW
A2A1H        = $4319 ; DMA1 HDMA Table Current Address (Upper 8-Bit)         1B/RW
NTRL1        = $431A ; DMA1 HDMA Line-Counter (From Current Table entr
;----- Joypad registers ---------------------------------
JOYS0        = $4218
JOYS1        = $421a
JOYS2        = $421c
JOYS3        = $421e
;----- Joypad buttons -----------------------------------
JOYTLEFT     = $0010 ; Right trigger
JOYTRIGHT    = $0020 ; Left trigger
JOYY         = $0040 ; Y button
JOYX         = $0080 ; X button
JOYRIGHT     = $0100 ; D-pad right
JOYLEFT      = $0200 ; D-pad left
JOYDOWN      = $0400 ; D-pad down
JOYUP        = $0800 ; D-pad up
JOYSTART     = $1000 ; Start
JOYSELECT    = $2000 ; Select
JOYB         = $4000 ; B button
JOYA         = $8000 ; A button
;----- ROM registers ------------------------------------
MEMSEL       = $420d
;----- MODE 7 registers ---------------------------------
M7SEL        = $211a
;----- BG screen sizes ----------------------------------
SCSIZE_32X32 = %00
SCSIZE_64X32 = %01
SCSIZE_32X64 = %10
SCSIZE_64X64 = %11
;----- BG map & character VRAM addresses ----------------
BG1MAPADDR   = $8000
BG2MAPADDR   = $8800
CHRADDR      = $0000
BG1CHRADDR   = CHRADDR
BG2CHRADDR   = CHRADDR
.define PPUADDR(addr) (addr / 2)
.define BGMAP(addr, size) ((((addr / 2) & $fc00) >> 8) | size)
.define BG12CHR(bg1addr, bg2addr) (((bg2addr / 2) >> 8) | ((bg1addr / 2) >> 12))
.define BG32CHR(bg3addr, bg4addr) (((bg4addr / 2) >> 8) | ((bg3addr / 2) >> 12))
;----- Joypad constants passed to SNESJoypadPressed ----
JOYPAD0 = 0
JOYPAD1 = 1
JOYPAD2 = 2
JOYPAD3 = 3

.segment "CODE"
.proc SNESInit
    ; Disabled interrupts
 	sei
 	; Clear carry to switch to native mode
 	clc
 	; Exchange carry & emulation bit. native mode
 	xce
 	; BG Mode 1, Char size 8x8 - BG1 16, BG2 16, BG3 4
	lda #1
	sta BGMODE
	; BG1 map address
    lda #BGMAP(BG1MAPADDR, SCSIZE_32X32)
    sta BG1SC
    ; BG2 map address
    lda #BGMAP(BG2MAPADDR, SCSIZE_32X32)
    sta BG2SC
    ; BG 1,2 character addresses
    lda #BG12CHR(BG1CHRADDR, BG2CHRADDR)
    sta BG12NBA
    ; Enable BG1 & OBJ display */
	lda #(BG1 | OBJ)
	sta TM
	stz TS
	stz TMW
	stz TSW
    stz M7SEL
    rts
.endproc

.macro SNESDelay amount
.local @SDLoop
    CPU_A8_XY16
.i16
    ldy #$ffff
@SDLoop:
    iny
    cpy #amount
    bne @SDLoop
    CPU_A8_XY8
.i8
.endmacro

.macro SNESCopyVRAM sour, dest, size, bank
	lda #$80
	sta VMAINC
	lda #<dest
	sta VMADDL
	lda #>dest
	sta VMADDH
	lda #$18
	sta BBAD0
	lda bank
	sta A1B0
 	lda #<sour
 	sta A1T0L
 	lda #>sour
 	sta A1T0H
    CPU_A8_XY16
.i16
	ldy #size
	sty DAS0L
    CPU_A8_XY8
.i8
	lda #1
	sta DMAP0
	sta MDMAEN
.endmacro

.macro SNESCopyCGRAM sour, dest, size, bank
	lda bank
	sta A1B0
	lda #<sour
	sta A1T0L
	lda #>sour
	sta A1T0H
    CPU_A8_XY16
.i16
	ldy #size
	sty DAS0L
    CPU_A8_XY8
.i8
	lda #dest
	sta CGADD
	lda #$22
	sta BBAD0
	stz DMAP0
	lda #1
	sta MDMAEN
.endmacro

.segment "DATA"
SNESCopyVRAMCPU_bankOld: .byte 0

.macro SNESCopyVRAMCPU sour, dest, size, bank
.local @Loop
    phb
    pla
    sta SNESCopyVRAMCPU_bankOld
    lda bank
    pha
    plb
    lda #$80
    sta VMAINC
    lda #<dest
    stz VMADDL
    lda #>dest
    sta VMADDH
    CPU_A8_XY16
.i16
    ldy #0
@Loop:
    lda sour, y
    sta VMDATAL
    iny
    lda sour, y
    sta VMDATAH
    iny
    cpy #size
    bne @Loop
    CPU_A8_XY8
.i8
    lda SNESCopyVRAMCPU_bankOld
    pha
    plb
.endmacro

.segment "DATA"
SNESCopyCGRAMCPU_bankOld: .byte 0

.macro SNESCopyCGRAMCPU sour, dest, size, bank
.local @Loop
    phb
    pla
    sta SNESCopyCGRAMCPU_bankOld
    lda bank
    pha
    plb
    lda #dest
    sta CGADD
    ldy #0
@Loop:
    lda sour, y
    sta CGDATA
    inx
    lda sour, y
    sta CGDATA
    iny
    cpy #size
    bne @Loop
    lda SNESCopyCGRAMCPU_bankOld
    pha
    plb
.endmacro

.macro SNESWaitHVBlankJoy
.local @Again
@Again:
    lda HVBJOY
    and #1
    cmp #0
    bne @Again
.endmacro

.macro SNESJoypadClear
    CPU_A16_XY16
.a16
.i16
    lda #0
    sta Global_joypad0
    sta Global_joypad1
    sta Global_joypad2
    sta Global_joypad3
    CPU_A8_XY8
.a8
.i8
.endmacro

.macro SNESJoypadUpdate
   ; SNESWaitHVBlankJoy
    CPU_A16_XY16
.a16
.i16
    lda JOYS0
    ora Global_joypad0
    sta Global_joypad0
    lda JOYS1
    ora Global_joypad1
    sta Global_joypad1
    lda JOYS2
    ora Global_joypad2
    sta Global_joypad2
    lda JOYS3
    ora Global_joypad3
    sta Global_joypad3
    CPU_A8_XY8
.a8
.i8
.endmacro

.segment "DATA"
SNESJoypadPressed_rAddr: .word 0
SNESJoypadPressed_padNo: .byte 0
SNESJoypadPressed_btID: .word 0

.segment "CODE"
.proc SNESJoypadPressed
    RETURN_ADDRESS_PULL SNESJoypadPressed_rAddr
    pla
    sta SNESJoypadPressed_padNo
    WORD_STACK_PULL SNESJoypadPressed_btID
    WORD_REVERSE SNESJoypadPressed_btID
    lda SNESJoypadPressed_padNo
    cmp #JOYPAD0
    beq @Joypad0
    cmp #JOYPAD1
    beq @Joypad1
    cmp #JOYPAD2
    beq @Joypad2
    ; Defaults to joypad 3
    bra @Joypad3
@Joypad0:
    CPU_A16_XY16
.a16
.i16
    lda Global_joypad0
    and SNESJoypadPressed_btID
    cmp #0
    beq @NotPressed
    bra @Pressed
@Joypad1:
    CPU_A16_XY16
.a16
.i16
    lda Global_joypad1
    and SNESJoypadPressed_btID
    cmp #0
    beq @NotPressed
    bra @Pressed
@Joypad2:
    CPU_A16_XY16
.a16
.i16
    lda Global_joypad2
    and SNESJoypadPressed_btID
    cmp #0
    beq @NotPressed
    bra @Pressed
@Joypad3:
    CPU_A16_XY16
.a16
.i16
    lda Global_joypad3
    and SNESJoypadPressed_btID
    cmp #0
    beq @NotPressed
    bra @Pressed
@NotPressed:
    CPU_A8_XY8
.a8
.i8
    lda #0
    bra @Out
@Pressed:
    CPU_A8_XY8
.a8
.i8
    lda #1
@Out:
    pha
    RETURN_ADDRESS_PUSH SNESJoypadPressed_rAddr
    rts
.endproc

SPCPrg:
SPCPrgEnd:

SPC_LENGTH = SPCPrgEnd-SPCPrg
NUM_SPC_BLOCKS = SPC_LENGTH/256
.define copyAddr $0 ;address to copy to (word)
.define blockIndex $2 ;what block's being copied (byte)
.define copyIndex $3 ;index within one block (byte)
.define kick $4 ;current "kick" val

.segment "CODE"
.proc SNESLoadSPC
    CPU_A16_XY16
.a16
.i16
	lda #NUM_SPC_BLOCKS
	lda #$200
	sta copyAddr ;set up copy address
	stz blockIndex
    CPU_A8_XY8
.a8
.i8
	lda #$cc ;starting kick val
	sta kick

	stz $4200
	sei ;disable interrupts, this is kinda time sensitive
WaitForInit:
	lda $2140
	cmp #$aa ;spc sets reg 0 to aa after it inits
	bne WaitForInit

CopyLoop:
	CPU_A16_XY16
.a16
.i16
	lda copyAddr
	sta $2142 ;write destination address
	clc
	adc #$100
	sta copyAddr
    CPU_A8_XY8
.a8
.i8
	lda #$1
	sta $2141 ;write command
	lda kick
	sta $2140 ;"enable"
WaitForAck: ;spc returns kick when it's ready to write
	lda $2140
	cmp kick
	bne WaitForAck

CopyBlock: ;copies blocks of 256 bytes
	CPU_A16_XY16
.a16
.i16
	lda blockIndex ;because blockIndex is next to copyIndex in memory hopefully
	xba			   ;this will get the address (look at me, so smart for making blocks 256 bytes)
	tax
    CPU_A8_XY8
.a8
.i8
	lda #6;f:SPCPrg,x ;specify bank
	sta $2141
	lda copyIndex
	sta $2140

WaitReceive:
	cmp $2140 ;spc mirrors count after receiving data
	bne WaitReceive
	inc a
	sta copyIndex
	cmp #$0 ;256 bytes in a block
	bne CopyBlock

	inc blockIndex
	lda kick
	clc
	adc #$2
	and #$7f ;kick=previous kick "+2 to 127" -ninty
	sta kick
	lda blockIndex
	cmp #NUM_SPC_BLOCKS
	bne CopyLoop
	CPU_A16_XY16
.a16
.i16
	lda #$200 ;entry point
	sta $2142
    CPU_A8_XY8
.a8
.i8
	stz $2141 ;start command
	lda kick
	sta $2140
	cli ;enable interrupts
	rts
.endproc
