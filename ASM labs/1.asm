;ПРОГРАММА ПЕРЕВОДА ДЕСЯТИЧНОГО ЧИСЛА В ;ДВОИЧНУЮ И ШЕСТНАДЦАТЕРИЧНУЮ СИСТЕМЫ ;СЧИСЛЕНИЯ
.MODEL small
.STACK 64
.DATA
;Сегмент данных
;____________________________________________________________________
;Таблица преобразования "цифра - ASCII-код" 
        org        	           	100h
        tabl_ascii  db     	'0123456789abcdef'
;____________________________________________________________________
;Таблица преобразования "ASCII-код - цифра"
        org         		130h
        db          		0,1,2,3,4,5,6,7,8,9
        org         		41h
        db          		0ah,0bh, 0ch, 0dh, 0eh, 0fh
;____________________________________________________________________
;Резервация и инициализация переменных в памяти
        org        	           	150h
        x_ascii     db      	20h dup(?)
        t1             db      	0dh,0ah,"Введите число и нажмите Enter"
                        db      	0dh, 0ah, "$"
        t2             db      	0dh,0ah,"Вы ввели число",0dh,0ah, "$"
        t3             db      	0dh, 0ah, "В двоичной системе оно выглядет так"
                        db      	0dh,0ah,"$"
        t4             db      	0dh, 0ah, "В шестнадцатеричной так"
                        db      	0dh, 0ah, "$"
buf db 16 dup(?),"$"
        t5             db      	0dh,0ah, "Будем продолжать процесс? (Y/N)?"
                        db      	0dh,0ah,"$"
;____________________________________________________________________


;Сегмент кодов
.CODE
;Главная процедура 
  g_k proc
        mov                   	ax,@data
        mov                   	ds, ax
        mov	          		es, ax
  d:   lea                     	dx, t1
        mov                   	ah,09h
        int                      	21h
        lea                     	di, x_ascii
        call                     	ink
        call                     	des_2
        push                  	ax
        lea                     	dx,t3
        mov                   	ah,9h
        int                      	21h
        pop                    	ax
        call                     	bin_dis
        push	          		ax
        lea                     	dx,t4
        mov                   	ah,9h
        int                      	21h
        pop	          		ax
        call                    	outhex
        lea                     	dx,t5
        mov                   	ah,9h
        int                      	21h
        mov                   	ah,1h
        int                      	21h
        cmp       	       	al,"Y"
        loope	           	 d
        cmp           		al,"y"
        loop         		d
        mov           		ah,4ch
        int           		21h
  g_k endp
  ink proc

;Процедура ввода десятичного числа 
        xor	           	cx,cx
  l1: 
        mov	           	ah,1
        int         			21h
        stosb
        inc           		cx
        cmp           		al,0dh
        jnz        			l1
        dec           		cx
        ret
  ink endp
  dis proc

 ;Процедура вывода на экран десятичного числа 
  r1: mov 		          	dl,[di]
        mov           		ah,2
        int           		21h
        inc          		di
        loop 			r1
        ret
  dis endp
  des_2 proc

;Перевод числа(десятичного) в двоичную систему
        mov           	si,10
        lea           	di,x_ascii
        sub           	ax,ax
  v1: mul          	si
        mov           	bp,ax
        mov           	al,[di]
        sub 	    	al,48
        inc           	di
        mov	          	ah,ch
        add           	ax,bp
        loop          	v1
        ret
  des_2 endp
  bin_dis proc

  ;Процедура вывода на экран двоичного числа
        lea           	di,buf
        mov           	cx,16
        mov	          	bx,ax
        mov	          	dx,ax
conv:	
        mov	          	al,ch
        shl           	dx,1
        adc	          	al,'0'
        stosb	
        loop          	conv
        mov           	ah,9h
        lea           	dx,buf
        int         		21h
        mov	 	ax,bx
        ret
  bin_dis endp

;Процедура перевода числа(двоичного)в шестнадцатеричную
;и вывод его на экран 
outhex: 
mov	          	ch,al
	mov	          	al,ah
	mov	          	ah,2
	call	          	prnbh
	mov	          	al,ch
prnbh:
	mov		dh,al
	shr	          	al,1
	shr	          	al,1
	shr	          	al,1
	shr	          	al,1
	call	          	prnd
	mov	          	al,dh
	and	          	al,15
prnd:	
or	          	al,48
	cmp	          	al,58
	jc              	prnc
	add	          	al,7
prnc:	
mov		dl,al
	int	          	33
	ret
	
  end g_k



