;int main(){
;	int f = fac(5);
;}
;
;fac(int n){
;	if( n >= 1 ){
;		return n * fac(n - 1);
;	}else{
;		return 1;
;	}
;}

$include (c8051f120.inc)

cseg at 0000h
  jmp main
cseg at 0080h

main:
  clr EA
  mov WDTCN, #0DEh
  mov WDTCN, #0ADh
  setb EA

  mov A, #5d
  push ACC

  call fac
  mov SP, #07h
  jmp $


fac:
	push 00h
	mov R0, SP
	dec R0
	dec R0
	dec R0
	mov A, @R0 ; A = 5

	jnz recursion
	mov B, #1d

	pop 00h
	ret


recursion:
	dec A  ; A - 1 
	push ACC
	call fac
	pop ACC
	inc A
	mul AB
	mov B, A
	pop 00h
	ret

