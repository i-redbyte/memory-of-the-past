	.model	tiny
	.code
	org	100h
start:
	mov	ah,9h
	lea	dx,text
	int	21h

	ret
text	db	"HELLO WORLD!",10,13,'$'
end start