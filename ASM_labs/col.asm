	.model	tiny
	.code
	org	100h

;-*/*/-*/-/-*/-*/-*/*-/*-/-*/*-/-*/-*/*-/*-/*-/-*/-*/-/-*/*-/*-/-*/-/
;?????? ?뢮?? ??᫠ ? ????????? ?? 0 ?? 999 ?? ??࠭
;Write3 - ???????? ???????, che - ??।??????? ? ?????? ??᫮
;-*/*/-*/-/-*/-*/-*/*-/*-/-*/*-/-*/-*/*-/*-/*-/-*/-*/-/-*/*-/*-/-*/-/
write3	macro	che
	Local	viv1,viv2,viv3,exx	;????????? ??⪨
;-------------------------------------------
	mov	ax,che	;??㧨? ? ?? ???? ??᫮
	cmp	ax,99	;?ࠢ?????? ? 99
	jg	viv3    ;?᫨ ??????, ?? ?뢮??? ??? 3? ????. ??᫮
	cmp	ax,9    ;?ࠢ?????? ? 9
	jle	viv1    ;?᫨ ?????? ??? ࠢ??, ?? ?뢮??? ??? ????????.??᫮
viv2:			;?뢮? ??㧭??.??᫠
	mov	bl,10	;? ??-10		
	div	bl	;????? ?? ?? 10	
	mov	cx,ax	;???࠭塞 ?? ??	
	mov	ah,02h	;?뢮??? ?????? ????? 2????. ??᫠
	mov	dl,cl   ;? ?? ??ࢠ? ????? ??襣? ??᫠
	add	dl,30h  ;?ਡ?????? ? ???? ??, 48, ?⮡ ???????? ?????	
	int	21h     ;?뢮? ?? ??࠭
	mov	ah,02h	;?뢮??? ?????? ?????
	mov	dl,ch   ;-
	add	dl,30h  ;-
	int	21h     ;-
	jmp	exx     ;??室?? ?? ???????

;*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
viv1:		;?뢮? ????????. ??᫠
	mov	cx,ax	;??????	
	mov	ah,02h  ;?뢮???   	
	mov	dl,cl	;????		
	add	dl,30h  ;??᫮        
	int	21h     ;?? ??࠭
	jmp	exx     ;??室?? ?? ???????
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

viv3:	;?뢮? ?१???. ??᫠
	mov	bl,100		;?⤥?塞 ?????? ?????
	div	bl		;??? ⥯??? ? ?? 
	mov	cx,ax		;१?????? ??㧨? ? ??
;================+?뢮??? ?????? ?????+================
	mov	ah,02h     	
	mov	dl,cl		
	add	dl,30h          
	int	21h
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
	mov	cl,ch		;cl = ch,? ?h ?࠭????? 2 ??㣨? ?????.
	xor	ch,ch 		;?????塞? ch ? ???????? cx ? ax, ? al	 
	mov	ax,cx           	;⥯??? ?࠭?????? 2 ??. ?????,
	mov	bl,10           	;? ??? ??????? १??????
	div	bl              	;???? ? ??, ? ????⮪ ? ??
	mov	cx,ax	
;================+?뢮??? ?????? ?????+================
;---------------------------
	mov	ah,02h
	mov	dl,cl
	add	dl,30h
	int	21h
;================+?뢮??? 3 ?????+================
;----------------------------
	mov	ah,02h
	mov	dl,ch
	add	dl,30h
	int	21h
	
Exx:
EndM ;????? ???????
;-------
;-------
;---?᭮???? ?ணࠬ?? :)
;-------
;-------

Start:
	mov	ah,9h		;?।?a????	
	lea	dx,porka	;??????	
	int	21h		;??ப?.
;-------
	mov	ah,0Ah		;??????
	lea	dx,buffer	;??ப?	
	int	21h		;buffer - ᠬ? ??ப?.
;++++++++
	mov	al,13		;********************************
	int	29h		;*??ॢ???? ?????? ?? ᫥?????? *	
	mov	al,10		;*??ப?                        *
	int	29h		;********************************
	mov	al,buffer[1]    ;? ax ????ᨬ
	mov	ah,0            ;????? ??ࢮ? ??ப?
        mov	cx,ax           ;???࠭塞 ?? ? ??
	push	cx		;?쥬 ?? ? ????
	write3	ax              ;?뢮?? ????? ??ࢮ? ??ப? ?? ??࠭
	mov	al,13		;********************************
	int	29h		;*??ॢ???? ?????? ?? ᫥?????? *	
	mov	al,10		;*??ப?                        *
	int	29h		;********************************
;#################################
	mov	buf,255         ;??? ????,?⮡ ?? ?????? ??ப? ?????? ??ப? ?????? ? 255 ????
	mov	ah,9h		;?।?a????	
	lea	dx,porka	;??????	
	int	21h		;??ப?.
;----------
	mov	ah,0Ah		;??????
	lea	dx,buf		;??ப?	
	int	21h		;buf - ᠬ? ??ப?.
;----------
	mov	bl,buf[1]	;? ?? ⥯???
	mov	bh,0            ;????? ???ன ??ப?	
	mov	al,13		;********************************
	int	29h		;*??ॢ???? ?????? ?? ᫥?????? *	
	mov	al,10		;*??ப?                        *
	int	29h		;********************************
	write3	bx		;?뢮??? ????? ???ன ??ப?
	mov	al,13		;********************************
	int	29h		;*??ॢ???? ?????? ?? ᫥?????? *	
	mov	al,10		;*??ப?                        *
	int	29h		;********************************

;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
	pop	cx		;???⠥? ?? ????? ??
	cmp	cx,bx		;?ࠢ?????? ?? ? ??
	jl	viv2		;?᫨ ?????? ??ப? ??????
	mov	ah,9h		;????? ?뢮??? ᮮ?饭??
	lea	dx,mes1         ;??? ??ࢠ? ??ப?
	int	21h             ;?????? 
	sub	cx,bx           ;????⠥? ?? ????? ??ࢮ? ??ப? ????? ???ன
	mov	ch,0            ;?⢥?	
	Write3	cx              ;?뢮?? ?? ??࠭
	jmp	exit		;??室
viv2:		;⮦? ᠬ?? ?᫨ ?????? ??ப? ?????? ??ࢮ?
	mov	ah,9h
	lea	dx,mes2
	int	21h    
	sub	bx,cx	;??।??塞 ?? ᪮?쪮 ?????? ?????? ??ப? ??ࢮ?
	mov	bh,0    ;:)
	Write3	bx      ;?뢮? १??????? ?? ??࠭
Exit:	
;~~~~~~~~~~~~~~EXIT~~~~~~~~~~~~~~~
	ret
porka		db	'??????? ??ப?:',13,10,"$"
mes1		db	'1 ??ப? ?????? 2 ??',13,10,"$"
mes2		db	'2 ??ப? ?????? 1 ??',13,10,"$"
buffer		db	255
buf		db	255
End Start
