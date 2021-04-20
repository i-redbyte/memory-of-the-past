;Лабораторная работа №7. Вариант №13
;Заполнить экран произвольной информацией. Перехватить
;прерывание 1ch, по нажатию клавиши '1' осуществить горизонтальный
;скроллинг всего экрана влево на один столбец, при нажатии 
;клавиши '2'- скроллинг вправо на один столбец.


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
;новый обоаботчик прерывания 1ch
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
;подпрограмма очистки экрана
cls proc near
   push ax
   push bx
   push cx
   push dx

   mov ax,00600h
   mov bh,07h               ; Атрбут выводимого символа
   mov cx,0                 ; Минимальная координата окна
   mov dx,0184Fh            ; Максимальная координата окна
   int 010h                 ; Вызов прерывания

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
;п/п вычисления адреса символа в видеопамяти
;вход:dl- y-координата
;     cl- x-координата
;выход:ax- адрес в памяти
address proc near
   push bx
   push cx
   push dx

   xor ax,ax        ;ax=0
   mov al,160       ;длина строки на экране в байтах
   mul dl           ;160*y
   add cx,cx        ;x=x*2 (символ + атрибут)
   add ax,cx        ;160*y+x

   pop dx
   pop cx
   pop bx
   ret
address endp
;------------------------------------------------


;------------------------------------------------
;п/п скроллинга
scrolling proc near
   push ax
   push bx
   push cx
   push dx

   push di
   push si
   
;-------------
;сравниваем начальную координату с нулем
   cmp start_position,0
;если начальная координата больше или равна нулю - переходим на метку
;GreaterEqual0 (скроллинг вправо)
   jge GreaterEqual0
   
;------------------------------------------------
;скроллинг влево 
   call cls
   mov cx,25                       ;число строк на экране
VerticalCycleLeft:
   push cx                         ;сохраняем счетчик внешнего цикла 
   mov dx,cx

   mov cx,80                       ;число символов на экране
   sub cl,current_position         ;уменьшаем длину цикла 
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
;вход:dl- y-координата
;     cl- x-координата
;выход:ax- адрес в памяти
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
;скроллинг вправо
GreaterEqual0:
   call cls
   mov cx,25                       ; Число строк на экране
VerticalCycleRight:
   push cx
   mov dx,cx

   mov cx,80
   sub cl,start_position           ; Уменьшаем длину цикла
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
;вход:dl- y-координата
;     cl- x-координата
;выход:ax- адрес в памяти
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

   ;настройка на начало видеопамяти
   mov ax,0b800h
   mov es, ax

   ;проверка нажатия клавиши
   mov ah,0bh
   int 21h

   cmp al,0ffh       ;если клавиша не нажата
   jne exit_int      ;то выходим и п/п

   ;получаем нажатую клавишу
   mov ah,08h
   int 21h
   mov Key,al
   cmp al,'1'      ;сравниваем нажатую клавишу с 1
   jne chk_press_2

   ;-------------------
   ;обработка нажатия 1
     dec start_position
     cmp start_position,0
     jge bolshe_zero1
   ;если start_position меньше нуля, то получаем его модуль и сохраняем в current_position
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
   ;обработка нажатия 2
     inc start_position
     cmp start_position,0
     jge bolshe_zero2
   ;если start_position меньше нуля, то получаем его модуль и сохраняем в current_position
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
;основная программа
start:
   mov ax, data
   mov ds, ax

;вывод преглашения   
   mov ah,09h
   lea dx,vvod_str
   int 021h

EnterText:
   ;ввод текста
   mov ah,0ah
   lea dx,stroka
   int 21h

   ;переход на новую строку
   mov ah,09h
   lea dx,new_str
   int 21h

   ;проверка
   cmp stroka[1],0
   je EndEnter

   jmp EnterText

EndEnter:
   mov ax,0b800h
   mov es,ax


;сохраняем содержимое экрана
   mov cx,4000
   xor si,si
   xor di,di
save_screan:
   mov al,byte ptr es:[si]        ;в al байт из видеопамяти
   mov video_buffer[di],al        ;сохраняем байт из al в буфере
   inc si
   inc di
   loop save_screan


;адрес старой подпрогаммы обработки прерывания
   mov ah,35h
   mov al,01Ch
   int 21h

;сохраняем сегмент и смещение старого вектора прерывания
   mov old_cs,es
   mov old_ip,bx

;устанавливаем новый вектор
   push ds

   mov dx,offset new_1c
   mov ax,seg new_1c

   mov ds,ax
   mov ah,25h
   mov al,1ch
   int 21h

   pop ds

   ;перехват прерывания, проверка нажатой клавиши
waiting_keystroke:
   cmp Key,48         ;если нажат 0- выходим из программы
   je quit
   jmp waiting_keystroke


quit:
;восстанавливаем старый вектор
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
