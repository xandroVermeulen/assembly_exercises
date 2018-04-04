$include (c8051f120.inc)

cseg at 0000h
	jmp main
cseg at 0080h


; A * 62 = a*64-a*2
main:
	clr EA
	mov WDTCN, #0DEh
	mov wDTCN, #0ADh
	setb EA

	mov A, #147d ; Dummy-waarde
	push ACC     ; 147 op de stack //zodaje oorspronkelijke waarde hebt bij substract
	mov B, #00d;start waarde B
	mov R2, #6d;2^6 = 64  maal 64 doen 



	; A * 64
	multiply:;per cycle macht 2 hoger
		rlc A;147 naar links rotaten
		push ACC;gedraaide stuff op acc pushen
		mov A, B;b in A steken
		rlc A;B draaien via A; carry bit komt nu helemaal rechts bij B te staan, dus ge hebt 16 bit shizzle
		mov B, A;B terug op zen plek zetten
		pop ACC;;A terug op zen plek 
		djnz R2, multiply;6 cycles in dit geval


	; -(A * 2)
	pop 03h ; R3 = 147 oorspronkelijke waarde op R3 zetten
	mov R2, #2d
	subtract:;R2 keer 147 aftrekken van resultaat
		subb A, R3;eindresultaat vorige - 147
		push ACC;ff bijhouden
		mov A, B;eerste 8 bit 
		subb A, #00d;sub with borrow!! dus aje 0 aftrekt doe je eigenlijk a=a-0-carry
		mov B, A;;b terug op zen plek zetten
		pop ACC;a terug op plek zetten
		djnz R2, subtract;2 keer doen

