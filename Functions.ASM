
.MODEL SMALL
.STACK 100H
.DATA
MESSAGE DB "GO TO NEXT LINE $"
EXIT_MESSAGE DB "EXITING$"
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    LEA DX,MESSAGE
    MOV AH,09
    INT 21H

    MOV AH,01
    INT 21H

    CALL GO_TO_NEXTLINE
    CALL GO_TO_NEXTLINE

    MOV DL,AL
    MOV AH,02
    INT 21H

    LEA DX,EXIT_MESSAGE
    MOV AH,09
    INT 21H
EXIT:
    MOV AH,4CH
    INT 21H
MAIN ENDP

GO_TO_NEXTLINE PROC
PUSH AX

MOV DL,10
MOV AH,02
INT 21H
JMP EXIT

POP AX
RET
GO_TO_NEXTLINE ENDP
END MAIN






