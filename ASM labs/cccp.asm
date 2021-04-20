	.model	tiny
	.code
	org	100h
Start:
;-/-/-/-/-/-/Приглашаем ввести текс-/-/-/-/-/-/
;	mov	ah,9h
;	lea 	dx,txt
;	int	21h
	cld
	mov	cx,len_s
	lea	di,s
	mov	al,p
Next_ser:
	lea	si,p
	inc	si
	repne	scasb
	jcxz	exit
	push	cx
	mov	cx,len_p-1
	repe	cmpsb
	jz	eq_sub
	mov	bx,len_p-1
	sub	bx,cx
	pop	cx
	sub	cx,bx
	jmp	next_ser
eq_sub:
	pop	cx
	sub	cx,len_p-1
	inc	count
	jmp	next_ser
exit:		
	add	count,30h
	mov	ah,9h
	lea	dx,mes
	int	21h
	mov	ah,9h
	lea	dx,count
	int	21h

	Ret
count	db	0,"$"
mes	db	"Вхождение строки - "
p	db	"n"
len_p	=	$-p
	db	"-"
	db	0,"$"
txt	db	"Введите текст",10,13,'$'
s	db 	"Lenin",10,13,'$' 	
len_s	= 	$-s
End Start
