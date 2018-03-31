$include (c8051f120.inc)

cseg at 0000h
	jmp main
cseg at 0003h
	jmp ISR_START
cseg at 000Bh
	jmp ISR_TIMER
cseg at 0013h
	jmp ISR_STOP
cseg at 0080h

main:
	clr EA
	mov WDTCN, #0DEh
	mov WDTCN, #0ADh
	setb EA
	setb EX0
	setb ET0
	mov SFRPAGE, #0Fh
	mov XBR2, #40h

	//toetsenbord
	mov P0MDOUT, #10h //(0001 0000b) p0.4

	//segmentdisplay
	mov P1MDOUT, #0FFh
	mov P2MDOUT, #0FFh
	mov P3MDOUT, #0FFh
	mov P4MDOUT, #0FFh

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
   mov TMOD, #02h
   mov CKCON, #02h
   mov TH0, #-64d
   mov TL0, #-64d


   jmp $

ISR_START:
	setb EX1
	setb TR0
	clr EX0
   mov R2, #0d
	mov R3, #0d
	mov R4, #0d
	mov R5, #0d
	mov P0MDOUT, #20h
	
	reti

ISR_TIMER:
	inc R2
	cjne R2, #10d , return
	mov R2, #0d

	inc R3
	cjne R3, #10d , return
	mov R3, #0d

	inc R4
	cjne R4, #10d , return
	mov R4, #0d

	inc R5
	cjne R5, #10d , return
	mov R5, #0d


return: reti


ISR_STOP:
	clr EX1
	mov P0MDOUT, #10h
	jmp write
	setb EX0
	clr TR0
	reti

write:
	mov A, #20h

	add R2, A
	mov R0, R2
	mov P3, @R0

	add R3, A
	mov R0, R3
	mov P2, @R0

	add R4, A
	mov R0, R4
	mov P1, @R0

	add R5, A
	mov R0, R5
	mov P0, @R0