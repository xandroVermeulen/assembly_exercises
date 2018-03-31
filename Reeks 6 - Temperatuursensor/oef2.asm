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

  mov P0MDOUT, #FFh
  mov P1MDOUT, #FFh
  mov P2MDOUT, #FFh
  mov P3MDOUT, #FFh

  ; Patronen voor segmentdisplay
  mov 20h, #00111111b
  mov 21h, #00000110b
  mov 22h, #01011011b
  mov 23h, #01001111b
  mov 24h, #01100110b
  mov 25h, #01101101b
  mov 26h, #01111101b
  mov 27h, #00000111b
  mov 28h, #01111111b
  mov 29h, #01101111b

  mov REF0CN, #07h ; Internal Temperature Sensor On | Internal Bias Generator On | Internal Reference Buffer On

  mov R2, #255d
  delay:
    mov R3, #255d
    djnz R3, $
    djnz R2, delay

  mov AMX0CF, #00h ; Rij 0000
  mov AMX0SL, #08h ; Kolom 1xxx

  jmp conversion
  jmp print_temperature

  jmp $

conversion:
  clr AD0INT
  setb AD0EN
  setb AD0BUSY
  jnb AD0INT, $
  clr AD0INT


print_temperature:
  ; T = 15 + (ADC0L - 64h) / 5
  mov A, ADC0L
  subb A, #64h
  mov B, #5d
  div AB

  mov R2, B ; R2 = kommagetallen

  add A, #15d
  mov B, #10d

  div AB 
  mov R4, A ; Tientallen
  mov R3, B ; Eenheden

  mov A, R2 
  rl A
  mov R2, A ; decimaal


  mov A, #20h
  add A, R4
  mov R0, A
  mov P0, @R0

  mov A, #20h
  add A, R3
  mov R0, A
  mov P1, @R0

  mov A, #20h
  add A, R3
  mov R0, A
  mov P2, @R0





  


  