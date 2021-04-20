;������������ ������ �7. ������� �13
;��������� ����� ������������ �����������. �����������
;���������� 1ch, �� ������� ������� '1' ����������� ��������������
;��������� ����� ������ ����� �� ���� �������, ��� ������� 
;������� '2'- ��������� ������ �� ���� �������.


data segment
   stroka db 80, ?, 81 dup(0), "$"
   vvod_str db "Vvedite proizvol'nyjy informachijy. Konech vvoda- pystaja stroka:",10,13,"$"
   new_str db 10,13,"$"
     
   old_cs dw (?)
   old_ip dw (?)

   Key db 0
   start_position db 0
   current_position db 0
   CurX db 0

   video_buffer db 4000 dup (?)
data ends


code segment
assume cs:code,ds:data

;------------------------------------------------
;����� ���������� ���������� 1ch
new_1c proc far
   push ax
   push bx
   push cx
   push dx

   push di
   push si

   push ds

   jmp begin_int

;------------------------------------------------
;������������ ������� ������
cls proc near
   push ax
   push bx
   push cx
   push dx

   mov ax,00600h
   mov bh,07h               ; ������ ���������� �������
   mov cx,0                 ; ����������� ���������� ����
   mov dx,0184Fh            ; ������������ ���������� ����
   int 010h                 ; ����� ����������

   mov dx,0
   mov ah,02h
   xor bh,bh
   int 010h

   pop dx
   pop cx
   pop bx
   pop ax

   ret
cls endp
;------------------------------------------------

;------------------------------------------------
;�/� ���������� ������ ������� � �����������
;����:dl- y-����������
;     cl- x-����������
;�����:ax- ����� � ������
address proc near
   push bx
   push cx
   push dx

   xor ax,ax        ;ax=0
   mov al,160       ;����� ������ �� ������ � ������
   mul dl           ;160*y
   add cx,cx        ;x=x*2 (������ + �������)
   add ax,cx        ;160*y+x

   pop dx
   pop cx
   pop bx
   ret
address endp
;------------------------------------------------


;------------------------------------------------
;�/� ����������
scrolling proc near
   push ax
   push bx
   push cx
   push dx

   push di
   push si
   
;-------------
;���������� ��������� ���������� � �����
   cmp start_position,0
;���� ��������� ���������� ������ ��� ����� ���� - ��������� �� �����
;GreaterEqual0 (��������� ������)
   jge GreaterEqual0
   
;------------------------------------------------
;��������� ����� 
   call cls
   mov cx,25                       ;����� ����� �� ������
VerticalCycleLeft:
   push cx                         ;��������� ������� �������� ����� 
   mov dx,cx

   mov cx,80                       ;����� �������� �� ������
   sub cl,current_position         ;��������� ����� ����� 
   dec cl

   xor di,di
   xor si,si
   xor bx,bx
   mov CurX,0
   
HorizCycleLeft:
   push cx
   mov ax,80
   sub ax,cx
   mov cx,ax

;address
;����:dl- y-����������
;     cl- x-����������
;�����:ax- ����� � ������
   dec cl
   dec dl
   call address
   inc cl
   inc dl
   mov si,ax

   mov cl,CurX
   dec dl
   call address
   inc CurX
   inc dl
   mov di,ax

   mov ax,word ptr video_buffer[si]
   mov word ptr es:[di],ax
   pop cx
   loop HorizCycleLeft

   pop cx
   loop VerticalCycleLeft

   jmp EndPrint
   
;------------------------------------------------
;��������� ������
GreaterEqual0:
   call cls
   mov cx,25                       ; ����� ����� �� ������
VerticalCycleRight:
   push cx
   mov dx,cx

   mov cx,80
   sub cl,start_position           ; ��������� ����� �����
   dec cl

   xor di,di
   xor si,si
   xor bx,bx
   mov CurX,0
   
HorizCycleRight:
   push cx
   mov ax,80
   sub ax,cx
   mov cx,ax

;address
;����:dl- y-����������
;     cl- x-����������
;�����:ax- ����� � ������
   dec cl
   dec dl
   call address
   inc cl
   inc dl
   mov si,ax

   mov cl,CurX
   dec dl
   call address
   inc CurX
   inc dl
   mov di,ax

   mov ax,word ptr video_buffer[di]
   mov word ptr es:[si],ax
   pop cx

   loop HorizCycleRight
   
   pop cx
   loop VerticalCycleRight

EndPrint:
;--------------------------------
   pop si
   pop di

   pop dx
   pop cx
   pop dx
   pop ax

   ret
scrolling endp
;------------------------------------------------


begin_int:
   mov ax,data
   mov ds,ax

   ;��������� �� ������ �����������
   mov ax,0b800h
   mov es, ax

   ;�������� ������� �������
   mov ah,0bh
   int 21h

   cmp al,0ffh       ;���� ������� �� ������
   jne exit_int      ;�� ������� � �/�

   ;�������� ������� �������
   mov ah,08h
   int 21h
   mov Key,al
   cmp al,'1'      ;���������� ������� ������� � 1
   jne chk_press_2

   ;-------------------
   ;��������� ������� 1
     dec start_position
     cmp start_position,0
     jge bolshe_zero1
   ;���� start_position ������ ����, �� �������� ��� ������ � ��������� � current_position
     mov al,start_position
     neg al
     mov current_position,al
     
   bolshe_zero1:
     call scrolling
     jmp exit_int
   ;-------------------  

chk_press_2:
   cmp al,'2'
   jne exit_int

   ;-------------------
   ;��������� ������� 2
     inc start_position
     cmp start_position,0
     jge bolshe_zero2
   ;���� start_position ������ ����, �� �������� ��� ������ � ��������� � current_position
     mov al, start_position
     neg al
     mov current_position, al
     
   bolshe_zero2:
     call scrolling
   ;-------------------  


exit_int:
   pop ds

   pop si
   pop di

   pop dx
   pop cx
   pop bx
   pop ax

   iret
new_1c endp
;------------------------------------------------


;------------------------------------------------
;�������� ���������
start:
   mov ax, data
   mov ds, ax

;����� �����������   
   mov ah,09h
   lea dx,vvod_str
   int 021h

EnterText:
   ;���� ������
   mov ah,0ah
   lea dx,stroka
   int 21h

   ;������� �� ����� ������
   mov ah,09h
   lea dx,new_str
   int 21h

   ;��������
   cmp stroka[1],0
   je EndEnter

   jmp EnterText

EndEnter:
   mov ax,0b800h
   mov es,ax


;��������� ���������� ������
   mov cx,4000
   xor si,si
   xor di,di
save_screan:
   mov al,byte ptr es:[si]        ;� al ���� �� �����������
   mov video_buffer[di],al        ;��������� ���� �� al � ������
   inc si
   inc di
   loop save_screan


;����� ������ ����������� ��������� ����������
   mov ah,35h
   mov al,01Ch
   int 21h

;��������� ������� � �������� ������� ������� ����������
   mov old_cs,es
   mov old_ip,bx

;������������� ����� ������
   push ds

   mov dx,offset new_1c
   mov ax,seg new_1c

   mov ds,ax
   mov ah,25h
   mov al,1ch
   int 21h

   pop ds

   ;�������� ����������, �������� ������� �������
waiting_keystroke:
   cmp Key,48         ;���� ����� 0- ������� �� ���������
   je quit
   jmp waiting_keystroke


quit:
;��������������� ������ ������
   push ds
   mov dx,old_ip
   mov ax,old_cs
   mov ds,ax
   mov ah,25h
   mov al,1ch
   int 21h

   pop ds

   mov ax,4C00h
   int 21h
code ends
end start
