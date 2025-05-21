DATAS SEGMENT
    ; ���ݶ�
    STR1 DB 'INPUT: $'
    STR2 DB 'MAX: $'
    STR3 DB 'MIN: $'
    s1 db 0D9h, 07h, 8Bh, 0C5h, 0EBh, 04h, 9Dh, 0F9h ; ������ֽ�����
DATAS ENDS

STACKS SEGMENT
    ; ��ջ��
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS

START:
    MOV AX, DATAS
    MOV DS, AX

    ; �����ʾ�ַ���
    LEA DX, STR1
    MOV AH, 09h
    INT 21h   ; ���"INPUT: "��ʾ

    ; �������ֵ����Сֵ
    CALL MAX_MIN

    ; ��������
    MOV AH, 4Ch
    INT 21h

MAX_MIN PROC NEAR
    ; ��ʼ��
    MOV SI, 3000H         ; ���ݶε�ַ
    MOV CX, 8             ; �ֽ�����
    MOV BH, 0             ; ��ʼ���ֵ
    MOV BL, 0FFh          ; ��ʼ��Сֵ

AGAIN:
    MOV AL, [SI]          ; ��ȡ��ǰ�ֽ�
    CMP AL, BH            ; �Ƚϵ�ǰ�ֽ������ֵ
    JAE GREATER           ; �����ǰ�ֽڴ��ڵ������ֵ���������ֵ
    CMP AL, BL            ; �Ƚϵ�ǰ�ֽ�����Сֵ
    JBE LOWER             ; �����ǰ�ֽ�С�ڵ�����Сֵ��������Сֵ
    JMP NEXT              ; ������һ���ֽ�

GREATER:
    MOV BH, AL            ; �������ֵ
    JMP NEXT

LOWER:
    MOV BL, AL            ; ������Сֵ

NEXT:
    INC SI                ; ָ����һ���ֽ�
    DEC CX                ; �ֽ�������1
    JNZ AGAIN             ; ��������ֽڣ�����ѭ��

    ; ������ֵ
    LEA DX, STR2
    MOV AH, 09h
    INT 21h               ; ��� "MAX: "
    MOV DL, BH            ; ȡ���ֵ
    CALL PrintBinary      ; ��ӡ���ֵ�������ƣ�

    ; �����Сֵ
    LEA DX, STR3
    MOV AH, 09h
    INT 21h               ; ��� "MIN: "
    MOV DL, BL            ; ȡ��Сֵ
    CALL PrintBinary      ; ��ӡ��Сֵ�������ƣ�

    RET
MAX_MIN ENDP

; �ӳ��򣺴�ӡһ���ֽڵĶ�����ֵ
PrintBinary PROC
    ; ���һ���ֽڵĶ�������
    MOV CL, 8             ; ��ӡ 8 λ
    MOV BL, DL            ; �����ַ��� BL �Ĵ���
    MOV DH, 80h           ; 1 << 7 (���λΪ 1)

PrintBit:
    TEST BL, DH           ; ���Ե�ǰ���λ
    JZ PrintZero          ; �����λΪ 0����ӡ 0
    MOV DL, '1'           ; ���򣬴�ӡ 1
    JMP PrintChar

PrintZero:
    MOV DL, '0'           ; ��ӡ 0

PrintChar:
    MOV AH, 02h           ; DOS ����ַ�
    INT 21h               ; ����ַ�
    SHL DH, 1             ; ���ƣ������һ��λ
    LOOP PrintBit         ; �ظ�ֱ������λ��ӡ���

    RET
PrintBinary ENDP

CODES ENDS
    END START

