DATAS SEGMENT
    x dw ?
    n dw 16   ;�涨��������������16����
DATAS ENDS
STACKS SEGMENT	stack
      db 100h dup(?)
STACKS ENDS
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
     mov bx,0  ;bx��Ϊһ���ۼӴ洢����
L1:;ѭ������
	mov ah,1   ;1�ŵ��ã�����һ���ַ�
	int 21h  
	cmp al,0dh  ;�س�������
	jz  L2
	
	cmp al,39H
	ja upperThanNine        
lowerThanNine:
 			sub al,30h  ;��30h,��0~9�����ַ���Ϊ����
 			jmp calcu
upperThanNine:
			sub al,37H ;����ĸA~Fת��Ϊ����	
calcu:
    mov ah,0
	xchg bx,ax
	mul n       ;����16
	add bx,ax   ;�ټ��������������
	jmp L1     ;ѭ������
L2: 
	mov x,bx
	
	MOV DX,X
	MOV AH,09H
	INT 21H
    MOV AH,4CH
    INT 21H
    
CODES ENDS
    END START



