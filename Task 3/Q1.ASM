.MODEL SMALL
.STACK 100H
.DATA
    MSG  DB "TAKING 1234 AS A DIGIT $"
    MSG1 DB 0DH, 0AH, "1:DECIMAL OUTPUT: $"
    MSG2 DB 0DH, 0AH, "2:HEXA_DECIMAL OUTPUT: $"
    MSG3 DB 0DH, 0AH, "3:BINARY OUTPUT: $"
    MSG4 DB 0DH, 0AH, "4:ENTER THE BINARY: $"
    MSG5 DB 0DH, 0AH, "5:ENTER THE HEXA: $"
    MSG6 DB 0DH, 0AH, "6:ENTER THE DECIMAL: $"
    ERR DB 0DH, 0AH, "INVALID INPUT TRY AGAIN: $"   
    
    ;bin_out data:
    c1 db 16
    shifting db 0 
    space db 4
   
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS, AX
    LEA AX, MSG
    MOV DX, AX
    MOV AH, 09
    INT 21H
    CALL DEC_OUTPUT
    CALL HEX_OUTPUT
    CALL BIN_OUTPUT
    CALL BIN_INPUT 
    CALL HEXI
    CALL DECIMAL
EXIT:
    MOV AH,4CH
    INT 21H
MAIN ENDP

; PART 1
DEC_OUTPUT PROC
    LEA AX, MSG1
    MOV DX, AX
    MOV AH, 09
    INT 21H
    MOV AX, 1234
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX,CX
    MOV BH,10
AGAIN:
    DIV BH  
    PUSH AX
    INC CX
    XOR AH,AH
    CMP AL,00
    JNZ AGAIN
    mov ah,02
DISPLAY:
    POP DX
    MOV DL,DH
    ADD DL,'0'
    INT 21H
    LOOP DISPLAY

    POP DX
    POP CX
    POP BX
    POP AX
RET
DEC_OUTPUT ENDP

;part 2
HEX_OUTPUT PROC
    LEA AX, MSG2
    MOV DX, AX
    MOV AH, 09
    INT 21H
    MOV AX, 1234
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    XOR CX, CX
    MOV BH, 16

DIVIDE_AGAIN:
    DIV BH
    PUSH AX
    INC CX
    XOR AH, AH
    CMP AL, 00
    JNZ DIVIDE_AGAIN

DISPLAY_HEX:
    POP DX
    MOV DL, DH
    CMP DL, 10
    JB HEX_LESS_THAN_10
    ADD DL, 'A' - 10
    JMP HEX_DISPLAY_CHAR

HEX_LESS_THAN_10:
    ADD DL, '0'

HEX_DISPLAY_CHAR:
    MOV AH, 02
    INT 21H
    LOOP DISPLAY_HEX

    POP DX
    POP CX
    POP BX
    POP AX
    RET
HEX_OUTPUT ENDP

;PART 3
BIN_OUTPUT PROC
    LEA dX, MSG3
    MOV AH, 09
    INT 21H
    
    MOV AX, 1234

    mov bx,ax      
xor cx,cx
loopy:
mov ax,bx
shr ax,cl
and al,1
push ax
inc shifting
mov cl,shifting 

dec c1
jnz loopy 

;printin
mov ah,2

prin: 
pop dx
add dx,48
int 21h
dec space
jz space1 
dec shifting
jnz prin

e:
jmp end1

space1:
mov dl,32
int 21h
add space,4
dec shifting
jz e 
mov bl,shifting
jmp prin

end1:

RET
BIN_OUTPUT ENDP

; PART 4
BIN_INPUT PROC
    LEA AX, MSG4
    MOV DX, AX
    MOV AH, 09
    INT 21H 
    MOV CX, 8
INPUT:
    MOV AH, 01
    INT 21H
    CMP AL, '1'
    JE NEXT
    CMP AL, '0'
    JE NEXT
    ; RESET THE COUNT
    MOV CX, 8
DISPLAY_ERROR:
    MOV AH, 09
    MOV DX, OFFSET ERR
    INT 21H
    JMP INPUT
NEXT:
    DEC CX
    CMP CX, 0
    JE EXIT_1
    JMP INPUT
EXIT_1:
RET
BIN_INPUT ENDP

; PART 5
HEXI PROC
    LEA AX, MSG5
    MOV DX, AX
    MOV AH, 09
    INT 21H 

    MOV CX, 2
INPUT1:
    MOV AH, 01
    INT 21H
    CMP AL, '0'
    JB DISPLAY_ERROR1
    CMP AL, '9'
    JBE NEXT1
    CMP AL, 'A'
    JB DISPLAY_ERROR1
    CMP AL, 'F'
    JBE NEXT1
    CMP AL, 'a'
    JB DISPLAY_ERROR1
    CMP AL, 'f'
    JBE NEXT1

DISPLAY_ERROR1:
    MOV AH, 09
    MOV DX, OFFSET ERR
    INT 21H
    JMP INPUT1

NEXT1:
    DEC CX
    CMP CX, 0
    JE EXIT_2
    JMP INPUT1

EXIT_2:
RET
HEXI ENDP

; PART 6
DECIMAL PROC
    LEA AX, MSG6
    MOV DX, AX
    MOV AH, 09
    INT 21H 

    MOV CX, 4
INPUT2:
    MOV AH, 01
    INT 21H
    CMP AL, '0'
    JB DISPLAY_ERROR2
    CMP AL, '9'
    JBE NEXT2

DISPLAY_ERROR2:
    MOV AH, 09
    MOV DX, OFFSET ERR
    INT 21H
    JMP INPUT2

NEXT2:
    DEC CX
    CMP CX, 0
    JE EXIT_3
    JMP INPUT1

EXIT_3:
RET
DECIMAL ENDP

END MAIN
