;****************************************
;****tasm num.asm tlink num/t/x***
;****************************************
		.model	tiny
		.code
		org	100h
Start:
	keyb_wait:
		in	al,64h		;Опрашиваем регистр состояния
		test	al, 010b		;если буфер занят
		jnz	keyb_wait	;повторяем опрос.	
		mov	al,0EDh		;Команду управления NumLock'ом
		out	60h,al		;Записываем в порт данных
	data_wait:
		in	al,64h		;Опрашиваем регистр состояния
		test	al,010b		;если буфер занят
		jnz	data_wait	;повторяем опрос.
		mov	al,010b		;Включаем NumLock
		out	60h,al		;Записываем в порт.
		Ret
End	Start