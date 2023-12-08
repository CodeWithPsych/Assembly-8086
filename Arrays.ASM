.MODEL SMALL
.STACK 100H
.DATA
LINE DB 0AH,0DH,'$'
STR DB ? ; STR as array of one element
STR2 DB 10 DUP ('?') ; STR2 as array of 10 duplicate elements with undefined values.  
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA SI,STR
    MOV AH,01
INPUT:
    INT 21H
    MOV [SI],AL
    INC SI
    CMP AL,'$'
    JNZ INPUT

    LEA DX,LINE
    MOV AH,09
    INT 21H

    LEA SI,STR
    MOV BH,'$'
DISPLAY:
    MOV DL,[SI]
    MOV AH,02
    INT 21H
    INC SI
    CMP [SI],BH
    JNZ DISPLAY

    MOV AH,4CH
    INT 21H


MAIN ENDP
END MAIN 
