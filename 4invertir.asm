;---------------------------------
;Programa de Ejemplo
;Lee una cantidad no mayor de la consola
;y lo almacena en una variable en el segmento de datos.
;Luego lo copia en otra variable en forma inversa y por
;ultimo lo imprime.
;
;No acepta caracteres especiales, como BACKSPACE, direccionales,
;TAB, etc...
;---------------------------------
stacksg segment para stack 'stack'
    dw 128 dup(0)        
stacksg ends

;---------------------------------
datasg segment 'data'
    s1 db 10 dup(?), '$'       
    s2 db 10 dup(?), '$'
datasg ends

;---------------------------------
codesg segment 'code'  
    assume ds:datasg, cs:codesg, ss:stacksg, 


inicio:      
    ;Primero se inicializan los registros de segmento
    mov ax,datasg
    mov ds,ax
    mov es,ax
    
    ;Ahora hay que leer un string dado por el usuario
    ;si se 
    ;presiona ENTER la lectura debe terminar.
    mov cx,10
    mov di,0
    leer_string:
        mov ah,1
        int 21h         ;Leer un caracter de la consola
        
        mov s1[di],al   ;Se mueve el caracter leido a s1
        inc di
        
        cmp al,13       ;Se compara el caracter leido con Enter
        je  copiar_string
        
        loop leer_string 
    
    ;Ahora se va a copiar el string leido en la variable S2 
    ;de forma inversa a como se leyo, para luego mostrarlo 
    ;en pantalla
    copiar_string:
        lea si,s1
        lea di,s2 + 9
        mov cx,10

        ;Ahora se copian los valores de s1 
        ;en s2 de forma inversa    
        intercambio:    
            mov bl,[si]
            mov [di],bl
            
            inc si
            dec di
            loop intercambio
        
        ;Se cambia de linea
        mov ah,2
        mov dl,13   ;Retorno de Carro 
        int 21h
        mov dl,10   ;Cambio de linea (ENTER)
        int 21h
        
        ;Se imprime el string en s2
        imprimir_string:
            lea dx,s2
            mov ah,09h
            int 21h
    
	
	
    ;Se termina el programa
    mov ah,4Ch
    int 21h

codesg ends
end inicio