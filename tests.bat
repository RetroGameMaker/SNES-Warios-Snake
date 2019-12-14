del tests.o
ca65 --cpu 65816 -o tests.o tests.asm
ld65 -C memmap.cfg tests.o -o tests.sfc
C:\Users\mserb\Downloads\snes9x-1.60-win32-x64\snes9x-x64.exe "C:\rgm\SNES Programming - Part 03 [Wario's Snake]\code\tests.sfc"
