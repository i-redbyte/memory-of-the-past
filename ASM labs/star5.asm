data segment
new_st	db	80,?,82	dup(?)	;
buffer	db	80 	dup(?)	;
konec	db "$"
data ends
code segment
assume cs: code, ds: data
start:
mov ax, data
mov ds, ax
	mov	ah,0Ah		
	lea	dx,buffer	
	int	21h		;buffer
mov	cl,buffer[1]    ;Заносим в СХ длину строки
	mov	ch,0            ;которая храниться во втором байте строки(buffer[1]) 
	mov	si,2 		;С третьего байта в buffer начинается наша строка
	mov	di,0
cycl:
		;cmp buffer[si],' '
		;jne next

	mov  	al,buffer[si]
	mov	new_st[di],al
	inc si
	inc di
loop cycl
;	mov	new_st[si+1],'$'
	mov	ah,9h
	lea dx,new_st
	int 21h

	mov	ah,9h
	lea dx,konec
	int 21h
;===============EXIT
mov ax, 4c00h
int 21h
code ends
end start