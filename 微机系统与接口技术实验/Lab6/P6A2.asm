DATAS SEGMENT
    ;�˴��������ݶδ��� 
    M DB 80
    N DB 60
    L DB 3 
    OUT1 DB 0
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
    MOV SI,OFFSET M
    MOV AL,[SI]
    MOV BH,AL
    MOV SI,OFFSET N
    MOV BL,[SI]
    MOV SI,OFFSET L
    MOV CL,[SI]
    ADD AL,BL
    MOV CH,3
    MUL CH
    MOV CH,BH
    SHL BH,1
    ADD BH,CH
    MOV CL,8
    SHR BX,CL
    ADD AX,BX
    MOV BH,AH
    MOV DL,AL
    MOV AH,6
    INT 21H
    MOV AL,BH
    MOV DL,BH
    MOV AH,6
    INT 21H
    
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
