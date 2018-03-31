// void laatste(int *tab, int n, int &l){
//		l = tab[n-1];
// }

// int main(){
// 	int t[5] = {1, 2, 7, 12, 3};
//		int l; => 35h
//		laatste(t, 5, l);
//		while(1);
// }



$include (c8051f120.inc)
cseg at 0000h
	jmp main
cseg at 0080h

main:
	clr EA
	mov WDTCN, #0DEh
	mov WDTCN, #0ADh
	setb EA

	;t
	mov 20h, #1d
	mov 21h, #2d
	mov 22h, #7d
	mov 23h, #12d
	mov 24h, #3d

	mov A, #20h ; Startadres array
	push ACC

	mov A, #5d ; lengte array
	push ACC

	mov A, #35h ; pointer laatste
	push ACC

	call laatste

	mov SP, #07h
	jmp $

laatste:
	push 00h ; R0 op stapel
	mov R0, SP
	push 01h ; R1 op stapel
	push 02h ; R2 op stapel
	push 03h ; R3 op stapel

	dec R0 ; High Byte returnadres
	dec R0 ; Low Byte returnadres
	dec R0 ; #35h
	mov 01h, @R0 ; R1 = #35h
	dec R0 ; #5d
	mov 02h, @R0 ; R2 = #5d
	dec R0 ; #20h
	mov A, @R0 ; A = #20h

	dec R2    ; #4d
	add A, R2 ; 20 + 4 = 24
	mov R3, A ; R3 = 24
	mov @R1, 03h ; R1 = tab[4]
	mov A, 35h   ; A = #3d

	pop 03h
	pop 02h
	pop 01h
	pop 00h

	ret
