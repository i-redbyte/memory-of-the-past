	.model	tiny
	.code
	org	100h
Start:
jmp	lala
axtung:
	add	text[si],48
	jmp	met
lala:
	mov	cx,100
	xor	si,si
met:
	mov ah,9h
	lea dx,text
	int	21h
	inc	si
	cmp	text[si],61
	jl	axtung
loop	met
	Ret
Text	db "lEnin Jiv!",10,13,'$'
;len	
End Start