	.model	tiny
	.code
	org	100h
Start:
	mov	ah,9h
	lea	dx,text
	mov	bh,0
	mov	bl,00000100b
	mov	cx,len
	int	10h	
	int	21h
;********************************
	lea	bx,a
	mov	ax,'$'
	mov	[bx],ax
	mov	ah,9h
	lea	dx,[bx]
	int	21h	
	Ret
Text	db	"CCCP",10,13,'$'
len	=	$-text
a	db	'235'
End	Start