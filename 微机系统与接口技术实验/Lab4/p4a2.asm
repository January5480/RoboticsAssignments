DATAS SEGMENT
    ;�˴��������ݶδ���  
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



