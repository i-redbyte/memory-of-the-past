	.model	tiny     ;������ ����� ��� ��� 䠩��
	.code		 ;������� ����
	org	100h	 ;����� �� ��砠 ����� � 100h ����(⠪ ���� ��� ��� 䠩��)

Start:	
	lea	bx,mas	;����㦠�� � �� ᠬ ���ᨢ
	mov	cx,n    ;� �� ����� ���ᨢ�.
	mov	dh,0	;��� �ࠢ����� � �㫥�
;-*-*-*-*-*-*-*-��� ����-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	mov	ax,1
cyc:	
	
	cmp	[bx],dh ;�ࠢ������ ��।��� ������� ���ᨢ� � �㫥�
	jng	no	;�᫨ < ��� ���室�� �� ᫥���騩 �������
	mov	dl,[bx]
	mul	dl	
no:
	inc	bx	;᫥���騩 �������		
loop	cyc
;--------------------------------
;--------------------------------
	Ret

mas	db	1,-2,3,-4,3,-6 ;��� ���ᨢ
n	=	$ - mas        ;�����뢠�� ����� ���ᨢ�,$ - �� ⥪�騩 ����(����� ���ᨢ�(�� ����� ������)) 
End Start