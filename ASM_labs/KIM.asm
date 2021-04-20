		.model	tiny
		.code
		org	100h
Start:
	lea	bx,mas
	mov	ax,[bx]
	mov	cx,n
lala:
	cmp	ax,[bx]
	jl	no
	mov	ax,[bx]
no:
	inc	bx
	inc	bx
Loop	lala
	neg	ax
	Ret
mas	dw	1,4,0,-8,-9,77,4	
n	= 	7
End Start