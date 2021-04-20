	.model	tiny
	.code
	org	100h
Start:
	mov	cx,256
	xor	bh,bh
	xor	bl,bl
medved:
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;=================COLOR=================
	push	bx
	push	cx
	mov	ah,9h
	mov	bl,13
	mov	bh,0
	mov	cx,1
	int	10h
	pop	cx
	pop	bx
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	mov	ah,2h
	mov	dl,bh
	int	21h
	inc	bh
	inc	bl
	cmp 	bl,16
	je	perenos
	jmp	ahtung
perenos:
	mov	ah,9h
	lea	dx,ent
	int	21h
	xor	bl,bl
ahtung:
Loop	medved
	Ret
Ent	db	10,13,'$'
End	Start