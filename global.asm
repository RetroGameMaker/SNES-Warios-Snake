.define TILES_HORZ 32
.define TILES_VERT 32

.define LEFT 0
.define RIGHT 1
.define UP 2
.define DOWN 3

.define TILE_SNAKE 32
.define TILE_FOOD 33

.define TILE_EMPTY 0
.define TILE_FULL 1

.define TRUE 1
.define FALSE 0

.define PHASE_INIT 0
.define PHASE_LOGO 10
.define PHASE_INITGAME 20
.define PHASE_MOVE 30
.define PHASE_COLLIDE 40
.define PHASE_NEXTLEVEL 50

.define BLINK_COUNT 10

.define LEVEL_FOOD_COUNT 12

.segment "DATA"
Global_string: .byte "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
Global_spritesX: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Global_spritesY: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Global_spriteTiles: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Global_spriteFlags: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
Global_fontChars: .byte " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0
Global_fontNumChars: .byte 37
Global_fontStartIndex: .byte 63
Global_foodX: .byte 0
Global_foodY: .byte 0
Global_foodDraw: .byte FALSE
; Snake can have a maximum of 256 length [0..255]
Global_snakeLength: .byte 0
Global_snakeX: .byte "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
Global_snakeY: .byte "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
Global_snakeTileBelow: .byte "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
Global_snakeHeadX: .byte 0
Global_snakeHeadY: .byte 0
Global_snakeTailX: .byte 0
Global_snakeTailY: .byte 0
Global_snakeDraw: .byte 0
Global_snakeBlinked: .byte 0
Global_snakeLives: .byte 3
Global_points: .dword 0
Global_level: .word 0
; Include an empty 2kb file in to the data segment
Global_map: .incbin "data/2kb.txt"
; Include an empty 1kb file in to the data segment
Global_collision: .incbin "data/1kb.txt"
Global_snakeDirection: .byte DOWN
Global_phase: .word PHASE_LOGO
Global_levelFoodEaten: .byte 0
Global_temp: .byte 0
Global_joypad0: .word 0
Global_joypad1: .word 0
Global_joypad2: .word 0
Global_joypad3: .word 0

