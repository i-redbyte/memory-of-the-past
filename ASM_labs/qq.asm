;??????? ??????
.186	;????砥? ??????? 186? ??????.(??? PUSHA ? POPA)
Data Segment
err1	db	"?訡?? ? ???? ??᫠.",10,13,'$'
text	db	"??????? ??᫮.",10,13,'$'
buf	db		8 dup(?)
dva	db	2
d10	db	10
x	dw	0
buffer	db	4	
Data ends
;++++++++++++++++++++++++++++++++++++++++++++++++++++
;//////////////////??????? ????
;++++++++++++++++++++++++++++++++++++++++++++++++++++
Code segment
	assume cs:code, ds:data;

start:
	mov	ax,data
	mov	ds,ax

;-------?।?????? ?????? ??᫮:
	mov	ah,9h
	lea	dx,text
	int	21h

;-------????⢥??? ᠬ ????:
	mov	ah,0Ah
	lea	dx,buffer  ;? ????? ?????뢠?? ???????? ??ப?.
	int	21h

;********************************
;*?८?ࠧ??뢠?? ??ப? ? ??᫮*
;********************************
	mov	si,2	;?? ???ண? ????? ???? ᠬ? ???????? ??ப?
	mov	cl,buffer[1] ;????ᨬ ? ??	
	mov	ch,0         ;????? ???????? ??ப?
	xor	ax,ax
per_ch:
	mov	bl,buffer[si]	;? bl ????? ???।??? ᨬ??? ??ப?
	sub	bl,48		;????⠥? ??? 0 ? ????砥? ??᫮
	xor	bh,bh		;?⮡? ? ?? ?뫮 ⮫쪮 ???? ??᫮
	add	ax,bx		;᪫??뢠?? ? ??
	cmp	cx,1		;?ࠢ?????? ?? ? 1
	jna	exx		;?᫨ ?????? ??? ࠢ?? ??e? ?? ????? 横??		
	mul     d10		;????? 㬭????? ??᫮ ?? 10
exx:
	inc	si		;??????騩 ᨬ???
loop	per_ch	
;-------------------------------
	mov	x,ax	;? ? ???࠭塞 ???祭?? ??
	popa		;???⠥? ??? ॣ????? ?? ?????
	mov	ax,x	;???⠭???????? ???祭?? ??
;? ?? ??室????? ???????? ??᫮	
	call	dec_to_bin   ;???????? ????????? ????????!!!

	mov	si,8	;? si ????? ??ப?
	mov	cx,8	;? ?? ⮦?
;-*-*-*-*-*-*-*-*-*-??????? ???????? ????? ?? ?????-*-*-*-*-*-*-*-*-*-
viv:
	mov	al,buf[si]	;????⢥??? ??ᨬ??????? ?뢮? ?? ??࠭
	int	29h             ;??ப?.
	dec	si              ;??ப? ?뢮??? ? ?????.
loop	viv


;????? ?.... 
	jmp	quit
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;????????? ???????? ?? 10??? ??????? ? ????????!
;?? ?室? ?? = ??????筮?? ?????. 
;?? ??室? ? buf ????頥???? ????筮? ??᫮
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dec_to_bin	proc
	mov	cx,8	;????? ??ப?
	mov	si,2	;?? ???ண? ????? ???? ??ப?, ? ?????? ???? ??㦥???? ????
cycl:
	div	dva	;????? ?? ?᭮????? ???⥬? ???᫥???
	push	ax	;???࠭塞 ?? ? ?????
	cmp	ah,0	;?ࠢ?????? ?? ? 0
	jne	ed	;?᫨ ?? ࠢ?? ?? ?????뢠?? ? buf 1
	mov	al,48	; ????? ?????뢠?? 
	mov	buf[si],al;?????!(??? ??? 48;)
	jmp	exxx	;?㬠? ?᭮;)
ed:
	mov	al,49	  ;? ??? ?????뢠?? ????????
	mov	buf[si],al;??? ?????窨 ? ASCII 49	
exxx:
	pop	ax	;???⠥? ??
	inc	si	;???? ?? ᫥???騩 ᨬ??? ??ப?	
loop	cycl		;??????塞, ????????
	
	RET
dec_to_bin	EndP
;???!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;???????????? ?????, ???????? ???? ? ???????????? ??????? ?????!!!
;???!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
quit:
	mov	ax,4C00h
	int	21h
;*-*-*-*-*-*-*-*-*

Code ends

end start