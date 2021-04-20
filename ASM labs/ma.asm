		.model	tiny
		.code
		org	100h
Start:
	mov	ah,9h		;Предлогаем	
	lea	dx,porka	;ввести	
	int	21h		;строку.

	mov	ah,0Ah		;Вводим
	lea	dx,buffer	;строку	
	int	21h		;buffer - сама строка.

	mov	al,13		;**********
	int	29h		;Переводим*	
	mov	al,10		;строку   *
	int	29h		;**********
	mov	si,2
	mov	cx,5
Exx:
	mov	ah,02h
	mov	dl,buffer[si]
	int	21h
	inc	si
loop	exx	
;~~~~~~~~~~~~~~EXIT~~~~~~~~~~~~~~~
	ret
porka	db	'Введите строку:',13,10,"$"
buffer	db	255
end	start
