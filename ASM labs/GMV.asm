;������� ������
Data Segment
err1	db	"�訡�� � ���� �᫠.",10,13,'$'
text	db	"������ �᫮",10,13,'$'
buf	db		8 dup(?)
dva	db	2
x	dw	10

buffer	db	6	
Data ends
;++++++++++++++++++++++++++++++++++++++++++++++++++++
;//////////////////������� ����
;++++++++++++++++++++++++++++++++++++++++++++++++++++
Code segment
	assume cs:code, ds:data;

start:
	mov	ax,data
	mov	ds,ax

;-------�।������ ����� �᫮:
	mov	ah,9h
	lea	dx,text
	int	21h

;-------����⢥��� ᠬ ����:
	mov	ah,0Ah
	lea	dx,buffer  ;� ���� �����뢠�� �������� ��ப�.
	int	21h
	mov	cl,buffer[1] ;***� �� �������
	xor	ch,ch	     ;***����� ������ 	
	mov	ax,1
dlin:
	cmp	cx,1
	jle	exx
	mul	x
exx:	
loop	dlin
	

	mov	si,2
	mov	cl,buffer[1] ;***� �� �������;;
	xor	ch,ch	     ;***����� ������ 	
	mov	bx,ax
	xor	dx,dx
cycl:
	mov	al,buffer[si]
	sub	al,48
	xor	ah,ah 
	mul	bx
	add	dx,ax
	shr	bx,5
	inc	si
loop	cycl

	mov	ax,dx
	mov	cx,8
	mov	si,2
viv:
	div	dva	
	push	ax
	cmp	ah,0
	jne	_1
	mov	al,48
	mov	buf[si],al
;	int	29h
	jmp	exx1
_1:
	mov	al,49
	mov	buf[si],al
;	int	29h

exx1:
	pop	ax
	inc	si
loop	viv
	mov	cx,8
	mov	si,10
ppp:
	mov	al,buf[si]
	int	29h
dec	si
loop	ppp
;����� �.... 
	mov	ax,4C00h
	int	21h
;*-*-*-*-*-*-*-*-*
Code ends
;binary	proc
;	Ret
;binary	endp
end start