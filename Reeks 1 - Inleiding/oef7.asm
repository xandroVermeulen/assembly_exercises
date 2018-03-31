$include (c8051f120.inc)

cseg at 0000h
  jmp main
cseg at 0080h

main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA
  mov SFRPAGE, #0Fh
  mov XBR2, #40h
  mov P1MDOUT, #0FFh
  mov A, #1d
  clr C
start:
  mov P1, A
  jnb P3.7, pressed
  jmp start

pressed:
  cpl C
  jc rotate_right
  jmp rotate_left
rotate_right:
  rr A
  jmp start
rotate_left:
  rl A
  jmp start
