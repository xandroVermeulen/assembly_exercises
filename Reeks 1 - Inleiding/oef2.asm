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
	mov P1MDOUT, #40h

flicker:
	cpl P1.6
	mov R2, #255d
	mov R3, #255d
	loop:
		djnz R3, $
		djnz R2, loop
	jmp flicker

	
	
