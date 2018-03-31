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

	mov C, P5.0
	anl C, P1.1
	cpl C
	mov F0, C

	mov C, 22H.6
	orl C, P2.1

	anl C, F0
	mov P4.7, C

	jmp $
