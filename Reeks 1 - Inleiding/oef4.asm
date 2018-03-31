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
	
start:
	mov A, #0d
	mov R4, #1d
	mov R2, #255d
	loop:
		mov R3, #255d
		djnz R3, $
		djnz R2, loop
	jnb P3.7, pressed
	jmp start
	
pressed:
	add A, #1d
	cjne A, R4, start
	
	

flicker:
	cpl P1.6
	mov R2, #255d
	loop:
		mov R3, #255d
		djnz R3, $
		djnz R2, loop
	jmp pressed	
	
	
