DATAS SEGMENT
    ;�˴��������ݶδ���
    BUF     DB  'ABCDbdcA'  ; �ַ��� BUF���� null �ַ���β
    COUNT EQU 8
    MAX DB 0

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
    MOV SI,  OFFSET BUF   ; 
	MOV CX,COUNT
LP: MOV AL,[SI]
	CMP AL,MAX
	JB NEXT
	MOV MAX,AL
NEXT:
	INC SI
	LOOP LP
	MOV DL,MAX
	MOV AH,2
	INT 21H
    MOV AH,4CH
    INT 21H                  
CODES ENDS
    END START

