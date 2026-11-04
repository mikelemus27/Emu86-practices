name "calc-ops"

org 100h ; directive make tiny com file.

; ========================================================
; SUMA: res_add = num1 + num2
; ========================================================
mov al, num1
add al, num2
mov res_add, al

; Imprimir mensaje de suma:
mov dx, offset msg_add
mov ah, 9
int 21h

; Imprimir resultado en decimal:
mov al, res_add
call print_al
call new_line


; ========================================================
; RESTA: res_sub = num1 - num2
; ========================================================
mov al, num1
sub al, num2
mov res_sub, al

; Imprimir mensaje de resta:
mov dx, offset msg_sub
mov ah, 9
int 21h

; Imprimir resultado en decimal:
mov al, res_sub
call print_al
call new_line


; ========================================================
; MULTIPLICACION: res_mul = num1 * num2
; ========================================================
mov al, num1
mov bl, num2
mul bl          ; ax = al * bl
mov res_mul, ax ; almacena resultado de 16 bits

; Imprimir mensaje de multiplicacion:
mov dx, offset msg_mul
mov ah, 9
int 21h

; Imprimir resultado en decimal:
mov al, byte ptr res_mul
call print_al
call new_line


; ========================================================
; DIVISION: al = num1 / num2, ah = num1 % num2
; ========================================================
mov al, num1
mov ah, 0       ; limpiar parte alta para division de 8 bits
mov bl, num2
div bl          ; al = cociente, ah = residuo
mov res_div, al
mov res_mod, ah

; Imprimir mensaje de cociente:
mov dx, offset msg_div
mov ah, 9
int 21h

; Imprimir cociente en decimal:
mov al, res_div
call print_al
call new_line

; Imprimir mensaje de residuo:
mov dx, offset msg_mod
mov ah, 9
int 21h

; Imprimir residuo en decimal:
mov al, res_mod
call print_al
call new_line


; ========================================================
; ESPERAR TECLA Y TERMINAR
; ========================================================
mov ah, 0
int 16h

ret

; ========================================================
; VARIABLES Y MENSAJES
; ========================================================
num1    db 20
num2    db 4

res_add db 0
res_sub db 0
res_mul dw 0
res_div db 0
res_mod db 0

msg_add db "Suma: $"
msg_sub db "Resta: $"
msg_mul db "Multiplicacion: $"
msg_div db "Division (Cociente): $"
msg_mod db "Residuo: $"


; ========================================================
; PROCEDIMIENTO: SALTO DE LINEA
; ========================================================
new_line proc
    mov ah, 2
    mov dl, 0dh ; retorno de carro
    int 21h
    mov dl, 0ah ; salto de linea
    int 21h
    ret
new_line endp


; ========================================================
; PROCEDIMIENTO: IMPRIMIR REGISTRO AL EN DECIMAL
; ========================================================
print_al proc
    cmp al, 0
    jne print_al_r
    push ax
    mov al, '0'
    mov ah, 0eh
    int 10h
    pop ax
    ret 
print_al_r:     
    pusha
    mov ah, 0
    cmp ax, 0
    je pn_done
    mov dl, 10
    div dl      
    call print_al_r
    mov al, ah
    add al, 30h
    mov ah, 0eh
    int 10h     
    jmp pn_done
pn_done:
    popa  
    ret  
print_al endp