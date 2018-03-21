stacksg segment para stack 'stack'      
stacksg ends
;---------------------------------
datasg segment 'data'
    hello   db "Hola mundo!!!", "$"
	;hello:   db "Hola mundo!!!", "$"
datasg ends
;---------------------------------
codesg segment 'code'  
    assume ds:datasg, cs:codesg, ss:stacksg, 

;Procedimientos...
;---------------------------------
;Imprimir string   
print_str  proc              			;Inicia proceso     
    
    mov ah, 9


            				;Funcion(imprimir string)
   lea   dx, hello         				;DX = String terminado en "$"
   ;mov   dx, offset hello         		;DX = String terminado en "$"
   int   21h               				;Interruptions DOS - Mensaje en pantalla
    
    mov ah,1        ; lee de pantalla y el reesultado queda en AL
	int 21h
	
   ret
print_str  endp              			;Termina proceso

;Inicio ejecucion programa	
start:      
    ;Se inicializan los registros de segmento
    mov ax,datasg
    mov ds,ax
    mov es,ax
   
	call print_str
	
	mov   ax,4c00h       				;Funcion terminar programa.
	int   21h            				;Interrupcion DOS 

codesg ends
end start