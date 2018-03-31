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


loop:
	;NAND
	mov A, P5
	rl A
	anl A, P1
	cpl A 
	push ACC;;word later B

	;OR
	mov A, 22H
	rr A
	rr A
	rr A
	rr A
	rr A
   orl A, P2

   pop B
   anl A, B

   jb ACC.1, continue
   clr P4.7
   jmp loop


continue:
	setb P4.7
	jmp loop