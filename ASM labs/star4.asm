data segment
mas db 10,2,3,4,-2,-1,6,9,10,8
n = $-mas	;��������� ����� �������
data ends
code segment
assume cs: code, ds: data
start:
mov ax, data
mov ds, ax
mov	cx,n	;� �� ������� ���-�� ��-�� �������
xor dx,dx		;�������� ��
lea bx,mas		;� �� ������� ����� ������
cycl:
	mov	al,[bx]	;� �� ��������� ��-� �������
	cmp	al,0	;���������� ��-� ������� � �����
	jge	next	;���� ������ ��� ����� �� ���� ������
	neg 	al	;���� ������ ���� �� ������ ����
next:
	cmp	al,6	;���������� ��-� ������� � 6
	jae 	no	;���� ������ ��� ����� �� ���� ������
	add dl,al		;���� ������ �� ����������
no:
	inc bx		;��������� ��-� �������
loop cycl
;===============EXIT
mov ax, 4c00h
int 21h
code ends
end start