;Ĭ�ϲ���ML6.11������
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
    MOV AX,4000H				;��4000Hװ��AX�Ĵ�����
    MOV BX,4001H				;��4000Hװ��BX�Ĵ����У����ڴ洢��λ
    MOV SI,4002H				;��4000Hװ��AX�Ĵ����У����ڴ洢��λ
    MOV [BX],AH				;��AX��λ�洢��4001H
    MOV [SI],AL				;��AX��λ�洢��4002H
    AND BYTE PTR [BX],0FH	;4001H��λ����
    AND BYTE PTR [SI],0FH	;4002H��λ����
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

