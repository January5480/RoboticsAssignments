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
    MOV AX, 1234H           ; 将1234H加载到AX寄存器
	MOV BX, 4000H           ; 将内存地址4000H加载到BX寄存器
	MOV word ptr [BX], AX   ; 将AX中的1234H存入BX寄存器指向的内存地址（即4000H）
	
	MOV AX, word ptr [BX] ; 从4000H加载内容（1234H）到AX寄存器

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

