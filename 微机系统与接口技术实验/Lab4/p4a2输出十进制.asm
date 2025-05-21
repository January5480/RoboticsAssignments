DATAS SEGMENT
    ;此处输入数据段代码  
    d db 10
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码

    mov ax, 123; 将 ax 赋值 123
    mov sp, 10; cl 是每次 除以 10
    mov bp, 0; 计算 除了多少次，也就是有几位
    
L0:	div sp; ax 除以 cl
	push ax; 此时的商存储在 al 中，
	;余数存储在 ah 中，此时 ax = ah
	add bp, 1
	mov ah, 0
	cmp ax, 0;如果 ax 是 0，说明除干净了
	jne L0
	
again: cmp bp, 0; 此时 ch 的值就是位数，每次出栈，
;然后 ch 减一即可 
	je over
	pop dx; 把栈顶元素存储到 dx 中
	mov dl, dh;然后将 dl 的值等于 dh
	add dl, 48
	mov ah, 2
	int 21h
	
	; write by 唐昊翔
	dec bp
	jmp again
over:

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


