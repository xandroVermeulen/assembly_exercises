$include (c8051f120.inc)

cseg at 0000h
  jmp main
cseg at 0080h

main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA

  mov A, #56d
  push ACC
  mov A, #16d
  push ACC

  call multiply

  mov SP, #07h
  jmp $

multiply:
  push 00h
  mov R0, SP
  dec R0
  dec R0
  dec R0
  mov A, @R0
  dec R0
  mov B, @R0
  mul AB
  pop 00h
  ret
