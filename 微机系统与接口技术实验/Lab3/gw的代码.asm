.MODEL SMALL
.STACK 100H
.DATA
    ORG 3000H ; ���ݶ��׵�ַ
    BYTE_COUNT EQU 08H      ; �ֽ���
    DATA_ARRAY DD  12h, 8Bh, 0E5h, 0EBh, 47h, 9Dh, 0EFh,57H ; ���ڴ洢���ݵ�����
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; ��ʼ�����ݶε�ַ
    MOV SI, OFFSET DATA_ARRAY
    ; ��ʼ���ֽ���
    MOV CX, BYTE_COUNT

    CALL FIND_MAX_MIN

    MOV AH, 4CH
    INT 21H
MAIN ENDP

FIND_MAX_MIN PROC
    ;PUSH AX
    ;PUSH BX
    ;PUSH CX
    ;PUSH DX

    MOV BX, 0      ; ���ڴ洢���ֵ
    MOV DX, 00FFH ; ���ڴ洢��Сֵ

FIND_LOOP:
    MOV AX, [SI]
    CMP AX, BX
    JBE NOT_MAX
    MOV BX, AX     ; �������ֵ
NOT_MAX:
    CMP AX, DX
    JAE NOT_MIN
    MOV DX, AX     ; ������Сֵ
NOT_MIN:
    ADD SI, 4
    LOOP FIND_LOOP

    ; �����ֵ�����AH����Сֵ�����AL
    MOV AX, BX
    MOV AH, BH
    MOV AL, DL

    ;POP DX
    ;POP CX
    ;POP BX
    ;POP AX
    RET
FIND_MAX_MIN ENDP
END MAIN


