DATAS SEGMENT
    ;�˴��������ݶδ���  
    TEMP DB '****MAX_MIN $'
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
    MOV BX,8923H
    MOV AX,BX
    MOV SI,OFFSET TEMP+3;�����ƫ�Ƶ�ַ

    XOR CX,CX
    MOV CL,04H

    PRINT:
    MOV DH,AL
    ;�߼�λ�ƣ�������λ,CL������
    SHR AX,1
    SHR AX,1
    SHR AX,1
    SHR AX,1

    AND DH,0FH;ȡ��λ
    ADD DH,30H;����ĸ

    CMP DH,':';��������ĸ��ascll����
    JA IS;���ڣ����ַ�
    JB NO;���ڣ�������

    IS:
    ADD DH,07H;����ĸ
    NO:
    MOV [SI],DH

    DEC SI
    LOOP PRINT
	MOV DX,OFFSET TEMP
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

