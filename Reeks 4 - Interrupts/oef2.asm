$include (c8051f120.inc)

cseg at 0000h
	jmp main
cseg at 0003h
	jmp ISR_INT0
cseg at 0080h

main:
	clr EA
	mov WDTCN, #0DEh
	mov WDTCN, #0ADh
	setb EA
	setb EX0
	mov SFRPAGE, #0Fh
	mov XBR2, #40h
	mov XBR1, #04h

	mov P0MDOUT, #00010000b
	mov P1MDOUT, #01000000b
	clr P0.4
	clr P1.6
	mov R2, #00d
	jmp $

ISR_INT0
	inc R2
	mov R3, #255d
	loop: 
		mov R4, #255d
		djnz R4, $
		djnz R3, loop


	cjne R2, #10d, return
	setb P1.6

return: reti