	.model	tiny
	.code
	org	100h

;������ ������ �� ����� ����� �� 0, �� 999
write3	macro	che
	Local	viv1,viv2,viv3,exx
;-------------------------------------------
	mov	ax,che
	cmp	ax,99
	jg	viv3
	cmp	ax,9
	jle	viv1
viv2:
	mov	bl,10		
	div	bl		
	mov	cx,ax		
	mov	ah,02h
	mov	dl,cl
	add	dl,30h
	int	21h
	mov	ah,02h
	mov	dl,ch
	add	dl,30h
	int	21h
	jmp	exx

viv1:
	mov	cx,ax		
	mov	ah,02h     	
	mov	dl,cl		
	add	dl,30h          
	int	21h
	jmp	exx
viv3:
	mov	bl,100		;�������� ������ �����,
	div	bl		;��� ������ � al  
	mov	cx,ax		;��������� ��������� � ��
;================+������� ����� �����+================
	mov	ah,02h     	
	mov	dl,cl		
	add	dl,30h          
	int	21h
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
	mov	cl,ch		;cl = ch,� �h �������� 2 ������ �����.
	xor	ch,ch 		;�������� ch � �������� cx � ax, � al	 
	mov	ax,cx           	;������ ��������� 2 ��. �����,
	mov	bl,10           	;� ��� ������� ��������� 
	div	bl              	;���� � al, � ������� � ah
	mov	cx,ax	
;================+������� 2 �����+================
;---------------------------
	mov	ah,02h
	mov	dl,cl
	add	dl,30h
	int	21h
;================+������� 3 �����+================
;----------------------------
	mov	ah,02h
	mov	dl,ch
	add	dl,30h
	int	21h
	
Exx:
EndM
Start:
;~~~~~~~~~~~~~~������� �����~~~~~~~~~~~~~~~~~
	mov	ax,0003h
	int	10h
;*******************�������*******************
	write3	651		;� ax ������� ���� 3-� ������� �����
;-*-*-*-*-*-*�������� ���� � ������������ �����������:)
	mov	ax,3
	int 	16h
	RET
End	start
