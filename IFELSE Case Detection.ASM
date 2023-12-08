.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'YOU PRESSED A NUMERIC CHARACTER$'
    MSG2 DB 'YOU pressed a special CHARACTER$'
    MSG3 DB 'YOU PRESSED A CAPITAL LETTER$'
    MSG4 DB 'YOU PRESSED A SMALL LETTER$'

.CODE
MAIN PROC
    mov ax,@data
    mov ds,ax

    MOV AH,01
    INT 21H

    CMP AL,'0'
    JAE CHECK_NUMERIC
  CAPITAL:
    CMP AL,'A'
    JB PRINT_MSG2
    JAE CHECK_ALPHABET
    
 SMALL:
    CMP AL,'a'
    JB PRINT_MSG2
    JAE CHECK_SMALL
    
    PRINT_MSG1:
        MOV AH,02
        MOV DL,10
        INT 21H
    
        MOV AH,09
        MOV DX,OFFSET MSG1
        INT 21H     
        JMP EXIT

    PRINT_MSG2:
        MOV AH,02
        MOV DL,10
        INT 21H
    
        MOV AH,09
        MOV DX,OFFSET MSG2
        INT 21H
        JMP EXIT
    
    PRINT_MSG3:
        MOV AH,02
        MOV DL,10
        INT 21H

        MOV AH,09
        MOV DX,OFFSET MSG3
        INT 21H
        JMP EXIT

    PRINT_MSG4:
        MOV AH,02
        MOV DL,10
        INT 21H

        MOV AH,09
        MOV DX,OFFSET MSG4
        INT 21H
        JMP EXIT

CHECK_NUMERIC:
    CMP AL,'9'
    JBE PRINT_MSG1

    JMP CAPITAL
CHECK_ALPHABET:
    CMP AL,'Z'
    JBE PRINT_MSG3
    JMP SMALL

CHECK_SMALL:
    CMP AL,'z'
    JBE PRINT_MSG4
    JMP PRINT_MSG2

EXIT:
    mov AH,4CH
    INT 21H

MAIN ENDP
END MAIN
