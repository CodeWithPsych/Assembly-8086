;Loop, JNZ
.MODEL SMALL
.STACK 100H
.DATA
mansoor db "carry bhains$"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV BL,0
    MOV CL,08
LOOP_C:
    MOV AH,01
    INT 21H
    cmp al,'0'
    jnz check_one
conversion:
    MOV BH,AL
    MOV DL,BH
    AND DL,01
    SHR DL,1
    RCL BL,1
    jmp loop_exit
check_one:
    cmp al,'1'
    jnz loop_c
    jmp conversion
loop_exit:
    DEC CL
    JNZ LOOP_C
    MOV DL,BL
    MOV AH,02
    INT 21H 

    mov ah,4ch
    int 21h
MAIN ENDP
END MAIN
