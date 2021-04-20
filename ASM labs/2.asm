data segment
mas dw 1,2,3,4,-2,-1
stroka	db 'Lalala'
data ends
code segment
assume cs: code, ds: data
start:
mov ax, data
mov dx, ax
lea bx, mas

mov cx, 6
cycc:
cmp cx, 2
jne no
mov ax, [bx]
shl ax, 2
mov [bx], ax
no: inc bx
inc bx
loop cycc

mov cx,10
mov ax,[bx]
mov si,0
begin:
   mov ax,[bx]
   push bx
   mov bx,2
   div bx
   pop bx
   cmp dl,0
   
   jne no
inc si
no:
inc bx
loop begin
mov cx,ax
lea dx,stroka
mov ah,09h
int 21h


mov ax, 4c00h
int 21h
code ends
end start