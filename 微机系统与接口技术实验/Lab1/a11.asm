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
	MOV DI, 12H        ; 将常数12H加载到DI寄存器中，作为源数据（这是待处理的数据）
	MOV SI, 4000H      ; 将内存地址4000H加载到SI寄存器，表示数据存储的目标地址（4000H指向存储位置）
	
	MOV BYTE PTR [SI], DI  ; 将DI寄存器中的数据（12H）存储到4000H（即[SI]）。现在，4000H的内容是12H（低位字节）。
	
	MOV AL, BYTE PTR [SI]  ; 从内存地址4000H加载数据到AL寄存器中，AL = 12H（低位字节）。
	MOV BL, AL             ; 将AL的值复制到BL寄存器，BL = 12H。此时BL存储的是低位字节。
	
	; 清除高位并将结果存入4001H和4002H
	AND BL, 0F0H           ; 保留BL的高四位，清除低四位。此时BL = 10H（高位字节）。
	MOV CL, 4               ; 设置CL寄存器为4，用于右移BL中的值（右移4位）。
	SHR BL, CL              ; 将BL右移4位，BL = 01H（提取高位字节并存储到BL中）。
	MOV [SI+1], BL          ; 将BL（高位字节01H）存储到4001H（即[SI+1]），现在4001H的值是01H。
	
	MOV BL, AL              ; 将AL的值（12H）复制回BL寄存器，BL = 12H。此时BL存储的是原始值（低位字节）。
	AND BL, 0FH             ; 清除BL的高四位，只保留低四位（低字节），BL = 02H（低位字节）。
	MOV [SI+2], BL          ; 将BL（低位字节02H）存储到4002H（即[SI+2]），现在4002H的值是02H。
	
	; 程序结束后，4001H 存储高位字节 01H，4002H 存储低位字节 02H，任务完成
	

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


