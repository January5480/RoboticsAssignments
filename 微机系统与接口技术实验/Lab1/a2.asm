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
	MOV BX, 4000H            ; ����ַ4000H���ص�BX�Ĵ�����BXָ����ʾ����������ʼ��ַ
	MOV DL, 34H              ; ������34H���ص�DL�Ĵ�������Ҫ�洢��4000H��λ�õĵ�λ�ֽڣ�
	MOV BYTE PTR [BX], DL    ; ��DL��34H���洢���ڴ��ַ4000H����BXָ���λ�ã�
	MOV BYTE PTR [BX+1], 78H ; ������78H�洢���ڴ��ַ4001H����BX+1ָ���λ�ã����⽫��Ϊ��λ�ֽ�
	MOV AL, [BX]            ; ��4000H�����ֽڣ�34H����AL�Ĵ�������λ��
	AND AL, 0FH             ; ��AL�ĸ���λ���㣬����AL�ĵ���λ����34H�ĵ���λΪ4��
	MOV CL, 4               ; ��CL�Ĵ�����Ϊ4����������4λ
	SHL AL, CL              ; ��AL�Ĵ�����ֵ����4λ��AL��Ϊ34H�ĸ���λ����4��������AL = 40H	
	MOV AH, [BX+1]          ; ��4001H�����ֽڣ�78H����AH�Ĵ�������λ��
	AND AH, 0FH             ; ��AH�ĸ���λ���㣬����AH�ĵ���λ����78H�ĵ���λΪ8��
	ADD AH, AL              ; ��AL��40H����AH��8����ӣ�AH = 8 + 40H = 48H	
	MOV [BX+2], AH          ; ��AH�Ĵ�����ֵ��48H���洢���ڴ��ַ4002H����BX+2����  
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
