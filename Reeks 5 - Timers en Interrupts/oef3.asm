$include (c8051f120.inc)


cseg at 0000h
	jmp main
cseg at 0003h
	jmp ISR_INT0   ; External Interrupt 0   | Starten alarm
cseg at 000Bh
	jmp ISR_TR0    ; Timer 0 Overflow       | Starten timer afwisseling
cseg at 0013h
	jmp ISR_INT1   ; External Interrupt 1   | Stoppen alarm
cseg at 001Bh
	jmp ISR_TR1    ; Timer 1 Overflow       | Wisselen geluidssignaal
cseg at 0080h


main:
	clr EA
	mov WDTCN, #0DEh
	mov WDTCN, #0ADh
	setb EA
	setb EX0
	mov SFRPAGE, #0Fh
	mov XBR2, #40h      ; Crossbar aanzetten
	mov XBR1, #12h      ; INT0 en INT1 naar buiten brengen
	mov P0MDOUT, #0h    ; P0.0 en P0.4
	mov P1MDOUT, #80h   ; P1.7


	mov TMOD, #21h      ; Timer 0 = 16-bit counter | Timer 1 = 8-bit counter met autoreload
	mov CKCON, #00h     ; Timer 0 en Timer 1 maken gebruik van de systeemklok gedeeld door 12
	mov TH0, #06h
	mov TL0, #0C5h
	mov TH1, #-85d
	mov TL1, #-85d

	jmp $

ISR_INT0: ; Er werd op de startknop gedrukt en het alarm zal starten
	clr EX0   ; INT0 interrupt uitschakelen
	setb ET0  ; Timer 0 interrupt inschakelen
	setb ET1  ; Timer 1 interrupt inschakelen
	setb EX1  ; INT1 interrupt inschakelen
	setb TR0  ; Timer 0 starten
	setb TR1  ; Timer 1 starten
	reti


ISR_INT1: ; Er werd op de stopknop gedrukt en het alarm zal stoppen
	clr TR0
	clr TR1
	clr EX1
	reti


ISR_TR0:  ; Het alarm moet om de 250ms veranderen van geluidsgolf
	clr TR0
	mov TH0, #06h
	mov TL0, #0C5h
	setb TR0
	jc hoog
	jnc laag
	reti

hoog:
	mov TH1, #-85d
	mov TL1, #-85d

laag:
	mov TH1, #-170d
	mov TL1, #-170d

ISR_TR1:  ; moeje ni her instellen want autoreload staat aan, blijft dat doen
	cpl P1.7
	reti






