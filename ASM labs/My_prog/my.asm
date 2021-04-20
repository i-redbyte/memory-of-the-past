		.model	tiny
		.code	
		org	100h
Start:
		xor	si,si
		mov	cx,5
sq:
		cmp	mas[si],0
		je	exit
		inc	si
		mov	ah,9h
		lea	dx,odin
		int	21h
		Loop	sq	
Exit:
	Ret
mas	db	1,1,0,1,0
len	=	$-mas
Zerro	db	"0 $"
odin	db	"1 $"

End	Start