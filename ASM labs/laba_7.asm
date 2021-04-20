; �������� � ���� ����� ������ �������� ������ �� ��� ��� ���� �� ����� �����; 
; ������ ������. ������ ��� ������ ������� ������� ���������� �� 1 �� 15. ���  ;
; ������� ������� ������� ������������ ������ 1Ch.                             ;
;==============================================================================;

; ������� �����
stk segment stack
    db 0100h dup (?)
stk ends
;---------------------------------

; ������� ������
data segment
Old_1C_seg dw (?)      ; ������� ������� ����������� ������� 1Ch
Old_1C_offs dw (?)     ; �������� ������� ����������� ������� 1Ch

; ���������� ������
YCoord dw 5            ; ������������ ����������
XCoord db 20           ; �������������� ����������
ElemSize db 2          ; ����� ���� ��� ���� ������ �� ������
Symbol db (?)          ; ������ ��� ������
data ends
;---------------------------------

; ������� ����
code segment
assume cs: code, ds: data, ss: stk

;-------------------------------------------------------------------------------
; ���������� ���������� 1Ch
proc Int_1C_proc far 
; ��������� ������ �� ��������� � �����
push ax
push bx
push cx
push dx

push ds

; ��������� �� ������� ������ ���������
mov ax, data
mov ds, ax

; ���� �� ������ ������ �� ����������
mov ah, 0Bh
int 21h

cmp al, 0FFh       ; ���� ������� ��� �� ������� �� ����������
jne No_Symb

mov ah, 08h        ; ������� ������ �� ������ ����������
int 21h
mov Symbol, al


No_Symb:

; ������������ �������� �� �����
pop ds

pop dx
pop cx
pop bx
pop ax

iret    ; ������� �� ����������
Int_1C_proc endp
;-------------------------------------------------------------------------------
; ����� ����� � �������� ���������
start:
; ��������� �� ������� ������ ���������
mov ax, data
mov ds, ax


;---------------
; �������� ����� ������ ����������� ��������� ����������
mov ah, 35h
mov al, 01Ch
int 21h

; ��������� ������� � �������� ������� ������� ����������
mov Old_1C_seg, es
mov Old_1C_offs, bx

;---------------
;������������� ����� ������

push ds

mov dx, offset Int_1C_proc 
mov ax, seg Int_1C_proc

mov ds, ax
mov ah, 25h
mov al, 1ch
int 21h

pop ds

mov ax,  0B800h
mov es, ax   	  ; � ES ������ ����������� � ��������� ������

xor cx, cx        ; CX = 0
mov cl, XCoord    ; � CL �������������� ���������� ������ �������
xor bx, bx        ; BX = 0
inc bh            ; BH = 1 (������� ���������� �������)

Infinity_Loop:
; ��������� ���������� ������� � ������
xor ax, ax        ; AX = 0
mov al, 80        ; ����� �������� � ������
mul ElemSize      ; 80*2 (�������� �� ������ ��������)
mul YCoord        ; 160*Y
add ax, cx        ; 160*Y + X
mov di, ax        ; DI = AX
mov bl, Symbol    ; � BL �������� ��������� ������

mov ES:[di], bx   ; ����� ������� �� �����

cmp bh, 15        ; ���������� bh � 15 (������� ���������� �������)
jl Less           ; ���� ������ 15 - ��������� �� ����� Less
mov bh, 1         ; bh = 1
Less:
inc bh            ; ����������� bh �� 1

cmp Symbol, 27    ; ���� ��� ����� Escape - ������� �� ���������
je quit
jmp Infinity_Loop

; ����� �� ���������
quit:
; ��������������� ������ ������
push ds
mov dx, Old_1C_offs
mov ax, Old_1C_seg
mov ds, ax
mov ah, 25h
mov al, 1ch
int 21h

pop ds

mov ax, 04C00h
int 021h

code ends
end start
��

������ ���� mov ES: [di]