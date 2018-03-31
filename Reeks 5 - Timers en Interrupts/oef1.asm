$include (c8051f120.inc)

cseg at 0000h
	jmp main
cseg at 000Bh
	jmp ISR_TR0
cseg at 0080h


main:
	clr EA
	mov WDTCN, #0DEh
	mov WDTCN, #0ADh
	setb EA
	mov SFRPAGE, #0Fh
	mov XBR2, #40h
	mov P1MDOUT, #80h

	; TIMER
	mov SFRPAGE, #00h
	mov TMOD, #02h     ; Mode 2 : 8-bit counter met autoreload
	mov CKCON, #00h    ; Timer 0 gebruikt systeemklok / 12
	mov TH0, #-255d     
	mov TL0, #-255d
	setb TR0
	jmp $

ISR_TR0:
	cpl P1.7
	reti