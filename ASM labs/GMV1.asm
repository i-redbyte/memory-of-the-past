;������� ������
Data Segment
err1	db	"�訡�� � ���� �᫠.",10,13,'$'
text	db	"������ �᫮",10,13,'$'
buf	db		8 dup(?)
dva	db	2
x	dw	61

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
	mov	cx,8
	mov	ax,x
	mov	si,2
;����� �.... 
cycl:
	div	dva	
	push	ax
	cmp	ah,0
	jne	ed
	mov	al,48
	mov	buf[si],al
;	int	29h
	jmp	exxx
ed:
	mov	al,49
	mov	buf[si],al
;	int	29h
	inc	si	
exxx:
	pop	ax
loop	cycl
	mov	cx,16
	mov	si,cx
viv:
	mov	al,buf[si]
	int	29h
	dec	si
loop	viv

	mov	ax,4C00h
	int	21h
;*-*-*-*-*-*-*-*-*
Code ends
;binary	proc
;	Ret
;binary	endp
end start