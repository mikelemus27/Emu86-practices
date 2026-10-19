section .data
    num1 db 2       ; Primer número: 2 (8 bits)
    num2 db 2       ; Segundo número: 2 (8 bits)
    resultado dw 0  ; Variable de 16 bits para guardar el resultado final (4)

section .text
    global _start

_start:
    mov al, [num1]  ; Carga el primer 2 en el registro AL
    mov bl, [num2]  ; Carga el segundo 2 en el registro BL

    mul bl          ; Multiplica AL por BL (2 x 2). El resultado (4) se guarda en AX

    mov [resultado], ax ; Guarda el contenido de AX (4) en la variable 'resultado'

    ; Finalizar la ejecución (Linux 32 bits)
    mov eax, 1      ; sys_exit
    mov ebx, 0      ; Código de salida 0 (sin error)
    int 0x80        ; Interrupción para llamar al sistema