DATAS SEGMENT
    ;�˴��������ݶδ���  
    d db 10
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

    mov ax, 123; �� ax ��ֵ 123
    mov sp, 10; cl ��ÿ�� ���� 10
    mov bp, 0; ���� ���˶��ٴΣ�Ҳ�����м�λ
    
L0:	div sp; ax ���� cl
	push ax; ��ʱ���̴洢�� al �У�
	;�����洢�� ah �У���ʱ ax = ah
	add bp, 1
	mov ah, 0
	cmp ax, 0;��� ax �� 0��˵�����ɾ���
	jne L0
	
again: cmp bp, 0; ��ʱ ch ��ֵ����λ����ÿ�γ�ջ��
;Ȼ�� ch ��һ���� 
	je over
	pop dx; ��ջ��Ԫ�ش洢�� dx ��
	mov dl, dh;Ȼ�� dl ��ֵ���� dh
	add dl, 48
	mov ah, 2
	int 21h
	
	; write by �����
	dec bp
	jmp again
over:

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


