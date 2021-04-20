data segment
b dw 1
c dw -5
x dw ?
sem	dw	7
data ends

code segment
assume cs:code, ds:data
start:
mov ax,data
mov ds,ax
mov 	ax,b
mul	sem
sub	ax,11
mov	cx,c
shl	cx,1
add	CX,16
add	cx,ax
mov dl,cl
add dl,30h
mov ah,02h
int 21h

quit:
mov ax,4c00h
int 21h
code ends
end start
