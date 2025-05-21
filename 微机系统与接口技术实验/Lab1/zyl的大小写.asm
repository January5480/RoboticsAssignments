data segment
    str1 DB '1234!%ghijklnmopqrstuvwxyzABCDEFGHIGKLNMOPQRSTUVWXYZ', '$' 
data ends
code segment
    assume cs:code, ds:data
start:
    MOV AX, data
    MOV DS, AX
    LEA BX, str1
    MOV CX, 52
S:
    MOV AL, [BX]
    CMP AL, 'a'
    JB upper 
    CMP AL, 'z'
    JA upper
    AND AL, 11011111B ; 
    JMP store 
upper:
    CMP AL, 'A'
    JB store
    CMP AL, 'Z'
    JA store
    OR AL, 00100000B 
store:
    MOV [BX], AL
    INC BX
    LOOP S
    LEA DX, str1
    MOV AH, 09H
    INT 21H 
    MOV AH, 4CH
    INT 21H 
code ends
end start




