DATAS SEGMENT
    ;此处输入数据段代码
    str1 db 'enter:$' 
    str2 db 'correct!                        $' 
    str3 db 'wrong!enteragain:      $' 
    BUF1 db '12344' 
    BUF2 db 20, 0 
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
    MOV AH, 09H          
    LEA dx, [str1]     
    int 21h
inputloop:
    mov ah, 0Ah          
    lea dx, [BUF2]       
    int 21h
    lea si, [BUF2+2]     
    lea di, [BUF1]       
    mov cx, 5           
compareloop:
    mov al, [si]         
    mov bl, [di]        
    cmp al, bl           
    jne incorrect       
    inc si               
    inc di               
    loop compareloop       
    mov ah, 09h          
    lea dx, [str2]
    int 21h
    jmp DONE      
incorrect:   
    mov ah, 09h         
    lea dx, [str3] 
    int 21h
    jmp inputloop
DONE:
    ; 程序结束，返回操作系统
    mov ah, 4Ch          
    int 21h
CODES ENDS
    END START



