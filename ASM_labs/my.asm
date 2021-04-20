	.model	tiny
	.code
	org	100h
Start:
	mov	bx,5
	mov	ax,1	
	mul	bx	
	cmp	ax,10
	jne	exit
	mov	ah,9h
	lea	dx,text
	int	21h
exit:
	ret
text	db "Lenin",10,13,'$'
End Start