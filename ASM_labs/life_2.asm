	.model	small
	.stack	100h	
	.code
	.186	;��� ������ shl al,4 � shr al,4
Delay	macro	time	
	Local	ext,inn
	push	cx
	mov	cx,time
ext:
	push	cx
	xor	cx,cx
inn:
loop	inn
	pop	cx
loop	ext
	pop	cx	
EndM

Start:
	Push	FAR_BSS	;�������� ���� ���� � DS
	pop	ds
;������塞 ���ᨢ �祥� ��砩���� �᫠��.
	xor	ax,ax 	  	;����砥� ⥪�饥 �६�. 
	int	1Ah		;� DX - ������⢮ ᥪ㭤 � ��砫� ����祭�� ��.
	mov	di,320+200+1    ;���ᨬ���� ����� �祩��

Fill_buffer:
	imul	dx,4E35h	;���⮩ ������� ��砩��� 
	inc	dx		;�ᥫ �� 2 ������.
	mov	ax,dx		;⥪�饥 ���.�᫮ ����ᨬ � ��
	shr	ax,15		;�� ���� ��⠢�塞 ���� ���
	mov	byte ptr [di],al;� � ���ᨢ ��������� 00, �᫨ �祩�� ����, � 01 �᫨ ��ᥫ���.
	dec	di
	jnz	fill_buffer	;�த������ 横�, �᫨ di �� �⠫ ࠢ�� ���
	mov	ax,0013h	;����᪨� ०��
	int	10h		;320�200, 256 梥⮢.

;*******************�᭮���� 横�*******************
new_cycle:
;1)��� ������ �祩�� �������� �᫮ �ᥤ�� 
;� �����뢠���� � ���訥 4 ��� �⮩ �祩��.
	mov	di,320*200+1	;���ᨬ���� ����� �祩��
Step_1:
	mov	al,byte ptr [di+1]	;� AL �������� �㬬� ���祭��
	add	al,byte ptr [di-1]      ;8 �ᥤ��� �祥�,
	add	al,byte ptr [di+319]    ;�� �⮬ � ������ 4 ����
	add	al,byte ptr [di-319]    ;������������� �᫮ �ᥤ��
	add	al,byte ptr [di+320]
	add	al,byte ptr [di-320]
	add	al,byte ptr [di+321]
	add	al,byte ptr [di-321]
	shl	al,4           		;������ ���訥 4 ��� AL- �᫮ �ᥤ�� ⥪�饩 �祩��
	or	byte ptr [di],al	;����頥� �� � � ���訥 4 ��� �祩��.
	dec	di      		;��������� �祩��
	jnz	step_1	

;******************************************************************************
;2)��������� ���ﭨ� �祥� � ᮮ⢥��⢨� � ����稭�묨 ���祭�ﬨ �᫠ �ᥤ��
;******************************************************************************
	mov	di,320*200+1	;���ᨬ���� ����� �祩��
Flip_cycle:
	mov	al,byte ptr [di];���뢠�� �祩�� �� ���ᨢ�.
	shr	al,4            ;Al = �᫮ �ᥤ��
	cmp	al,3            ;�᫨ �᫮ �ᥤ�� = 3
	je	birth           ;��ᥫ塞 �祩��
	cmp	al,2            ;�᫨ �᫮ �ᥤ�� = 2
	je	f_c_continue    ;�祩�� �� ���������
	mov	byte ptr [di],0 ;���� - �祩�� 㬨ࠥ�.
	jmp	short f_c_continue
birth:
	mov	byte ptr [di],1	 
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
f_c_continue:
	and	byte ptr [di],0Fh;����塞 �᫮ �ᥤ�� � ����� ���� �祩��
	dec	di      		;��������� �祩��
	jnz	flip_cycle
;�뢮� ���ᨢ� �� �࠭ ᯮ����� BIOS
	mov	si,320*200+1    ;����. ����� �祩��
	push	0A000h
	pop	es
	mov	cx,320+200+1
dec	dx
	mov	di,cx
	mov	si,cx
	inc	si
	rep	movsb

	mov	ah,1		;�᫨ �� ����� ������ -
	int	16h
	jz	new_cycle	;᫥���騩 蠣 ~�����~.
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~EXIT
	mov	ax,0003h
	int	10h	
	mov	ax,4C00h
	int	21h
	.fardata?	;������� ���쭨� �����樠����஢����� ������
		db	320*200+1 dup(?) ; ���ᨢ �祥�	
End Start