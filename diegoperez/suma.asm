section .data
    num1 db 15          ; Definimos el primer número (15)
    num2 db 27          ; Definimos el segundo número (27)
    resultado db 0      ; Variable para almacenar el resultado

section .text
    global _start

_start:
    ; 1. Cargar el primer número en el registro AL (8 bits)
    mov al, [num1]

    ; 2. Sumar el segundo número al registro AL
    add al, [num2]

    ; 3. Guardar el resultado acumulado en la variable 'resultado'
    mov [resultado], al

    ; 4. Finalizar el programa (Llamada al sistema para salir en Linux x86)
    mov eax, 1          ; Código de llamada al sistema 'sys_exit'
    xor ebx, ebx        ; Estado de salida 0
    int 0x80            ; Interrupción para ejecutar la llamada al sistema