		.model	tiny
		.code
		org	100h
Start:
	inc	cx
	call	xxxxx

Ret
Lenin	db	'M',10,13
	db	'I',10,13
	db	' ',10,13
	db	'S',10,13
	db	'T',10,13
	db	'R',10,13
	db	'O',10,13
	db	'I',10,13
	db	'L',10,13
	db	'I',10,13
	db	', ',10,13
	db	'�',10,13
	db	'�',10,13
	db	'�',10,13
	db	'�',10,13
	db	'�',10,13
	db	'�',10,13
	db	'�',10,13
	db	' ' ,10,13
	db	'!',10,13,'$'




xxxxx	Proc	
	mov	ah,9
	lea	dx,lenin
	int	21h
	Ret
xxxxx	EndP
End	Start