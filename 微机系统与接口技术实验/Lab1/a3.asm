DATAS SEGMENT
    SCORE DB 56, 69, 84, 82, 73, 88, 99, 63, 100, 80  ; 10��ѧ���ĳɼ�

    ; ͳ�ƽ��������ÿ��������ʾһ���ɼ��ε�����
    COUNT100 DB 0      ; 100�ֵ�����
    COUNT90TO100 DB 0  ; 90��100��֮�������
    COUNT80TO90 DB 0   ; 80��90��֮�������
    COUNT70TO80 DB 0   ; 70��80��֮�������
    COUNT60TO70 DB 0   ; 60��70��֮�������
    COUNTBELOW60 DB 0  ; 60�����µ�����

    MSGRESULT DB 'Results:', 0Dh, 0Ah, '$'
DATAS ENDS

STACKS SEGMENT
    ; ��ջ�δ�����Ը�����Ҫ����
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS
START:
    MOV AX, DATAS
    MOV DS, AX 
   ; �����ɼ�����
    LEA SI, SCORE   ; SIָ��ɼ���������
    MOV CX, 10      ; ѭ������������10���ɼ�
CHECK_SCORES:
    MOV AL, [SI]    ; ��ȡ��ǰ�ɼ�
    INC SI          ; �ƶ�����һ���ɼ�
    ; �жϳɼ���������Ӧ��ͳ��
    CMP AL, 100     ; ����ɼ���100
    JE  SCORE100
    CMP AL, 90      ; ����ɼ���90��100֮��
    JAE SCORE90TO100
    CMP AL, 80      ; ����ɼ���80��90֮��
    JAE SCORE80TO90
    CMP AL, 70      ; ����ɼ���70��80֮��
    JAE SCORE70TO80
    CMP AL, 60      ; ����ɼ���60��70֮��
    JAE SCORE60TO70
    ; 60������
    JMP SCOREBELOW60
SCORE100:
    INC BYTE PTR [COUNT100]  ; 100�ֵ�������1
    JMP NEXT_SCORE
SCORE90TO100:
    INC BYTE PTR [COUNT90TO100] ; 90��100�ֵ�������1
    JMP NEXT_SCORE
SCORE80TO90:
    INC BYTE PTR [COUNT80TO90]  ; 80��90�ֵ�������1
    JMP NEXT_SCORE
SCORE70TO80:
    INC BYTE PTR [COUNT70TO80]  ; 70��80�ֵ�������1
    JMP NEXT_SCORE
SCORE60TO70:
    INC BYTE PTR [COUNT60TO70]  ; 60��70�ֵ�������1
    JMP NEXT_SCORE
SCOREBELOW60:
    INC BYTE PTR [COUNTBELOW60]  ; 60�����µ�������1
NEXT_SCORE:
    LOOP CHECK_SCORES    ; ѭ��������һ���ɼ�
    ; ���ͳ�ƽ��
    LEA DX, MSGRESULT
    MOV AH, 09H
    INT 21H
    ; ���ÿ�������ε�����
    ; 100�ֵ�����
    LEA SI, COUNT100
    CALL PRINTCOUNT
    ; 90-100��֮�������
    LEA SI, COUNT90TO100
    CALL PRINTCOUNT
    ; 80-90��֮�������
    LEA SI, COUNT80TO90
    CALL PRINTCOUNT
    ; 70-80��֮�������
    LEA SI, COUNT70TO80
    CALL PRINTCOUNT
    ; 60-70��֮�������
    LEA SI, COUNT60TO70
    CALL PRINTCOUNT
    ; 60�����µ�����
    LEA SI, COUNTBELOW60
    CALL PRINTCOUNT
    ; �����˳�
    MOV AH, 4CH
    INT 21H
; ���ͳ�ƽ��
PRINTCOUNT:
    MOV AL, [SI]  ; ��ȡͳ�ƽ��
    ADD AL, '0'    ; ת��ΪASCII�ַ�
    MOV DL, AL     ; �洢Ҫ������ַ�
    MOV AH, 02H
    INT 21H
    RET
    MOV AH, 4CH
    INT 21H
CODES ENDS
    END START

