;Lecture 11
.MODEL SMALL
.STACK 100H
.DATA
ORG 0200 ;data in DS will start to allocate from the mentioned location. 
VAR1 DB 0AH	;define var1 of one byte
VAR2 DW 0FFABH, 0978H	; define VAR2 of one word(16 bits)
VAR3 DQ 
LINE DB 0AH,0DH,'$'
MYSYS EQU 7 
STR DB ? ; STR as array of one element
STR2 DB 10 DUP (MYSYS) ; STR2 as array of 10 duplicate elements with MYSYS value (which is 7).  
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
