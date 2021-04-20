	.model	tiny
	.code
	org	100h
Start:
	mov	ah,9h
	lea	dx,txt
	mov	bl,12
	mov	bh,0
	mov	cx,8
	int	10h
	int	21h
	mov	ax,2
	mul	bx
	Ret
txt	db	"Red_byte",10,13,'$'
x	db	2
End 	Start