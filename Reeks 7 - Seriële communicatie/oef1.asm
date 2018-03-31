$include (c8051f120.inc)

cseg at 0000h
	jmp main
cseg at 0080h

main:
	clr EA
	mov WDTCN, #0DEh
	mov WDTCN, #0ADh
	setb EA	

	mov SFRPAGE, #0Fh ; Pagina F voor XBR0
	mov XBR0, #04h ; UART0 TX routed to P0.0, and RX routed to P0.1

	mov SFRPAGE, #00h ; Pagina 0 voor SSTA0, SCON0 en timers
	mov SSTA0, #10h ; UART0 baud rate divide-by-two disabled
	mov SCON0, #40h ; Mode 1: 8-Bit UART, Variable Baud Rate

	; TIMER 1
	mov TMOD, #20h  ; Mode 2: 8-bit counter/timer with auto-reload
	mov CKCON, #10h ; Timer 1 uses the system clock
	mov TH1, #236d

	mov A, #01h ; 0000 0001

	setb TR1

	powers:
		mov SBUF0, A
		jnb TI0, $
		rlc A
		jmp powers
