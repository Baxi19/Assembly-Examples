INCLUDE macrospalin.lib

.stack
DB 128 DUP(0)
;---------------------------------------------
;              DATOS
;---------------------------------------------
.data      
        ;  ษ400 ป431 บ423 ผ428 อ470 ฯ 216 
        var db 201 
        mensaje0 DB '                               ษออออออออออออออป$'
        mensaje1 DB 'ษอออออออออออออออออออออออออออออนฯฯBIENVENIDOฯฯฬอออออออออออออออออออออออออออออออป$'
        msj      DB 'บ                             ศออออออออออออออผ                               บ$'           
        msj1     DB 'ฬออออออออออออออออออป                                                         บ$'
        mensaje2 DB 'บINGRESE LA CADENA:ฬอออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ$'
        msj2     DB 'ศออออออออออออออออออผ$'
        maximo_caracteres DB 40  ;maximo de caracteres a introducir
        lencad DB 0
        cadena DB 40 DUP(0)
        girat DB 40 DUP(0)
        linea_en_blanco  DB 10,13,'$'
        mensaje4 DB 'LA CADENA CAMBIADA ES:$'
        mensaje5 DB 'PRESIONE ENTER PARA SEGUIR...$'
        mensaje3 DB 'DESEA SALIR DEL PROGRAMA? (S/N)$'
        maximo_caracteres2 DB 2         ;longitud mแxima.
        lencad2 DB 0                    ;longitud leida.
        cadena2 DB 2 DUP(0)             ;buffer que contendrแ el texto introducido.


;---------------------------------------------
;              SEGMENTO
;---------------------------------------------
.code
        mov ax,@data
        mov ds,ax
;-----------------------------------------
;              INICIO
;-----------------------------------------

INICIO:
       
        LIMPIAR 0Fh
        GOTOXY 0,0
        IMPRIME mensaje0
        GOTOXY 1,2
        IMPRIME msj
        GOTOXY 1,3
        IMPRIME msj1
        GOTOXY 1,5
        IMPRIME msj2   
        GOTOXY 1,1
        IMPRIME mensaje1
        GOTOXY 1,4
        IMPRIME mensaje2                ;pide que se introduzca un mensaje y lo guarda en MAXIMO_CARACTERES
        GOTOXY 22,5
        LEE maximo_caracteres
        imprime linea_en_blanco  ;imprime lina en blanco
        mov bx,0                        ;pone el registro bx a 0

;----------------------------------------
;              PROCEDIMIENTOS
;----------------------------------------
       
pushpila:
        mov al, cadena[bx]            ;movemos la cadena introducida a al
        push ax
        inc bl
        cmp bl, lencad      ;hacemos la comparacion para que el proceso se repita mientras bl no sea 0
        jne pushpila       
        mov bx, 0
poppila:
        pop ax
        mov girat[bx], al              ;extraemos la cadena del registro ax
        inc bl        ;incrementamos el registro bl para comparar con lencad
        cmp bl,lencad
        jne poppila               ;si el registro bl no es = que el valor de lencad repetimos el proceso
        ;mov girat[bx], '$'
        GOTOXY 24,9
        imprime girat
        IMPRIME linea_en_blanco
       
        GOTOXY 1,9
        IMPRIME mensaje4
        GOTOXY 25,14
        IMPRIME mensaje5
        LEE maximo_caracteres2
        IMPRIME linea_en_blanco

        GOTOXY 24,15
        IMPRIME mensaje3
        GOTOXY 39,17
        LEE maximo_caracteres2
        IMPRIME linea_en_blanco

;---------------------------------------
;              OPCION DE SALIDA
;---------------------------------------

        cmp cadena2[0],'s'
        je salir
        cmp cadena2[0],'S'
        je salir
        jmp inicio
salir:
        mov ax,4c00h
        int 21h

;---------------------------------------
;                FIN
;---------------------------------------
