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

  	mov SFRPAGE, #00h

  	mov TMOD, #01h
  	mov CKCON, #02h
  	mov TH0, #06h
  	mov TL0, #0C5h
  	//hours
  	mov R2, #00d
  	mov R3, #00d
  	//minutes
  	mov R4, #00d
  	mov R5, #00d
  	//seconds
  	mov R6, #00d
  	mov R7, #00d
  	//
  	mov A, #20h
  	setb TR0

start:
	jnb TF0, $
	clr TR0
	clr TF0
	mov TH0, #06h
  	mov TL0, #0C5h
  	setb TR0

  	inc R7
  	cjne R7, #10d, $
  	mov R7, #00d

  	inc R6
  	cjne R6, #06d, $
  	mov R6, #00d

  	inc R5
  	cjne R5, #10d, write
  	mov R5, #00d

  	inc R4
  	cjne R4, #06d, write
  	mov R4, #00d

  	inc R3
  	cjne R3, #10d, write
  	mov R3, #00d

  	inc R2
  	cjne R2, #02d, write
  	mov R2, #00d



write:
	add R5, A
	mov R0, R5
	mov P3, @R0

	add R4, A
	mov R0, R4
	mov P2, @R0

	add R3, A
	mov R0, R3
	mov P1, @R0

	add R2, A
	mov R0, R2
	mov P0, @R0

	jmp start
