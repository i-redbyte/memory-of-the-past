		.386p
		.model	Flat,	stdcall
		includelib	C:\ASM\kernel32.lib
;*****************************������� ������*************************
_data	segment	dword	public	use32	'data'
	mes1	db	"����� ���!",0
	mes2	db	"�� ����!",0
	hw	dword ?
;	mb_ok	equ 	0
_data	ends
;*****************************������� ����*************************
_text	segment	dword	public	use32	'code'
Start:
	push	0
	push	offset	mes1
	push	offset	mes2
	push	hw
	call	messageboxa@16
	ret
_text	ends
end	Start