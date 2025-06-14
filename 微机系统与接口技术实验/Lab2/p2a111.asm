DATAS SEGMENT
    ;此处输入数据段代码
    BUF     DB  'ABCDbdcA'  ; 字符串 BUF，以 null 字符结尾
    COUNT EQU 8
    MAX DB 0

DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码	
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

