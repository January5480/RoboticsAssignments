DATAS SEGMENT
    ;�˴��������ݶδ���  
    STR1 DB 'INPUT: $'
    STR2 DB 'MAX:$'
    STR3 DB 'MIN:$'
    data_array db 12h, D8h, D9h, 7Fh, 7Eh, A3h, 9Dh, 8Fh
    inputBuffer db 8           ; ���뻺����, �洢8���ֽ�

DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
;MAIN PROC NEAR
	START:
	    MOV AX,DATAS
	    MOV DS,AX
	    ;�˴��������δ���
	    MOV SI,3000H
	    MOV CX,8
	    LEA DX,STR1
	    MOV AH,9
	    INT 21H;���input��ʾ
	    lea dx, inputBuffer
	CIN:
	    MOV AH,1
		INT 21H
		
		MOV [SI],AL
		INC SI
		DEC CX
		JNZ CIN
		
		mov ah, 09h
   		lea dx, newline
    	int 21h
    	lea dx, inputBuffer
    	mov ah, 09h
    	int 21h
	    ;CALL MAX_MIN
	    
	    ;MOV DX OFFSET STR2
	    ;MOV AH,9
	    ;INT 21H
	    MOV AH,4CH
	    INT 21H
;MAIN ENDP

MAX_MIN PROC NEAR
	AGAIN:
		MOV SI,3000H
	    MOV CX,8
		MOV BH,[SI]
		MOV BL,BH
		INC SI
		MOV AL,[SI]
		CMP AL,BH
		JAE GREATER
		CMP AL,BH
		JB LOWER
		JMP NEXT
	GREATER:
		MOV BH,AL
		JMP NEXT
	LOWER:
	    MOV BL,AL 
	NEXT:
		DEC CX
		JNZ AGAIN
	RET
MAX_MIN ENDP
	
CODES ENDS
    END START
