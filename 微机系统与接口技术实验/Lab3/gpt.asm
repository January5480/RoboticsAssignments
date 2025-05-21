.model small
.stack 100h

.data
    ; 数据存储区
    sequence db 0D9h, 07h, 8Bh, C5h, EBh, 04h, 9Dh, F9h ; 示例数据

.code
start:
    ; 设置段寄存器
    mov ax, @data
    mov ds, ax

    ; 初始化
    lea si, sequence       ; 加载字节序列的地址
    mov cx, 8              ; 字节数为8
    mov al, 0FFh           ; 初始最大值为0FFh（所有位为1）
    mov bl, 00h            ; 初始最小值为00h（所有位为0）

    ; 调用子程序寻找最大值和最小值
    call FindMaxMin

    ; 输出最大值
    mov ah, 09h
    lea dx, max_prompt
    int 21h
    call PrintHex

    ; 输出最小值
    mov ah, 09h
    lea dx, min_prompt
    int 21h
    call PrintHex

    ; 结束程序
    mov ah, 4Ch
    int 21h

; 子程序：寻找最大值和最小值
FindMaxMin proc
    push cx               ; 保存CX
    push si               ; 保存SI

    ; 遍历字节序列
    mov cx, 8             ; 字节数
    lea si, sequence      ; 加载字节序列的地址

FindLoop:
    mov dl, [si]          ; 读取当前字节
    cmp dl, al            ; 比较当前字节与最大值
    jg UpdateMax          ; 如果当前字节大于最大值，更新最大值
    cmp dl, bl            ; 比较当前字节与最小值
    jl UpdateMin          ; 如果当前字节小于最小值，更新最小值

NextByte:
    inc si                ; 移动到下一个字节
    loop FindLoop         ; 循环，直到遍历完8个字节
    pop si                ; 恢复SI
    pop cx                ; 恢复CX
    ret
UpdateMax:
    mov al, dl            ; 更新最大值
    jmp NextByte

UpdateMin:
    mov bl, dl            ; 更新最小值
    jmp NextByte
FindMaxMin endp

; 子程序：打印一个字节的十六进制值
PrintHex proc
    ; 将字节值转为十六进制并打印
    mov ah, 02h
    mov dl, al
    call PrintHexDigit
    mov dl, ah
    call PrintHexDigit
    ret
PrintHex endp

; 子程序：打印十六进制数字
PrintHexDigit proc
    ; 打印一个十六进制数字
    cmp dl, 0Ah
    jb LessThan10
    add dl, 07h
LessThan10:
    add dl, '0'
    int 21h
    ret
PrintHexDigit endp

.data
max_prompt db 'Maximum value: $'
min_prompt db 'Minimum value: $'

end start

