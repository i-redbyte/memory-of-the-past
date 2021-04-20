		.model	tiny
		.code
		org	100h
Start:
		mov	cl,'F'
		call setbuffer
		mov	cl,'o'
		call setbuffer
		mov	cl,'r'
		call setbuffer
		mov	cl,'m'
		call setbuffer
		mov	cl,'a'
		call setbuffer
		mov	cl,'t'
		call setbuffer
		mov	cl,' '
		call setbuffer
		mov	cl,'c'
		call setbuffer
		mov	cl,':'
		call setbuffer
		mov	cl,10
		call setbuffer
		mov	cl,13
		call setbuffer
		Ret
setbuffer	proc
		mov	ah,5h
		mov	ch,0
		int	16h
		ret
setbuffer Endp

end Start