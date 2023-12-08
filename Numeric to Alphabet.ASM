;You are given a number which represents the displacement, You have to print the relevant alphabet starting from 'a'
.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    ;INPUT A SINGLE NUMERIC CHARACTER

    MOV AH,01
    INT 21H

    SUB AL,30H
    ADD AL,41H
    MOV BL,AL

    MOV DL,10
    MOV AH,02
    INT 21H

    MOV DL,BL
    MOV AH,02
    INT 21H

    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
