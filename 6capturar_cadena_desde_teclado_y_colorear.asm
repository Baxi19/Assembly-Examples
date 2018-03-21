;---------------------------------------------------------------------------------
datos     segment                   ; segmento de datos

aux     db   ?
i       db   1
j       db   1
max     db   25  ;cantidad maxima de caracteres a recibir
long    db   ?   ;cantidad de caracteres digitados
cadena  db  25 dup (' '), '$' ;guarda la cadena introducida
mens    db   'introducir cadena:$' ; el $ indica el fin.
linea   db   13,10,13,10,13,10,13,10,'$'
salida  db 'Pulse una tecla para salir...$'

datos     ends

;-----------------------------------------------------------------------------------
pila      segment stack 'stack'      ; segmento de pila
          dw      50h  dup (?)        ; reserva 2000 palabras de 16 bits, 4000 bytes
pila      ends
          
;------------------------------------------------------------------------------------

codigo    segment                          ; segmento de codigo
assume    cs:codigo,ds:datos,ss:pila

inicio:  
          call limpiar ; equivale a CLRSCR() de C
           
          mov ax,datos
          mov ds,ax
          xor si,si    ; pongo SI a 0


          lea dx,mens  ; imprime mensaje en pantalla 
          mov ah,09h
          int 21h                    

          lea dx,max   ; lee la cadena desde teclado 
          mov ah,0ah
          int 21h                

          LEA DX,LINEA ; imprime linea en blanco 
          MOV AH,9
          INT 21H      

     
          call color   ; pone color 

          lea si,cadena

SEGUIR:
        mov bh,[si] ;hola mundo
        mov aux,bh   

        cmp bh,0dh 
        je SALIR           
        ;02H Establece la posicion del cursor                           
        ;BH -> Numero de Pagina
        ;DH -> Fila (Renglon)
        ;DL -> Columna
        mov ah,2h    
        mov bx,01h
        mov dh,i
        mov dl,i
        int 10h  

        mov dl,aux   ; en dl esta el valor e imprimir en pantalla
        MOV AH,02H   ; imprime un caracter
        INT 21H

        inc si       ; incrementa indice del puntero a cadena
        inc i        ; incremento fila y columna
        inc j 
          
        jmp SEGUIR           

SALIR:   
          LEA DX,LINEA   ; imprime linea en blanco 
          MOV AH,9
          INT 21H 
          
          lea dx,mens  ; imprime mensaje en pantalla 
          mov ah,09h
          int 21h          
          
          LEA DX,LINEA   ; imprime linea en blanco 
          MOV AH,9
          INT 21H 
                
          LEA DX,SALIDA  ; despliega mensaje en pantalla 
          MOV AH,9
          INT 21H 

          MOV AH,07H     ; pulse una tecla...
          INT 21H

          mov ax,4c00h   ; sale a SO    
          int 21h

;-------------------------------------------------------------------------------
color proc near          ; funcion que pone color a texto

SIG1:
    cmp j,3
    je impr_VERDE
    jmp SIG2

impr_VERDE:
          mov bh,63
          mov j,0
SIG2:
    cmp j,2
    je impr_ROJO
    jmp SIG3 
    
impr_ROJO:
    mov bh,79

SIG3:
    cmp j,1
    je impr_AZUL
    jmp PONE_COLOR
    
impr_AZUL:
    mov bh,31

PONE_COLOR:     mov ax,0600h
                ;mov bh,12
                xor cx,cx
                mov dx,184fh
                int 10h
                ret
color endp
;-------------------------------------------------------------------------------
limpiar proc near      ;Borra la pantalla cambiando la modalidad de video
          mov ax,0600h   ;toda la pantalla
          mov bh,0fh     ;Fondo blanco, frente negro
          mov cx,0000h   ;desde fila 00, columna 00
          mov dx,184fh   ;hasta fila 25(18h), columna 80(4Fh)
          int 10h 
          ret
limpiar endp
;-----------------------------------------------------------------------------

codigo    ends
end     inicio                      


