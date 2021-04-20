		.model	tiny
		.code
		org	100h
Start:
		mov	ax,0010h
		int	10h
		mov	bh,0
		mov	ah,0Ch
		mov	si,120
		mov	di,50
		mov	al,13
		mov	dx,10
		mov	cx,30
Cycl:
		int	10h
		inc	cx
		dec	si
		jnz	cycl
		inc	dx
		mov	cx,30
		mov	si,120
		dec	di
		jnz	cycl
		mov	cx,64
		mov	ah,1000h
		mov	bl,13
		mov	bh,0
loo:
		push	ax
		xor	ah,ah
		int	16h
		cmp	al,27
		pop	ax
		jz	
		ret
End Start