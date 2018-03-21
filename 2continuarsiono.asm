
 INCLUDE MACROSPALIN.LIB
;------------------------------------------------------------------------------
;Definicion del segmento de datos
;------------------------------------------------------------------------------
DATOS SEGMENT           
        espacio db 10,13,'$' ; 10 alimentacion de linea 13 retorno de carro
        caracter db 13,10,'Digite el caracter que desee para jugar: ','$'
        continuando db '    Continuando...',13,10,'$';Mensaje
        jugador db 1 dup(?),"$" 
DATOS ENDS

;------------------------------------------------------------------------------
;Definicion del segmento de pila
;------------------------------------------------------------------------------
PILA SEGMENT STACK "STACK"
      db 40h dup(?)
PILA ENDS

;------------------------------------------------------------------------------
;Definicion del segmento de codigo
;------------------------------------------------------------------------------
CODE SEGMENT
        assume CS:code, DS:datos, SS:pila

START:  
        mov  ax,datos
        mov  ds,ax
        jmp  continuar             ;Saltamos a la etiqueta CONTINUAR

INICIO:
        lea  dx,continuando        ;
        mov  ah,9                  ;
        int  21h                   ;Mensaje de que seguimos en el programa
        jmp  cargar_datos             ;Salto para preguntar si se desea continuar


CONTINUAR:
        lea  dx,caracter  ;
        mov  ah,9               ;
        int  21h                ;Mostrar pregunta para ver si desea continuar
        
        mov ah,1                ;Esperar a que se pulse una tecla
        int 21h                 ;y mostrarla por pantalla
        
        mov bl,al
        mov si,0
        mov jugador[si], bl
        
        lea  dx,espacio  ;
        mov  ah,9               ;
        int  21h
        
        lea  dx,jugador  ;
        mov  ah,9               ;
        int  21h                ;Mostrar pregunta para ver si desea continuar
        
        
        jmp  INICIO           ;Brincamos a la etiquera inicio      

cargar_datos:
    main proc
        mov ax,0003h
        int 10h 
          

;###################################################################

Pocision proc  
    
;###################################################################
            Centrar_Cursor:
                    mov ah,02h  ; permite establecer la pocicion
                    mov dh,0ch ; fila
                    mov dl,28h; Columna
                    int 10h
            
            
                    
            ImprimeJugador:
                    mov ah,0eh
                    mov bx,0071h
                    mov al,jugador ;carga al jugador
                    int 10h
       

          
        
salir:
        mov  ax, 4C00h
        int  21h

CODE ENDS
        END START