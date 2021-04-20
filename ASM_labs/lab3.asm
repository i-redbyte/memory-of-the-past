		.model	tiny
		.code
		org	100h
Start:
	lea	bx,mass
	mov	al,175
	mov	AH,18
	mov	cx,10
	xor	dx,dx
cycl:
	cmp	[bx],ah
	ja	exx
	jmp 	exit_cycl
exx:
	cmp	[bx],al
	jb	exx1
	jmp 	exit_cycl
exx1:
        inc	dx
exit_cycl:	
	inc	bx
Loop	cycl	

;	mov	ax,count
	Ret
count	dw	0
mass	db	100,55,200,17,6,90,120,4,67,111
End Start