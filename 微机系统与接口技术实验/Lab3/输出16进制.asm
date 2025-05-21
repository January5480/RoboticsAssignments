DATAS SEGMENT
    ;此处输入数据段代码  
    TEMP DB '****MAX_MIN $'
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
    MOV BX,8923H
    MOV AX,BX
    MOV SI,OFFSET TEMP+3;输出的偏移地址

    XOR CX,CX
    MOV CL,04H

    PRINT:
    MOV DH,AL
    ;逻辑位移，保留低位,CL不能用
    SHR AX,1
    SHR AX,1
    SHR AX,1
    SHR AX,1

    AND DH,0FH;取低位
    ADD DH,30H;变字母

    CMP DH,':';数字与字母的ascll界限
    JA IS;高于，是字符
    JB NO;低于，是数字

    IS:
    ADD DH,07H;变字母
    NO:
    MOV [SI],DH

    DEC SI
    LOOP PRINT
	MOV DX,OFFSET TEMP
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

