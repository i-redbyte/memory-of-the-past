; 
.186	;¢ª«îç ¥¬ ª®¬ ­¤ë 186å ª ¬­¥©.(¤«ï PUSHA ¨ POPA)
Data Segment
err1	db	"è¨¡ª  ¢ ¢®¤¥ ç¨á« .",10,13,'$'
text	db	"¢¥¤¨â¥ câà®ªã ç¨á¥« ®â 0 ¤® 255",10,13,'$'
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

;-------à¥¤« £ ¥¬ ¢¢¥áâ¨ ç¨á«®:
	mov	ah,9h
	lea	dx,text
	int	21h

;-------®¡áâ¢¥­­® á ¬ ¢¢®¤:
	mov	ah,0Ah
	lea	dx,buffer  ;¢ ¡ãä¥à § ¯¨áë¢ ¥¬ ¢¢¥¤¥­ãî áâà®ªã.
	int	21h
	mov	si,2	;á® ¢â®à®£® ¡ ©â  ¨¤¥â á ¬  ¢¢¥¤¥­ ï áâà®ª 
	mov	cl,buffer[1] ;§ ­®á¨¬ ¢ 	
	mov	ch,0         ;«¨­ã ¢¢¥¤¥­®© áâà®ª¨
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
	lea	dx,err1  ;¢ ¡ãä¥à § ¯¨áë¢ ¥¬ ¢¢¥¤¥­ãî áâà®ªã.
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

	mov	si,8	;¢ si ¤«¨­  áâà®ª¨
	mov	cx,8	;¢ áå â®¦¥
;-*-*-*-*-*-*-*-*-*-    -*-*-*-*-*-*-*-*-*-
;viv:
;	mov	al,buf[si]	;®¡áâ¢¥­­® ¯®á¨¬¢®«ì­ë© ¢ë¢®¤ ­  íªà ­
;	int	29h             ;áâà®ª¨.
;	dec	si              ;âà®ªã ¢ë¢®¤¨¬ á ª®­æ .
;loop	viv
net:


; ¢.... 
	jmp	quit
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;     !
; å®¤¥  buffer = ¢¢¥¤¥­®© áâà®ª¥. bx - ¯®§¨æ¨ï
;  ¢ëå®¤¨ ¢ å ¯®¬¥é ¥âìáï ç¨á«®
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

StrToInt	proc
	pusha
	mov	cx,bx
;	mov	si,2	;á® ¢â®à®£® ¡ ©â  ¨¤¥â á ¬  ¢¢¥¤¥­ ï áâà®ª 
;	mov	cl,buffer[1] ;§ ­®á¨¬ ¢ 	
;	xor	ch,ch         ;«¨­ã ¢¢¥¤¥­®© áâà®ª¨
	xor	ax,ax	
per_ch:
	mov	bl,buffer[si]	;¢ bl «®¦¨¬ ®ç¥à¥¤­®© á¨¬¢®« áâà®ª¨
	sub	bl,48		;¢ëç¨â ¥¬ ª®¤ 0 ¨ ¯®«ãç ¥¬ ç¨á«®
	xor	bh,bh		;çâ®¡ë ¢  ¡ë«® â®«ìª® ­ è¥ ç¨á«®
	add	ax,bx		;áª« ¤ë¢ ¥¬ á 
	cmp	cx,1		;áà ¢­¨¢ ¥¬  á 1
	jna	exx		;á«¨ ¬¥­ìè¥ ¨«¨ à ¢­® ¨¤e¬ ­  ª®­¥æ æ¨ª« 		
	mul     d10		;­ ç¥ ã¬­®¦ ¥¬ ç¨á«® ­  10
exx:
	inc	si		;«¥¤ãîé¨© á¨¬¢®«
loop	per_ch	
;-------------------------------
	mov	x,ax	;¢  á®åà ­ï¥¬ §­ ç¥­¨¥  å
	popa		;¤®áâ ¥¬ ¢á¥ à¥£¨áâàë ¨§ áâíª 
		Ret
StrToInt	EndP
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;   10­®©  ¢ !
; å®¤¥  = ¤¥áïâ¨ç­®¬ã ç¨á«ã. 
;  ¢ëå®¤¨ ¢ buf ¯®¬¥é ¥âìáï ¤¢®¨ç­®¥ ç¨á«®
;/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dec_to_bin	proc
	pusha
	mov	cx,8	;«¨­  áâà®ª¨
	mov	si,2	;á® ¢â®à®£® ¡ ©â  ¨¤¥â áâà®ª , ¢ ¯¥à¢ëå ¤¢ãå á«ã¦¥¡­ ï ¨­ä 
cycl:
	div	dva	;¥«¨¬ ­  ®á­®¢ ­¨¥ á¨áâ¥¬ë áç¨á«¥­¨ï
	push	ax	;®åà ­ï¥¬  å ¢ áâíª¥
	cmp	ah,0	;áà ¢­¨¢ ¥¬  å á 0
	jne	ed	;¥á«¨ ­¥ à ¢­® â® § ¯¨áë¢ ¥¬ ¢ buf 1
	mov	al,48	; ¨­ ç¥ § ¯¨áë¢ ¥¬ 
	mov	buf[si],al;!(ª®¤ ¥£® 48;)
	jmp	exxx	;ã¬ î ïá­®;)
ed:
	mov	al,49	  ; âãâ § ¯¨áë¢ ¥¬ ¥¤¥­¨çªã
	mov	buf[si],al; ¥¤¥­¨çª¨ ¢ ASCII 49	
exxx:
	pop	ax	;¤®áâ ¥¬  å
	inc	si	;¨¤¥¬ ­  á«¥¤ãîé¨© á¨¬¢®« áâà®ª¨	
loop	cycl		;¯®¢â®àï¥¬, ­ «¨¢ ¥¬
	POPA	
	RET
dec_to_bin	EndP

;**************************************
write	proc
PushA
;mov	si,8	;¢ si ¤«¨­  áâà®ª¨
mov	cx,8	;¢ áå â®¦¥
viv:
	mov	al,buf[si]	;®¡áâ¢¥­­® ¯®á¨¬¢®«ì­ë© ¢ë¢®¤ ­  íªà ­
	int	29h             ;áâà®ª¨.
	dec	si              ;âà®ªã ¢ë¢®¤¨¬ á ª®­æ .
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