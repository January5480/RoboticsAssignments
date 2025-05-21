DATAS SEGMENT
    ;此处输入数据段代码  
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
    MOV CL,8
    MOV DL,1
    ADD DL,'0'
    MOV AH,6
    INT 21H
    MOV DL,' '
    
    MOV AH,6
    INT 21H
    MOV DL,1
    ADD DL,'0'
    MOV AH,6
    INT 21H
    
    MOV DL,' '
    
    MOV AH,6
    INT 21H
    MOV BH,1
    MOV CH,1
AGAIN:
    MOV BL,BH
    ADD BH,CH
    MOV CH,BL
    MOV DL,BH
    ADD DL,'0'
    MOV AH,6
    INT 21H
    MOV DL,' '
    
    MOV AH,6
    INT 21H
    DEC CL
    JNZ AGAIN
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START



