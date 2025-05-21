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
	MOV BX, 4000H            ; 将地址4000H加载到BX寄存器，BX指向显示缓冲区的起始地址
	MOV DL, 34H              ; 将常数34H加载到DL寄存器（即要存储到4000H的位置的低位字节）
	MOV BYTE PTR [BX], DL    ; 将DL（34H）存储到内存地址4000H（即BX指向的位置）
	MOV BYTE PTR [BX+1], 78H ; 将常数78H存储到内存地址4001H（即BX+1指向的位置），这将作为高位字节
	MOV AL, [BX]            ; 从4000H加载字节（34H）到AL寄存器（低位）
	AND AL, 0FH             ; 将AL的高四位清零，保留AL的低四位（即34H的低四位为4）
	MOV CL, 4               ; 将CL寄存器设为4，用于左移4位
	SHL AL, CL              ; 将AL寄存器的值左移4位，AL变为34H的高四位（即4），现在AL = 40H	
	MOV AH, [BX+1]          ; 从4001H加载字节（78H）到AH寄存器（高位）
	AND AH, 0FH             ; 将AH的高四位清零，保留AH的低四位（即78H的低四位为8）
	ADD AH, AL              ; 将AL（40H）与AH（8）相加，AH = 8 + 40H = 48H	
	MOV [BX+2], AH          ; 将AH寄存器的值（48H）存储到内存地址4002H（即BX+2）中  
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
