DATAS SEGMENT
    ; 数据段
    STR1 DB 'INPUT: $'
    STR2 DB 'MAX: $'
    STR3 DB 'MIN: $'
    s1 db 0D9h, 07h, 8Bh, 0C5h, 0EBh, 04h, 9Dh, 0F9h ; 输入的字节序列
DATAS ENDS

STACKS SEGMENT
    ; 堆栈段
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS

START:
    MOV AX, DATAS
    MOV DS, AX

    ; 输出提示字符串
    LEA DX, STR1
    MOV AH, 09h
    INT 21h   ; 输出"INPUT: "提示

    ; 计算最大值和最小值
    CALL MAX_MIN

    ; 结束程序
    MOV AH, 4Ch
    INT 21h

MAX_MIN PROC NEAR
    ; 初始化
    MOV SI, 3000H         ; 数据段地址
    MOV CX, 8             ; 字节数量
    MOV BH, 0             ; 初始最大值
    MOV BL, 0FFh          ; 初始最小值

AGAIN:
    MOV AL, [SI]          ; 读取当前字节
    CMP AL, BH            ; 比较当前字节与最大值
    JAE GREATER           ; 如果当前字节大于等于最大值，更新最大值
    CMP AL, BL            ; 比较当前字节与最小值
    JBE LOWER             ; 如果当前字节小于等于最小值，更新最小值
    JMP NEXT              ; 继续下一个字节

GREATER:
    MOV BH, AL            ; 更新最大值
    JMP NEXT

LOWER:
    MOV BL, AL            ; 更新最小值

NEXT:
    INC SI                ; 指向下一个字节
    DEC CX                ; 字节数量减1
    JNZ AGAIN             ; 如果还有字节，继续循环

    ; 输出最大值
    LEA DX, STR2
    MOV AH, 09h
    INT 21h               ; 输出 "MAX: "
    MOV DL, BH            ; 取最大值
    CALL PrintBinary      ; 打印最大值（二进制）

    ; 输出最小值
    LEA DX, STR3
    MOV AH, 09h
    INT 21h               ; 输出 "MIN: "
    MOV DL, BL            ; 取最小值
    CALL PrintBinary      ; 打印最小值（二进制）

    RET
MAX_MIN ENDP

; 子程序：打印一个字节的二进制值
PrintBinary PROC
    ; 输出一个字节的二进制数
    MOV CL, 8             ; 打印 8 位
    MOV BL, DL            ; 将数字放入 BL 寄存器
    MOV DH, 80h           ; 1 << 7 (最高位为 1)

PrintBit:
    TEST BL, DH           ; 测试当前最高位
    JZ PrintZero          ; 如果该位为 0，打印 0
    MOV DL, '1'           ; 否则，打印 1
    JMP PrintChar

PrintZero:
    MOV DL, '0'           ; 打印 0

PrintChar:
    MOV AH, 02h           ; DOS 输出字符
    INT 21h               ; 输出字符
    SHL DH, 1             ; 左移，检查下一个位
    LOOP PrintBit         ; 重复直到所有位打印完毕

    RET
PrintBinary ENDP

CODES ENDS
    END START

