DATAS SEGMENT
    ;�˴��������ݶδ���  
    X DB 5
    Y DB 7
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
    mov SI,offset x
    MOV bx,OFFSET Y
    MOV CL,[SI]
    MOV CH,[BX]
    CMP CL,CH
    JA L_MAX
    MOV MAX,CH
    MOV DL,CH
    ADD DL,'0'
    MOV AH,2
    INT 21H
    JMP DONE
    L_MAX:
    MOV MAX,CL    
    MOV DL,CL
    ADD DL,'0'
    MOV AH,2
    INT 21H
    DONE:
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
