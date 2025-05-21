.model small
.stack 100h

.data
    ; ���ݴ洢��
    sequence db 0D9h, 07h, 8Bh, C5h, EBh, 04h, 9Dh, F9h ; ʾ������

.code
start:
    ; ���öμĴ���
    mov ax, @data
    mov ds, ax

    ; ��ʼ��
    lea si, sequence       ; �����ֽ����еĵ�ַ
    mov cx, 8              ; �ֽ���Ϊ8
    mov al, 0FFh           ; ��ʼ���ֵΪ0FFh������λΪ1��
    mov bl, 00h            ; ��ʼ��СֵΪ00h������λΪ0��

    ; �����ӳ���Ѱ�����ֵ����Сֵ
    call FindMaxMin

    ; ������ֵ
    mov ah, 09h
    lea dx, max_prompt
    int 21h
    call PrintHex

    ; �����Сֵ
    mov ah, 09h
    lea dx, min_prompt
    int 21h
    call PrintHex

    ; ��������
    mov ah, 4Ch
    int 21h

; �ӳ���Ѱ�����ֵ����Сֵ
FindMaxMin proc
    push cx               ; ����CX
    push si               ; ����SI

    ; �����ֽ�����
    mov cx, 8             ; �ֽ���
    lea si, sequence      ; �����ֽ����еĵ�ַ

FindLoop:
    mov dl, [si]          ; ��ȡ��ǰ�ֽ�
    cmp dl, al            ; �Ƚϵ�ǰ�ֽ������ֵ
    jg UpdateMax          ; �����ǰ�ֽڴ������ֵ���������ֵ
    cmp dl, bl            ; �Ƚϵ�ǰ�ֽ�����Сֵ
    jl UpdateMin          ; �����ǰ�ֽ�С����Сֵ��������Сֵ

NextByte:
    inc si                ; �ƶ�����һ���ֽ�
    loop FindLoop         ; ѭ����ֱ��������8���ֽ�
    pop si                ; �ָ�SI
    pop cx                ; �ָ�CX
    ret
UpdateMax:
    mov al, dl            ; �������ֵ
    jmp NextByte

UpdateMin:
    mov bl, dl            ; ������Сֵ
    jmp NextByte
FindMaxMin endp

; �ӳ��򣺴�ӡһ���ֽڵ�ʮ������ֵ
PrintHex proc
    ; ���ֽ�ֵתΪʮ�����Ʋ���ӡ
    mov ah, 02h
    mov dl, al
    call PrintHexDigit
    mov dl, ah
    call PrintHexDigit
    ret
PrintHex endp

; �ӳ��򣺴�ӡʮ����������
PrintHexDigit proc
    ; ��ӡһ��ʮ����������
    cmp dl, 0Ah
    jb LessThan10
    add dl, 07h
LessThan10:
    add dl, '0'
    int 21h
    ret
PrintHexDigit endp

.data
max_prompt db 'Maximum value: $'
min_prompt db 'Minimum value: $'

end start

