.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'THE ENTERED VALUE IS GREATER THEN 9$'
MSG2 DB 'THE ENTERED VALUE IS NOT GREATER THAN 9$'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV AH,01
    INT 21H

    MOV BL,AL
    CMP BL,'9'
    JAE PRINT
    MOV AH,09
    MOV DX,OFFSET MSG2
    INT 21H
    JMP EXIT
  PRINT:
    MOV AH,09
    MOV DX,OFFSET MSG1
    INT 21H
  EXIT:
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
