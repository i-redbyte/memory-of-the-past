	.model	tiny
	.code
	org	100h
Start:
	xor	si,si
	mov	cx,n
Ste:
	cmp	mas[si],0
	je	met
	jmp	exx
Met:
	mov	ah,9h
	lea	dx,txt
	int	21h
exx:
	inc	si
loop	ste		
	Ret
txt	db	"Lenin",10,13,'$'
mas	db	1,2,3,0,-1,0
n	=	6
End Start