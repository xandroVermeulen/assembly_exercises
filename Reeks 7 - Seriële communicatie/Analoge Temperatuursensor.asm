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
	mov XBR0, #04h ; UART0 TX routed to P0.0, and RX routed to P0.1

	mov REF0CN, #03h ; Internal Bias Generator On | Internal Reference Buffer On

	mov R3, #255d
	delay:
		mov R4, #25d
		djnz R4, $
		djnz R3, delay

	mov AMX0CN, #00h ; Kolom 0000
	mov AMX0CF, #00h ; Rij 0000


	setb AD0EN;conversie klaarzetten

start:
	clr AD0INT;interrupt clearen
	setb AD0BUSY;conversie starten
	jnb AD0INT, $;wachten tot klaar is
	clr AD0INT;interrupt clearen
	mov A, ADC0L;de temp
	mov B, ADC0H

	mov SFRPAGE, #00h;8bit timer met autoreload;ZIE PAGINA 265
	mov TMOD, #20h
	mov CKCON, #10h
	mov TH1, #236d
	mov TL1, #236d

	mov SCON0, #40h;271, 8 bit baud
	mov SSTA0, #10h;baud raud divide disabled;272

	cjne SBUF0, #30h, $;273;waarde die pc wegschrijft naar sbuf0 vo wnr je moe beginnen
	mov SBUF0, A
	jnb TI0, $;transmit interrupt flag;wachten tot transmission gedaan is
	clr TI0

	cjne SBUF0, #31h, $
	mov SBUF0, B
	jnb TI0, $
	clr TI0