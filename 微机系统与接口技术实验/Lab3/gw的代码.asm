.MODEL SMALL
.STACK 100H
.DATA
    ORG 3000H ; 数据段首地址
    BYTE_COUNT EQU 08H      ; 字节数
    DATA_ARRAY DD  12h, 8Bh, 0E5h, 0EBh, 47h, 9Dh, 0EFh,57H ; 用于存储数据的数组
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; 初始化数据段地址
    MOV SI, OFFSET DATA_ARRAY
    ; 初始化字节数
    MOV CX, BYTE_COUNT

    CALL FIND_MAX_MIN

    MOV AH, 4CH
    INT 21H
MAIN ENDP

FIND_MAX_MIN PROC
    ;PUSH AX
    ;PUSH BX
    ;PUSH CX
    ;PUSH DX

    MOV BX, 0      ; 用于存储最大值
    MOV DX, 00FFH ; 用于存储最小值

FIND_LOOP:
    MOV AX, [SI]
    CMP AX, BX
    JBE NOT_MAX
    MOV BX, AX     ; 更新最大值
NOT_MAX:
    CMP AX, DX
    JAE NOT_MIN
    MOV DX, AX     ; 更新最小值
NOT_MIN:
    ADD SI, 4
    LOOP FIND_LOOP

    ; 将最大值存放在AH，最小值存放在AL
    MOV AX, BX
    MOV AH, BH
    MOV AL, DL

    ;POP DX
    ;POP CX
    ;POP BX
    ;POP AX
    RET
FIND_MAX_MIN ENDP
END MAIN


