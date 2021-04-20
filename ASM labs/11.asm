data segment
a    dw  6
b    dw  -5
c    dw  5
tri  dw  3

stroka db "a=1; b=-5; c=5; x= a-3 (a+b)+ c-4 = ", '$'

data ends

stk segment stack
db 256 dup (?)
stk ends

code segment
assume cs: code, ds: data

start:
mov ax, data
mov ds, ax
lea dx,stroka
mov ah,09h
int 21h

mov ax, a
add ax, b
mul tri
mov bx, a
sub bx, ax
mov cx, c
sub cx,4
add bx,cx
;ÂÛÂÎÄ ÍÀ İÊĞÀÍ:
mov 	ax, bx
add	al,30h
int	29h

mov ax,4c00h
int 21h
code ends
end start          