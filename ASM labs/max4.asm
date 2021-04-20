	.model	tiny
	.code
	org	 100h
Start:
	lea	bx,mas	;в bx заносим массив
	mov	cx,n    ;в СХ длина массива
	xor	dx,dx	;обнуляем DX
cycl:
	mov	al,[bx]	;в AL заносим очередной элемент массива
po_chis:
	test	al,1b	;смотрим первый бит числа
	jz	nul	;если ноль, то не трогаем
	inc	count	;иначе увеличиваем счетчик
nul:	
	shr	al,1	;сдвигаем биты вправо
	inc	dx	;считаем кол-во просмотренных битов
	cmp	dx,8	;+сравниваем  DX с 8(кол-во бит в числе)
	jbe	po_chis	;+если меньше или равно то повторяем
	push	bx
	mov	bl,2
	mov	ax,count; в AX заносим кол - во "1".
	div     bl	;Делим АХ на 2
	pop	bx
	cmp 	ah,0    ;Проверяем остаток, равен ли нулю? 
	jne	next	;Если нет, то идем дальше
	inc	otv	;Если равен, то увеличиваем счетчик на 1
next:	
	xor	dx,dx	;обнуляем DX
	mov	count,0 ;обнуляем счетчик едениц
	inc	bx      ;следующий элемент массив
Loop	cycl	
	mov	ah,02h     	
	mov	dl,otv		
	add	dl,30h          
	int	21h

	Ret
count	dw	0	;Счетчик едениц
otv	db	0       ;Счетчик четного кол-ва едениц
mas	db	01011111b,11110101b,11111111b,01010101b,10101001b ;сам массив:)
n	= $ - mas	; длина массива  
End Start