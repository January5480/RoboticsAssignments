DATAS SEGMENT
    SCORE DB 56, 69, 84, 82, 73, 88, 99, 63, 100, 80  ; 10个学生的成绩

    ; 统计结果变量：每个变量表示一个成绩段的人数
    COUNT100 DB 0      ; 100分的人数
    COUNT90TO100 DB 0  ; 90到100分之间的人数
    COUNT80TO90 DB 0   ; 80到90分之间的人数
    COUNT70TO80 DB 0   ; 70到80分之间的人数
    COUNT60TO70 DB 0   ; 60到70分之间的人数
    COUNTBELOW60 DB 0  ; 60分以下的人数

    MSGRESULT DB 'Results:', 0Dh, 0Ah, '$'
DATAS ENDS

STACKS SEGMENT
    ; 堆栈段代码可以根据需要设置
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS
START:
    MOV AX, DATAS
    MOV DS, AX 
   ; 遍历成绩数据
    LEA SI, SCORE   ; SI指向成绩数据数组
    MOV CX, 10      ; 循环次数，处理10个成绩
CHECK_SCORES:
    MOV AL, [SI]    ; 读取当前成绩
    INC SI          ; 移动到下一个成绩
    ; 判断成绩并更新相应的统计
    CMP AL, 100     ; 如果成绩是100
    JE  SCORE100
    CMP AL, 90      ; 如果成绩在90到100之间
    JAE SCORE90TO100
    CMP AL, 80      ; 如果成绩在80到90之间
    JAE SCORE80TO90
    CMP AL, 70      ; 如果成绩在70到80之间
    JAE SCORE70TO80
    CMP AL, 60      ; 如果成绩在60到70之间
    JAE SCORE60TO70
    ; 60分以下
    JMP SCOREBELOW60
SCORE100:
    INC BYTE PTR [COUNT100]  ; 100分的人数加1
    JMP NEXT_SCORE
SCORE90TO100:
    INC BYTE PTR [COUNT90TO100] ; 90到100分的人数加1
    JMP NEXT_SCORE
SCORE80TO90:
    INC BYTE PTR [COUNT80TO90]  ; 80到90分的人数加1
    JMP NEXT_SCORE
SCORE70TO80:
    INC BYTE PTR [COUNT70TO80]  ; 70到80分的人数加1
    JMP NEXT_SCORE
SCORE60TO70:
    INC BYTE PTR [COUNT60TO70]  ; 60到70分的人数加1
    JMP NEXT_SCORE
SCOREBELOW60:
    INC BYTE PTR [COUNTBELOW60]  ; 60分以下的人数加1
NEXT_SCORE:
    LOOP CHECK_SCORES    ; 循环处理下一个成绩
    ; 输出统计结果
    LEA DX, MSGRESULT
    MOV AH, 09H
    INT 21H
    ; 输出每个分数段的人数
    ; 100分的人数
    LEA SI, COUNT100
    CALL PRINTCOUNT
    ; 90-100分之间的人数
    LEA SI, COUNT90TO100
    CALL PRINTCOUNT
    ; 80-90分之间的人数
    LEA SI, COUNT80TO90
    CALL PRINTCOUNT
    ; 70-80分之间的人数
    LEA SI, COUNT70TO80
    CALL PRINTCOUNT
    ; 60-70分之间的人数
    LEA SI, COUNT60TO70
    CALL PRINTCOUNT
    ; 60分以下的人数
    LEA SI, COUNTBELOW60
    CALL PRINTCOUNT
    ; 程序退出
    MOV AH, 4CH
    INT 21H
; 输出统计结果
PRINTCOUNT:
    MOV AL, [SI]  ; 读取统计结果
    ADD AL, '0'    ; 转换为ASCII字符
    MOV DL, AL     ; 存储要输出的字符
    MOV AH, 02H
    INT 21H
    RET
    MOV AH, 4CH
    INT 21H
CODES ENDS
    END START

