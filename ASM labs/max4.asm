	.model	tiny
	.code
	org	 100h
Start:
	lea	bx,mas	;� bx ����ᨬ ���ᨢ
	mov	cx,n    ;� �� ����� ���ᨢ�
	xor	dx,dx	;����塞 DX
cycl:
	mov	al,[bx]	;� AL ����ᨬ ��।��� ����� ���ᨢ�
po_chis:
	test	al,1b	;ᬮ�ਬ ���� ��� �᫠
	jz	nul	;�᫨ ����, � �� �ண���
	inc	count	;���� 㢥��稢��� ���稪
nul:	
	shr	al,1	;ᤢ����� ���� ��ࠢ�
	inc	dx	;��⠥� ���-�� ��ᬮ�७��� ��⮢
	cmp	dx,8	;+�ࠢ������  DX � 8(���-�� ��� � �᫥)
	jbe	po_chis	;+�᫨ ����� ��� ࠢ�� � �����塞
	push	bx
	mov	bl,2
	mov	ax,count; � AX ����ᨬ ��� - �� "1".
	div     bl	;����� �� �� 2
	pop	bx
	cmp 	ah,0    ;�஢��塞 ���⮪, ࠢ�� �� ���? 
	jne	next	;�᫨ ���, � ���� �����
	inc	otv	;�᫨ ࠢ��, � 㢥��稢��� ���稪 �� 1
next:	
	xor	dx,dx	;����塞 DX
	mov	count,0 ;����塞 ���稪 ������
	inc	bx      ;᫥���騩 ����� ���ᨢ
Loop	cycl	
	mov	ah,02h     	
	mov	dl,otv		
	add	dl,30h          
	int	21h

	Ret
count	dw	0	;���稪 ������
otv	db	0       ;���稪 �⭮�� ���-�� ������
mas	db	01011111b,11110101b,11111111b,01010101b,10101001b ;ᠬ ���ᨢ:)
n	= $ - mas	; ����� ���ᨢ�  
End Start