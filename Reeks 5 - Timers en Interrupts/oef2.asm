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

	mov P1MDOUT, #80h
	mov SFRPAGE, #00h

	mov TMOD, #00000001b  ; Timer 0 is een 16-bit timer 
	mov CKCON, #00000000b ; Timer 0 gebruikt systeemklok / 12
	mov TH0, #06h
	mov TL0, #0C5h
	mov TH1, #-85d
	mov TL1, #-85d

	setb TR0   ; Om de 250 ms
	setb TR1   ; Toongenerator


ISR_TR0:
	clr TR0
	mov TH0, #06h
	mov TL0, #0C5h
	setb TR0
	cpl C
	jnc hoog
	jc laag
	reti

ISR_TR1:
	cpl P1.7
	reti

hoog:
	mov TH1, #-85d
	mov TL1, #-85d

laag:
	mov TH1, #-170d
	mov TL1, #-170d





