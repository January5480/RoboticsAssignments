;默认采用ML6.11汇编程序
DATAS SEGMENT
    ;此处输入数据段代码  
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
    MOV AX,4000H				;将4000H装到AX寄存器中
    MOV BX,4001H				;将4000H装到BX寄存器中，用于存储高位
    MOV SI,4002H				;将4000H装到AX寄存器中，用于存储低位
    MOV [BX],AH				;将AX高位存储到4001H
    MOV [SI],AL				;将AX地位存储到4002H
    AND BYTE PTR [BX],0FH	;4001H高位清零
    AND BYTE PTR [SI],0FH	;4002H高位清零
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

