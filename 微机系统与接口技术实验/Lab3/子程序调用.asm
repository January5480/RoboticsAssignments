DATAS SEGMENT
    ;�˴��������ݶδ���  
    ORG 3000H
    s1 db 0A9h, 12h, 8Bh, 0E5h, 0EBh, 47h, 9Dh, 0EFh
    TEMP DB '*******MIN****** $'
    TEMP1 DB '*******MAX****** $'
    CHANGELINE DB 13,10,'$'
     ; ������ֽ�����
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS

	START:
	    MOV AX,DATAS
	    MOV DS,AX
	    ;�˴��������δ���
	    ;MOV SI,3000H
	    MOV CX,8
		
	    CALL MAX_MIN
	   ; MOV AX,BX
	    ;CALL PRINTLOWER
	   ; MOV DX,OFFSET CHANGELINE
	   ; MOV AH,09H
	   ; INT 21H
	   ; CALL PRINTHIGHER
	    MOV AH,4CH
	    INT 21H


MAX_MIN PROC NEAR
		MOV SI,OFFSET S1
	    MOV CX,8
	    MOV BH,00H
	    MOV BL,0FFH
	AGAIN:
		
		MOV AL,[SI]
		
		CMP AL,BH
		JAE GREATER
		CMP AL,BL
		JBE LOWER
		JMP NEXT
	GREATER:
		MOV BH,AL
		JMP NEXT
	LOWER:
	    MOV BL,AL 
	NEXT:
		INC SI
		DEC CX
		JNZ AGAIN
		
		
	RET
MAX_MIN ENDP

PRINTLOWER PROC NEAR
	
    MOV SI,OFFSET TEMP+1;�����ƫ�Ƶ�ַ

    XOR CX,CX
    MOV CL,02H

    PRINT:
	    MOV DH,AL
	    
	    SHR AX,1
	    SHR AX,1
	    SHR AX,1
	    SHR AX,1
	
	    AND DH,0FH
	    ADD DH,30H
	
	    CMP DH,':'
	    JA IS
	    JB NO
	
    IS:
	    ADD DH,07H
    NO:
	    MOV [SI],DH
	
	    DEC SI
    LOOP PRINT
	MOV DX,OFFSET TEMP
    MOV AH,09H
    INT 21H
    RET
PRINTLOWER ENDP

PRINTHIGHER PROC NEAR
	
    MOV SI,OFFSET TEMP1+1

    XOR CX,CX
    MOV CL,02H

    PRINT:
	    MOV DH,AL
	   
	    SHR AX,1
	    SHR AX,1
	    SHR AX,1
	    SHR AX,1
	
	    AND DH,0FH
	    ADD DH,30H
	
	    CMP DH,':'
	    JA IS
	    JB NO
	
    IS:
	    ADD DH,07H
    NO:
	    MOV [SI],DH
	
	    DEC SI
    LOOP PRINT
	MOV DX,OFFSET TEMP1
    MOV AH,09H
    INT 21H
    RET
PRINTHIGHER ENDP
	
CODES ENDS
    END START









