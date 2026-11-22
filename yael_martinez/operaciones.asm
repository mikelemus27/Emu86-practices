
org 100h

; ---------- SUMA ----------
mov dx, offset msg_sum
call print_str
mov cx, 5
mov al, 0
mov bx, 0
n1: add al, vector[bx]
    inc bx
loop n1
call show

; ---------- RESTA ----------
mov dx, offset msg_sub
call print_str
mov cx, 4
mov al, vector[0]      ; empieza con el primer elemento
mov bx, 1
n2: sub al, vector[bx]
    inc bx
loop n2
call show

; ---------- MULTIPLICACION ----------
mov dx, offset msg_mul
call print_str
mov cx, 5
mov al, 1
mov bx, 0
n3: mul vector[bx]     ; ax = al * vector[bx]
    inc bx
loop n3
call show

; ---------- DIVISION ----------
mov dx, offset msg_div
call print_str
mov cx, 4
mov al, vector[0]      ; dividendo inicial
mov bx, 1
n4: mov ah, 0          ; limpiar el resto anterior
    div vector[bx]     ; al = ax / vector[bx]
    inc bx
loop n4
call show

; esperar una tecla:
mov ah, 0
int 16h

ret

; variables:
vector db 12, 2, 1, 3, 1
m db 0
msg_sum db 'Suma:           $'
msg_sub db 'Resta:          $'
msg_mul db 'Multiplicacion: $'
msg_div db 'Division:       $'


; imprime el texto apuntado por dx (termina en '$')
print_str proc
    mov ah, 9
    int 21h
    ret
endp


; muestra al en binario y en decimal
show proc
    mov m, al

    ; binario:
    mov bl, m
    mov cx, 8
print: mov ah, 2
       mov dl, '0'
       test bl, 10000000b
       jz zero
       mov dl, '1'
zero:  int 21h
       shl bl, 1
loop print
    mov dl, 'b'
    int 21h
    mov dl, ' '
    int 21h
    int 21h

    ; decimal:
    mov al, m
    call print_al

    ; nueva linea:
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    ret
endp


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
endp


