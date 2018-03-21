.stack          ; segmento de pila
          db      100h dup (?)        ; reserva 256 bytes 
.data     
mensaje   db      'Se ha cambiado el color de la pantalla$' ; el $ indica el fin.

.code 
         mov     ax,@data
         mov     ds,ax
         
         mov ah, 06h 
         mov bh, 9fh ;cambia el color de letra y fondo
         mov cx,0000h ;dond inicia en fila y columna a colorear
         mov dx,1819h  ;hasta que fila y columna llega coloreando
         int 10h       ;hasta fila 25(18h), columna 80(4Fh)
         
         mov ah, 06h 
         mov bh, 4fh ;cambia el color de letra y fondo
         mov cx,0019h ;dond inicia en fila y columna a colorear
         mov dx,184fh  ;hasta que fila y columna llega coloreando
         int 10h       ;hasta fila 25(18h), columna 80(4Fh)
         
         lea     dx,mensaje
         mov     ah,9h
         int     21h                    ; saca el mensaje por pantalla

         mov ax,4c00h
         int 21h
