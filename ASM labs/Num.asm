;****************************************
;****tasm num.asm tlink num/t/x***
;****************************************
		.model	tiny
		.code
		org	100h
Start:
	keyb_wait:
		in	al,64h		;���訢��� ॣ���� ���ﭨ�
		test	al, 010b		;�᫨ ���� �����
		jnz	keyb_wait	;�����塞 ����.	
		mov	al,0EDh		;������� �ࠢ����� NumLock'��
		out	60h,al		;�����뢠�� � ���� ������
	data_wait:
		in	al,64h		;���訢��� ॣ���� ���ﭨ�
		test	al,010b		;�᫨ ���� �����
		jnz	data_wait	;�����塞 ����.
		mov	al,010b		;����砥� NumLock
		out	60h,al		;�����뢠�� � ����.
		Ret
End	Start