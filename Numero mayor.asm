;------------------------------------------------------------------------------
;Definicion del segmento de datos
;------------------------------------------------------------------------------
DATOS SEGMENT     
        ; 13 retorno de carro
        ; 10 alimentacion de linea
        digiteNumero db 13,10,'Digite un numero: ','$'
        NumeroMayor db 13,10,'El numero mayor es: ','$'
        NoEsNumero db 13,10, 'Digite solo numeros: ','$'
        NMayor db 13, 10, 0 , '$'
        Espacio db 13, 10, '$'  
        
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
        
        lea dx,digiteNumero
        mov ah, 9
        int 21h
        
        mov ah,1
        int 21h
        
        cmp al,nMayor
        jbe pedirNum2
        mov nMayor, al
        
pedirNum2:
        lea dx, digiteNumero
        mov ah,9
        int 21h
        
        mov ah,1
        int 21h
        
        cmp al,nMayor
        jbe pedirNum3
        mov nMayor, al  
        
pedirNum3: 
        lea dx, digiteNumero
        mov ah,9
        int 21h
        
        mov ah,1
        int 21h
        
        cmp al,nMayor
        jbe ImprimirMayor
        mov nMayor, al 
        
        
        mov digiteNumero ,al
        
ImprimirMayor:
        lea dx,numeroMayor
        mov ah,9
        int 21h
        
        mov ah,1
        int 21h
        
        lea dx,Espacio
        mov ah,9
        int 21h
        
        mov ah,1
        int 21h
        
        lea dx,nMayor
        mov ah,9
        int 21h
        
        mov ah,1
        int 21h
      
        

salir:
        mov  ax, 4C00h
        int  21h

CODE ENDS
        END START