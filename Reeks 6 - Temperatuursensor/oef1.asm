$include (c8051f120.inc)

cseg at 0000h
  jmp main
cseg at 0080h
main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA

  mov REF0CN, #07h ; Internal Temperature Sensor On | Internal Bias Generator On | Internal Reference Buffer On


  ; Dubbele vertragingslus om condensator op te laden
  mov R3, #255d
  delay:
    mov R2, #255d
    djnz R2, $
    djnz R3, delay

  mov AMX0CF, #00h ; Rij 0000
  mov AMX0SL, #08h ; Kolom 1xxx

  setb AD0EN
  clr AD0INT
  setb AD0BUSY
  jnb AD0INT, $
  clr AD0INT


  jmp $