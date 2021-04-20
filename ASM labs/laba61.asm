	.model	small
	.stack	100h
	.data
text	db	"Enter strings",10,13,'$'
buffer	db	255  dup('*')                           ;вводимая строка
	.code
Start:
	mov	ax,@data		;типа .ехе
	mov	ds,ax		;файл
;*---------------------------------------------------------------------*
	mov	ah,9h		;Предлагаем
	lea	dx,text 		;ввести 
	int	21h		;строку
	mov	ah,0Ah		;Вводим строку
	lea	dx,buffer		; буфер строки
	int	21h		;
	mov	al,13		;*********************
	int	29h		;переходим на 
	mov	al,10		;следующую строку
	int	29h		;*********************          
	xor	dx,dx
	xor	bx,bx
	mov	si,2
cycl:
	cmp	buffer[si],' '
	je	wiv
	mov	dx,si
	jmp	exx
wiv:	
	inc si
	cmp	buffer[si],' '
	je	cycl	
	dec	si
	dec	dx
	call	RNL
	mov	al,0h		;Заносим в АЛ probel
	int	29h		;выводим на экран
	mov	bx,si

exx:
	inc	si	
loop	cycl	
	mov	cl,buffer[1]
	mov	ch,0
	mov	si,2

cyc:
	cmp	buffer[si],' '
	jne	exit7
	mov	bx,si
exit7:	
	inc	si
loop	cyc	
	mov	dl,buffer[1]
	mov	dh,0
	call	RNL
;	xor	dx,dx
	mov	ax,4C00h		;-=-=-=Выход в	
	int	21h		;-=-=-= DOS
;*********************************************************************************
;========================================================================
;*********************************************************************************
RNL	proc			;ПРОЦЕДУРА РАЗВЕРТЫВАНИЯ СТРОКИ НА ОБОРОТ
	push	cx
	push	ax
	push	si
	push	dx
	push	bx

	mov	cx,dx
	inc	cx		;Увеличиваем сх на единицу	
	mov	si,cx		;и помещаем в si, так надо, иначе последний символ не будет разворачиваться 	
	dec	cx		;уменьшаем сх :)
viv:			
	mov	al,buffer[si]		;Заносим в АЛ последний символ строки
	int	29h		;выводим на экран
	dec	si		;уменьшаем СИ, т.е. движемся с последнего символа к первому
	cmp	cx,bx
	jne	exit
	mov	cx,1
exit:
loop	viv			;повторяем цикл
	pop	bx
	pop	dx
	pop	si
	pop	ax
	pop	cx
	Ret			;выходим из процедуры
RNL	ENDP			;---конец процедуры---

end start