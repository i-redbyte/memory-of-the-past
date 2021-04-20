	.model	tiny
	.code
	org	100h

;Макрос вывода на экран числа от 0, до 999
write3	macro	che
	Local	viv1,viv2,viv3,exx
;-------------------------------------------
	mov	ax,che
	cmp	ax,99
	jg	viv3
	cmp	ax,9
	jle	viv1
viv2:
	mov	bl,10		
	div	bl		
	mov	cx,ax		
	mov	ah,02h
	mov	dl,cl
	add	dl,30h
	int	21h
	mov	ah,02h
	mov	dl,ch
	add	dl,30h
	int	21h
	jmp	exx

viv1:
	mov	cx,ax		
	mov	ah,02h     	
	mov	dl,cl		
	add	dl,30h          
	int	21h
	jmp	exx
viv3:
	mov	bl,100		;отделяем первую цифру,
	div	bl		;она теперь в al  
	mov	cx,ax		;загружаем результат в сх
;================+Выводим перую цифру+================
	mov	ah,02h     	
	mov	dl,cl		
	add	dl,30h          
	int	21h
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
	mov	cl,ch		;cl = ch,в сh хранятся 2 другие цифры.
	xor	ch,ch 		;обнуляем ch и заливаем cx в ax, в al	 
	mov	ax,cx           	;теперь храниться 2 др. цифры,
	mov	bl,10           	;а при делении результат 
	div	bl              	;идет в al, а остаток в ah
	mov	cx,ax	
;================+Выводим 2 цифру+================
;---------------------------
	mov	ah,02h
	mov	dl,cl
	add	dl,30h
	int	21h
;================+Выводим 3 цифру+================
;----------------------------
	mov	ah,02h
	mov	dl,ch
	add	dl,30h
	int	21h
	
Exx:
EndM
Start:
;~~~~~~~~~~~~~~Очищаем экран~~~~~~~~~~~~~~~~~
	mov	ax,0003h
	int	10h
;*******************ПОЕХАЛИ*******************
	write3	651		;в ax заносим наше 3-х значное число
;-*-*-*-*-*-*Наливаем пива и наслаждаемся результатом:)
	mov	ax,3
	int 	16h
	RET
End	start
