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

;^^^^^^^^^^^^^^�������� �����^^^^^^^^^^^^^^
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

;^^^^^^^^^^^��楤��� � ��६����.^^^^^^^^^^^
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;_____________________________________________
;##############�뢮� ��ப �� �࠭/##########
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
print_strings proc 
;� 祬 �� �㦥 ��㣨�?:))))
	push	ax 
	push	bx 
	push	dx 
;`�⠢�� ����� � ��� 0,0`
	mov	bh, 00h 
	mov	ah, 02h 
	xor	dx, dx 
	int	10h 
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$
;!!!+++�뢮�  1-� ��ப�+++!!!
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$
	lea	dx,str1
	mov 	ah, 09h 
	int 	21h 
;`����� �� ᫥������ ��ப�`
	mov	ah, 02h 
	xor	dx, dx 
	mov	dh, 01h 
	int	10h 
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$
;!!!+++�뢮�  2-� ��ப�+++!!!
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$
	lea	dx,str2
	mov	ah, 09h 
	int	21h 
;`����� �� ᫥������ ��ப�`
	mov	ah, 02h 
	xor	dx, dx 
	mov 	dh,02h 
	int	10h 
;$&&&&&&&&&&&&&&&&&&&&&&&&&&&$
;!!!+++�뢮�  3-� ��ப�+++!!!
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
;�������㥬 ��ப� str1,str2,str3
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
;~~~~~~~~~~~~~~~~~~����� ��楤���~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

;++++++++++++++++++++++++++++++++++++++++++++++

;**********************************************
;~~~~~��楤�� ��������� ॣ���� ��ப�~~~~~
;========����: si - ���� ��ப�===============
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
invert_string 	proc 
	push 	dx 
ibegin: 
	mov	dl,byte ptr [si] 
;--------------�᫨ ࠢ�� $ - ����� ��ப�
	cmp 	dl, 24h ; '$' 
	je 	iexit 
;--------------�᫨ ����� A--------------
	cmp 	dl, 40h ; 'A' 
	jle 	inext 
	cmp 	dl, 7Bh ; 'z' 
	jge 	inext 
;---------------�᫨ ����� Z--------------
	cmp 	dl, 5Ah ; 'Z' 
	jle 	iupcase 
	cmp 	dl, 61h ; 'a' 
	jge 	ilocase 
	jmp 	inext 
;%%%%%%%%%%%%%%%���孨� ॣ����%%%%%%%%%%%%%%
iupcase: 
	add 	dl, 20h 
	jmp 	inext 
;%%%%%%%%%%%%%%%������ ॣ����%%%%%%%%%%%%%%
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
;~~~~~~~~~~~~~~~~~~����� ��楤���~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

str1 	db 	"PREVED!",'$' 
str2 	db 	"MEDVED!",'$' 
str3 	db 	"CcCp",'$' 

end start 

