DATAS SEGMENT
    x dw ?
    n dw 16   ;规定进制数，这里是16进制
DATAS ENDS
STACKS SEGMENT	stack
      db 100h dup(?)
STACKS ENDS
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
     mov bx,0  ;bx作为一个累加存储作用
L1:;循环输入
	mov ah,1   ;1号调用，输入一个字符
	int 21h  
	cmp al,0dh  ;回车就跳出
	jz  L2
	
	cmp al,39H
	ja upperThanNine        
lowerThanNine:
 			sub al,30h  ;减30h,让0~9数字字符成为数字
 			jmp calcu
upperThanNine:
			sub al,37H ;让字母A~F转化为数字	
calcu:
    mov ah,0
	xchg bx,ax
	mul n       ;乘以16
	add bx,ax   ;再加上新输入进来的
	jmp L1     ;循环输入
L2: 
	mov x,bx
	
	MOV DX,X
	MOV AH,09H
	INT 21H
    MOV AH,4CH
    INT 21H
    
CODES ENDS
    END START



