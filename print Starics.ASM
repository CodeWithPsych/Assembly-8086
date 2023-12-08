.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX


    ;SET COUNTERS
    MOV CH,0
    MOV DL,0
   OUTER:
    MOV CL,0
    INC DL
   INNER:
    INC CL    
    CMP CL,DL
    JNZ DISPLAY

    ;NEW LINE
    MOV DL,0AH
    MOV AH,02
    INT 21H
    MOV DL,0DH
    MOV AH,02
    INT 21H

    INC CH
    CMP CH,10
    JNZ OUTER

    JMP EXIT

DISPLAY:
    MOV DL,'*'
    MOV AH,02
    INT 21H
    JMP INNER
EXIT:
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
   

