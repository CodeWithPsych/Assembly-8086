.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB "Enter a hex number (0 to FFFF): $"
MSG2 DB 10,"Illegal hex digit, try again: $"
MSG3 DB 10,"In binary it is: $"
.CODE
MAIN PROC
	MOV AX,@DATA
	MOV DS,AX
	
	MOV AH,9
	LEA DX,MSG1
	INT 21H
	CALL GET_HEXA_INPUT
	
	MOV AH,9
	LEA DX,MSG3
	INT 21H
	CALL PRINT_16_BIT_BINARY
	
	
	MOV AH,9
	LEA DX,MSG4
	INT 21H
	CALL PRINT_16_BIT_BINARY
	
	MOV AH,4CH
	INT 21H
MAIN ENDP


;this function will take 4 or less than 4
;character HEXA input from user
;and returns it in BX
GET_HEXA_INPUT PROC
	PUSH AX
	PUSH CX
	PUSH DX
START:
	XOR BX,BX
	MOV CL,4
	LOOP_1:
		MOV AH,1
		INT 21H
		
		CMP AL,13
		JE EXIT
		
		CMP AL,"0"
		JL INVALID_CHARACTER_CHECK
		
		CMP AL,"9"
		JG ELSE_IF1
		IF_1:
			SUB AL,"0"
			JMP END_IF1
		ELSE_IF1:
			CMP AL,"F"
			JG INVALID_CHARACTER_CHECK
			CMP AL,"A"
			JL INVALID_CHARACTER_CHECK
			SUB AL,55
			JMP END_IF1
			INVALID_CHARACTER_CHECK:
			MOV AH,9
			LEA DX,MSG2
			INT 21H
			JMP START
		END_IF1:
		SHL BX,4
		OR BL,AL	
		DEC CL
		JNZ LOOP_1
	END_LOOP1:
EXIT:	
	POP DX
	POP CX
	POP AX
	
	RET
GET_HEXA_INPUT ENDP



;this function recieves 16 bit number in
;BX and dispaly its binary
PRINT_16_BIT_BINARY PROC
	PUSH AX
	PUSH CX
	PUSH DX
	
	MOV CL,16
	LOOP_2:
		ROL BX,1
		JC ELSE_IF2
		IF_2:
			MOV AH,2
			MOV DL,"0"
			INT 21H
			JMP END_IF2
		ELSE_IF2:
			MOV AH,2
			MOV DL,"1"
			INT 21H
		END_IF2:		
		DEC CL
		JNZ LOOP_2
	END_LOOP2:
	
	POP DX
	POP CX
	POP AX
	
	RET
PRINT_16_BIT_BINARY ENDP


END MAIN