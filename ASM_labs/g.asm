	.model	tiny
	.code
	org	100h

Delay	macro	time	
	Local	ext,inn
	push	cx
	mov	cx,time
ext:
	push	cx
	xor	cx,cx
inn:
loop	inn
	pop	cx
loop	ext
	pop	cx	
EndM

;^^^^^^^^^^^^^^ОСНОВНАЯ ПРОГА^^^^^^^^^^^^^^
Start:
	mov	ax,0003h
	int	10h
	mov	cx,30
main_loop: 
	call	print_strings 
	call	invert_strings 
	delay	1500
	delay	1500
loop	main_loop
	RET	;;;;;;;;;end :)

;^^^^^^^^^^^процедуры и переменные.^^^^^^^^^^^
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;_____________________________________________
;##############Вывод строк на экран/##########
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
print_strings proc 
;А чем мы хуже других?:))))
	push	ax 
	push	bx 
	push	dx 
;`Ставим курсор в точку 0,0`
	mov	bh, 00h 
	mov	ah, 02h 
	xor	dx, dx 
	int	10h 
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$
;!!!+++Вывод  1-й строки+++!!!
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$
	lea	dx,str1
	mov 	ah, 09h 
	int 	21h 
;`курсор на следующую строку`
	mov	ah, 02h 
	xor	dx, dx 
	mov	dh, 01h 
	int	10h 
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$
;!!!+++Вывод  2-й строки+++!!!
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$
	lea	dx,str2
	mov	ah, 09h 
	int	21h 
;`курсор на следующую строку`
	mov	ah, 02h 
	xor	dx, dx 
	mov 	dh,02h 
	int	10h 
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$
;!!!+++Вывод  3-й строки+++!!!
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$

	lea	dx,str3
	mov	ah, 09h 
	int	21h 
	pop	dx 
	pop	bx 
	pop	ax 
		ret 
print_strings endp 

;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;Инвертируем строки str1,str2,str3
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
invert_strings	 proc 
	push si 
	lea 	si, str1 
	call 	invert_string 
	lea 	si, str2 
	call 	invert_string 
	lea 	si, str3 
	call 	invert_string 
	pop 	si 
		ret 
invert_strings endp 
;**********************************************
;~~~~~~~~~~~~~~~~~~Конец процедуры~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;++++++++++++++++++++++++++++++++++++++++++++++

;**********************************************
;~~~~~Процедура инвертирует регистр строки~~~~~
;========ВХОД: si - адрес строки===============
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
invert_string 	proc 
	push 	dx 
ibegin: 
	mov	dl,byte ptr [si] 
;--------------Если равно $ - конец строки
	cmp 	dl, 24h ; '$' 
	je 	iexit 
;--------------Если меньше A--------------
	cmp 	dl, 40h ; 'A' 
	jle 	inext 
	cmp 	dl, 7Bh ; 'z' 
	jge 	inext 
;---------------Если больше Z--------------
	cmp 	dl, 5Ah ; 'Z' 
	jle 	iupcase 
	cmp 	dl, 61h ; 'a' 
	jge 	ilocase 
	jmp 	inext 
;%%%%%%%%%%%%%%%Верхний регистр%%%%%%%%%%%%%%
iupcase: 
	add 	dl, 20h 
	jmp 	inext 
;%%%%%%%%%%%%%%%Нижний регистр%%%%%%%%%%%%%%
ilocase: 
	sub 	dl, 20h 
	jmp 	inext 
inext: 
	mov 	[si], byte ptr dl 
	inc 	si 
	jmp 	ibegin 
iexit: 
	pop 	dx 
		ret 
	invert_string endp 
;********************************************
;~~~~~~~~~~~~~~~~~~Конец процедуры~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

str1 	db 	"PREVED!",'$' 
str2 	db 	"MEDVED!",'$' 
str3 	db 	"CcCp",'$' 

end start 

