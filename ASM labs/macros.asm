	.model	tiny
	.code
	org	100h
;-----------------------------------
Write	macro	viv
	mov	ah,9h
	lea	dx,viv
	int	21h		
ENDM
;-----------------------------------
Start:
	Write	viv1
	Ret
viv1	db	"Lenin",10,13,'$'

End Start