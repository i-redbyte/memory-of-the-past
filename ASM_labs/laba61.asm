	.model	small
	.stack	100h
	.data
text	db	"Enter strings",10,13,'$'
buffer	db	255  dup('*')                           ;�������� ������
	.code
Start:
	mov	ax,@data		;���� .���
	mov	ds,ax		;����
;*---------------------------------------------------------------------*
	mov	ah,9h		;����������
	lea	dx,text 		;������ 
	int	21h		;������
	mov	ah,0Ah		;������ ������
	lea	dx,buffer		; ����� ������
	int	21h		;
	mov	al,13		;*********************
	int	29h		;��������� �� 
	mov	al,10		;��������� ������
	int	29h		;*********************          
	xor	dx,dx
	xor	bx,bx
	mov	si,2
cycl:
	cmp	buffer[si],' '
	je	wiv
	mov	dx,si
	jmp	exx
wiv:	
	inc si
	cmp	buffer[si],' '
	je	cycl	
	dec	si
	dec	dx
	call	RNL
	mov	al,0h		;������� � �� probel
	int	29h		;������� �� �����
	mov	bx,si

exx:
	inc	si	
loop	cycl	
	mov	cl,buffer[1]
	mov	ch,0
	mov	si,2

cyc:
	cmp	buffer[si],' '
	jne	exit7
	mov	bx,si
exit7:	
	inc	si
loop	cyc	
	mov	dl,buffer[1]
	mov	dh,0
	call	RNL
;	xor	dx,dx
	mov	ax,4C00h		;-=-=-=����� �	
	int	21h		;-=-=-= DOS
;*********************************************************************************
;========================================================================
;*********************************************************************************
RNL	proc			;��������� ������������� ������ �� ������
	push	cx
	push	ax
	push	si
	push	dx
	push	bx

	mov	cx,dx
	inc	cx		;����������� �� �� �������	
	mov	si,cx		;� �������� � si, ��� ����, ����� ��������� ������ �� ����� ��������������� 	
	dec	cx		;��������� �� :)
viv:			
	mov	al,buffer[si]		;������� � �� ��������� ������ ������
	int	29h		;������� �� �����
	dec	si		;��������� ��, �.�. �������� � ���������� ������� � �������
	cmp	cx,bx
	jne	exit
	mov	cx,1
exit:
loop	viv			;��������� ����
	pop	bx
	pop	dx
	pop	si
	pop	ax
	pop	cx
	Ret			;������� �� ���������
RNL	ENDP			;---����� ���������---

end start