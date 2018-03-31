$include (c8051f120.inc)

cseg at 0000h
	jmp main
cseg at 000Bh
	jmp ISR_TR0
cseg at 001Bh
	jmp ISR_TR1
cseg at 0080h

main:
	clr EA
	mov WDTCN, #0DEh
	mov WDTCN, #0ADh
	setb EA
	setb ET2
	mov SFRPAGE, #0Fh
	mov XBR2, #40h
	mov P0MDOUT, #0C0h

	//296
	mov SFRPAGE, #00h
	mov TMOD, #12h
	mov CKCON, #18h
	mov TH0, #-219d
	mov TL0, #-219d
	mov TH1, #0F4h
	mov TL1, #09h

	setb TR0
	setb TR1

	jmp $

ISR_TR0:
	cpl P1.7
	reti
ISR_TR1:
	clr TR1
	mov TH1, #0F4h
	mov TL1, #09h
	setb TR1
	cpl P1.6
	reti

