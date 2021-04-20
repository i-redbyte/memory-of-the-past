;������� ������
.186	;����砥� ������� 186� ������.(��� PUSHA � POPA)
Data Segment
err1	db	"�訡�� � ���� �᫠.",10,13,'$'
text	db	"������ c�ப� �ᥫ �� 0 �� 255",10,13,'$'
buf	db	800 	dup(?)
dva	db	2
d10	db	10
n	dw	0
x	dw	0
buffer	db	255	
stroka	dw	25 	
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
	mov	si,2	;� ��ண� ���� ���� ᠬ� �������� ��ப�
	mov	cl,buffer[1] ;����ᨬ � ��	
	mov	ch,0         ;����� �������� ��ப�
;-------------------��������� ������
Prover:                        
	cmp	buffer[si],'0' ; ���
	jl	erro           ; ���
	cmp	buffer[si],'9' ;����
	jg	erro           ;!!!!
probel:
	inc	si
loop	prover

jmp	Poehali
erro:
	cmp	buffer[si],' '
	je	probel
	mov	ah,9h
	lea	dx,err1  ;� ���� �����뢠�� �������� ��ப�.
	int	21h
JMP	QUIT	
;/*/*/*/*/*/*/*/*/*/*/*/*/*/
;ROCK-N-ROLL!
;/*/*/*/*/*/*/*/*/*/*/*/*/*/
Poehali:
	mov	al,10
	int	29h
	mov	al,13
	int	29h

;----
	mov	cl,buffer[1]
	mov	ch,0
	xor	bx,bx
	mov	di,2
;	xor	dx,dx	
POK:
	cmp	buffer[di],' '
	jg	next
	mov	si,di
	sub	si,bx
	call	StrToInt
	mov	ax,x	; ��
	call	dec_to_bin   ;�������� ��������� ��������!!!
	mov	si,8
	call	write		
	xor	bx,bx
	jmp	lala
next:
	inc	bx
lala:
	inc	di
Loop	POK
	mov	si,di
	sub	si,bx
	call	StrToInt
	mov	ax,x	; ��
	call	dec_to_bin   ;�������� ��������� ��������!!!
	mov	si,8
	call	write		









;cmp	dx,1
;je	net
;	mov	cl,buffer[1]
;	xor	ch,ch
;	mov	si,2
 ;
;	call	StrToInt
;	mov	ax,x	; ��
;	call	dec_to_bin   ;�������� ��������� ��������!!!

	mov	si,8	;� si ����� ��ப�
	mov	cx,8	;� �� ⮦�
;-*-*-*-*-*-*-*-*-*-������� �������� ����� �� �����-*-*-*-*-*-*-*-*-*-
;viv:
;	mov	al,buf[si]	;����⢥��� ��ᨬ����� �뢮� �� �࠭
;	int	29h             ;��ப�.
;	dec	si              ;��ப� �뢮��� � ����.
;loop	viv
net:


;����� �.... 
	jmp	quit
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;��������� �������� �� ������ � �����!
;�� �室�  buffer = �������� ��ப�. bx - ������
;�� ��室� � � ����頥���� �᫮
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

StrToInt	proc
	pusha
	mov	cx,bx
;	mov	si,2	;� ��ண� ���� ���� ᠬ� �������� ��ப�
;	mov	cl,buffer[1] ;����ᨬ � ��	
;	xor	ch,ch         ;����� �������� ��ப�
	xor	ax,ax	
per_ch:
	mov	bl,buffer[si]	;� bl ����� ��।��� ᨬ��� ��ப�
	sub	bl,48		;���⠥� ��� 0 � ����砥� �᫮
	xor	bh,bh		;�⮡� � �� �뫮 ⮫쪮 ��� �᫮
	add	ax,bx		;᪫��뢠�� � ��
	cmp	cx,1		;�ࠢ������ �� � 1
	jna	exx		;�᫨ ����� ��� ࠢ�� ��e� �� ����� 横��		
	mul     d10		;���� 㬭����� �᫮ �� 10
exx:
	inc	si		;������騩 ᨬ���
loop	per_ch	
;-------------------------------
	mov	x,ax	;� � ��࠭塞 ���祭�� ��
	popa		;���⠥� �� ॣ����� �� ���
		Ret
StrToInt	EndP
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;��������� �������� �� 10��� ������� � ��������!
;�� �室� �� = �����筮�� ���. 
;�� ��室� � buf ����頥���� ����筮� �᫮
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dec_to_bin	proc
	pusha
	mov	cx,8	;����� ��ப�
	mov	si,2	;� ��ண� ���� ���� ��ப�, � ����� ���� �㦥���� ���
cycl:
	div	dva	;����� �� �᭮����� ��⥬� ��᫥���
	push	ax	;���࠭塞 �� � ���
	cmp	ah,0	;�ࠢ������ �� � 0
	jne	ed	;�᫨ �� ࠢ�� � �����뢠�� � buf 1
	mov	al,48	; ���� �����뢠�� 
	mov	buf[si],al;�����!(��� ��� 48;)
	jmp	exxx	;�㬠� �᭮;)
ed:
	mov	al,49	  ;� ��� �����뢠�� �������
	mov	buf[si],al;��� �����窨 � ASCII 49	
exxx:
	pop	ax	;���⠥� ��
	inc	si	;���� �� ᫥���騩 ᨬ��� ��ப�	
loop	cycl		;�����塞, ��������
	POPA	
	RET
dec_to_bin	EndP

;**************************************
write	proc
PushA
;mov	si,8	;� si ����� ��ப�
mov	cx,8	;� �� ⮦�
viv:
	mov	al,buf[si]	;����⢥��� ��ᨬ����� �뢮� �� �࠭
	int	29h             ;��ப�.
	dec	si              ;��ப� �뢮��� � ����.
loop	viv

Popa
	RET
write	endp
;���!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;������������ �����, �������� ���� � ������������ ������� �����!!!
;���!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
quit:
	mov	ax,4C00h
	int	21h
;*-*-*-*-*-*-*-*-*

Code ends

end start