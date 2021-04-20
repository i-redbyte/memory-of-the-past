data segment
mas	db	4,6,1,4,3
max	db	0
data ends

code segment
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax
lea	bx,mas
mov	cx,5
xor	ax,ax
mov	al,[bx]
cycl1:
	cmp	al,[bx]
	ja	no
	mov	al,[bx]
no:
	inc	bx
loop	cycl1
mov	max,al
mov dl,al
add dl,30h
mov ah,02h
int 21h
mov dl,' '
mov ah,02h
int 21h

lea	bx,mas
mov	cx,5
xor	ax,ax
mov	al,[bx]
mov	ah,max
cycl2:
	cmp	al,[bx]
	ja	het
	cmp	ah,[bx]
	jnl	het

	mov	al,[bx]
Het:
	inc	bx
loop	cycl2

mov dl,al
add dl,30h      	
mov ah,02h
int 21h
mov ax,4c00h
int 21h
code ends

end start