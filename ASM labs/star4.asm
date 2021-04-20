data segment
mas db 10,2,3,4,-2,-1,6,9,10,8
n = $-mas	;вычисляем доину массива
data ends
code segment
assume cs: code, ds: data
start:
mov ax, data
mov ds, ax
mov	cx,n	;в сх заносим кол-во эл-ов массива
xor dx,dx		;обнуляем дх
lea bx,mas		;в бх заносим адрес массив
cycl:
	mov	al,[bx]	;в ал очередной эл-т массива
	cmp	al,0	;сравниваем эл-т массива с нулем
	jge	next	;если больше или равен то идем дальше
	neg 	al	;если меньше нуля то меняем знак
next:
	cmp	al,6	;сравниваем эл-т массива с 6
	jae 	no	;если больше или равен то идем дальше
	add dl,al		;если меньше то складываем
no:
	inc bx		;следующий эл-т массива
loop cycl
;===============EXIT
mov ax, 4c00h
int 21h
code ends
end start