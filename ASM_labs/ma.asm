		.model	tiny
		.code
		org	100h
Start:
	mov	ah,9h		;�।������	
	lea	dx,porka	;�����	
	int	21h		;��ப�.

	mov	ah,0Ah		;������
	lea	dx,buffer	;��ப�	
	int	21h		;buffer - ᠬ� ��ப�.

	mov	al,13		;**********
	int	29h		;��ॢ����*	
	mov	al,10		;��ப�   *
	int	29h		;**********
	mov	si,2
	mov	cx,5
Exx:
	mov	ah,02h
	mov	dl,buffer[si]
	int	21h
	inc	si
loop	exx	
;~~~~~~~~~~~~~~EXIT~~~~~~~~~~~~~~~
	ret
porka	db	'������ ��ப�:',13,10,"$"
buffer	db	255
end	start
