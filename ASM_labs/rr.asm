; 
.186	;¢Ŗ«īē „¬ Ŗ®¬ ­¤ė 186å Ŗ ¬­„©.(¤«ļ PUSHA Ø POPA)
Data Segment
err1	db	"čØ”Ŗ  ¢ ¢®¤„ ēØį« .",10,13,'$'
text	db	"¢„¤Øā„ cāą®Ŗć ēØį„« ®ā 0 ¤® 255",10,13,'$'
buf	db	800 	dup(?)
dva	db	2
d10	db	10
n	dw	0
x	dw	0
buffer	db	255	
stroka	dw	25 	
Data ends
;++++++++++++++++++++++++++++++++++++++++++++++++++++
;////////////////// 
;++++++++++++++++++++++++++++++++++++++++++++++++++++
Code segment
	assume cs:code, ds:data;

start:
	mov	ax,data
	mov	ds,ax

;-------ą„¤« £ „¬ ¢¢„įāØ ēØį«®:
	mov	ah,9h
	lea	dx,text
	int	21h

;-------®”įā¢„­­® į ¬ ¢¢®¤:
	mov	ah,0Ah
	lea	dx,buffer  ;¢ ”ćä„ą § ÆØįė¢ „¬ ¢¢„¤„­ćī įāą®Ŗć.
	int	21h
	mov	si,2	;į® ¢ā®ą®£® ” ©ā  Ø¤„ā į ¬  ¢¢„¤„­ ļ įāą®Ŗ 
	mov	cl,buffer[1] ;§ ­®įØ¬ ¢ 	
	mov	ch,0         ;«Ø­ć ¢¢„¤„­®© įāą®ŖØ
;------------------- 
Prover:                        
	cmp	buffer[si],'0' ; 
	jl	erro           ; 
	cmp	buffer[si],'9' ;
	jg	erro           ;!!!!
probel:
	inc	si
loop	prover

jmp	Poehali
erro:
	cmp	buffer[si],' '
	je	probel
	mov	ah,9h
	lea	dx,err1  ;¢ ”ćä„ą § ÆØįė¢ „¬ ¢¢„¤„­ćī įāą®Ŗć.
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
	mov	ax,x	; 
	call	dec_to_bin   ;  !!!
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
	mov	ax,x	; 
	call	dec_to_bin   ;  !!!
	mov	si,8
	call	write		









;cmp	dx,1
;je	net
;	mov	cl,buffer[1]
;	xor	ch,ch
;	mov	si,2
 ;
;	call	StrToInt
;	mov	ax,x	; 
;	call	dec_to_bin   ;  !!!

	mov	si,8	;¢ si ¤«Ø­  įāą®ŖØ
	mov	cx,8	;¢ įå ā®¦„
;-*-*-*-*-*-*-*-*-*-    -*-*-*-*-*-*-*-*-*-
;viv:
;	mov	al,buf[si]	;®”įā¢„­­® Æ®įØ¬¢®«ģ­ė© ¢ė¢®¤ ­  ķŖą ­
;	int	29h             ;įāą®ŖØ.
;	dec	si              ;āą®Ŗć ¢ė¢®¤Ø¬ į Ŗ®­ę .
;loop	viv
net:


; ¢.... 
	jmp	quit
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;     !
; å®¤„  buffer = ¢¢„¤„­®© įāą®Ŗ„. bx - Æ®§ØęØļ
;  ¢ėå®¤Ø ¢ å Æ®¬„é „āģįļ ēØį«®
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

StrToInt	proc
	pusha
	mov	cx,bx
;	mov	si,2	;į® ¢ā®ą®£® ” ©ā  Ø¤„ā į ¬  ¢¢„¤„­ ļ įāą®Ŗ 
;	mov	cl,buffer[1] ;§ ­®įØ¬ ¢ 	
;	xor	ch,ch         ;«Ø­ć ¢¢„¤„­®© įāą®ŖØ
	xor	ax,ax	
per_ch:
	mov	bl,buffer[si]	;¢ bl «®¦Ø¬ ®ē„ą„¤­®© įØ¬¢®« įāą®ŖØ
	sub	bl,48		;¢ėēØā „¬ Ŗ®¤ 0 Ø Æ®«ćē „¬ ēØį«®
	xor	bh,bh		;ēā®”ė ¢  ”ė«® ā®«ģŖ® ­ č„ ēØį«®
	add	ax,bx		;įŖ« ¤ė¢ „¬ į 
	cmp	cx,1		;įą ¢­Ø¢ „¬  į 1
	jna	exx		;į«Ø ¬„­ģč„ Ø«Ø ą ¢­® Ø¤e¬ ­  Ŗ®­„ę ęØŖ« 		
	mul     d10		;­ ē„ ć¬­®¦ „¬ ēØį«® ­  10
exx:
	inc	si		;«„¤ćīéØ© įØ¬¢®«
loop	per_ch	
;-------------------------------
	mov	x,ax	;¢  į®åą ­ļ„¬ §­ ē„­Ø„  å
	popa		;¤®įā „¬ ¢į„ ą„£Øįāąė Ø§ įāķŖ 
		Ret
StrToInt	EndP
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;   10­®©  ¢ !
; å®¤„  = ¤„įļāØē­®¬ć ēØį«ć. 
;  ¢ėå®¤Ø ¢ buf Æ®¬„é „āģįļ ¤¢®Øē­®„ ēØį«®
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dec_to_bin	proc
	pusha
	mov	cx,8	;«Ø­  įāą®ŖØ
	mov	si,2	;į® ¢ā®ą®£® ” ©ā  Ø¤„ā įāą®Ŗ , ¢ Æ„ą¢ėå ¤¢ćå į«ć¦„”­ ļ Ø­ä 
cycl:
	div	dva	;„«Ø¬ ­  ®į­®¢ ­Ø„ įØįā„¬ė įēØį«„­Øļ
	push	ax	;®åą ­ļ„¬  å ¢ įāķŖ„
	cmp	ah,0	;įą ¢­Ø¢ „¬  å į 0
	jne	ed	;„į«Ø ­„ ą ¢­® ā® § ÆØįė¢ „¬ ¢ buf 1
	mov	al,48	; Ø­ ē„ § ÆØįė¢ „¬ 
	mov	buf[si],al;!(Ŗ®¤ „£® 48;)
	jmp	exxx	;ć¬ ī ļį­®;)
ed:
	mov	al,49	  ; āćā § ÆØįė¢ „¬ „¤„­ØēŖć
	mov	buf[si],al; „¤„­ØēŖØ ¢ ASCII 49	
exxx:
	pop	ax	;¤®įā „¬  å
	inc	si	;Ø¤„¬ ­  į«„¤ćīéØ© įØ¬¢®« įāą®ŖØ	
loop	cycl		;Æ®¢ā®ąļ„¬, ­ «Ø¢ „¬
	POPA	
	RET
dec_to_bin	EndP

;**************************************
write	proc
PushA
;mov	si,8	;¢ si ¤«Ø­  įāą®ŖØ
mov	cx,8	;¢ įå ā®¦„
viv:
	mov	al,buf[si]	;®”įā¢„­­® Æ®įØ¬¢®«ģ­ė© ¢ė¢®¤ ­  ķŖą ­
	int	29h             ;įāą®ŖØ.
	dec	si              ;āą®Ŗć ¢ė¢®¤Ø¬ į Ŗ®­ę .
loop	viv

Popa
	RET
write	endp
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; ,      !!!
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
quit:
	mov	ax,4C00h
	int	21h
;*-*-*-*-*-*-*-*-*

Code ends

end start