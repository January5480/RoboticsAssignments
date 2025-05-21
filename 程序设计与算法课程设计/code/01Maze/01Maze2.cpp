#include <iostream>
#include<cstdio>
#include<cstdlib>
#include<cstring>
#include<iomanip>
using namespace std;
 
const int ROW = 4;
const int COL = 4;


const int UNVISITED = 0;  
const int VISITED = 1; 


typedef struct Point
{
    int x,y;
}SElemType;

//链栈定义及操作 
typedef struct Snode
{
    SElemType data;
    struct Snode *next;
}Snode,*Linkstack;
 
void Init_S(Linkstack &S)//初始化
{
    S=(Linkstack)malloc(sizeof(Snode));
    S->next=NULL;
}
 
int IsEmpty(Linkstack S) //判断链栈是否为空
{
    if(S->next==NULL) return 1; //1表示为空 
	else return 0;
}
 
void Push(Linkstack &S,SElemType e) //压栈 
{
    Linkstack p=(Linkstack)malloc(sizeof(Snode));
    p->data=e;
	p->next=S->next;
    S->next=p;
}
 
void Pop(Linkstack &S,SElemType &e) //出栈 
{
    
    if(S->next==NULL) return ;
    Linkstack p=S->next;
    e=p->data;
    S->next=p->next;
    free(p);
}

SElemType Get_top(Linkstack &S){
    return S->next->data;
}

int maze[ROW][COL] =
{
    { 0, 1, 1, 1 },
    { 0, 0, 0, 0 },
    { 0, 1, 0, 1 },
    { 0, 1, 0, 0 },
};

void DFS(SElemType start, SElemType end){
    int visited[ROW][COL] = { 0 };
    int direct[ROW][COL];
    memset(direct, -1, sizeof(direct));
    Snode *S;
    Init_S(S);
    Push(S, start);
    visited[start.x][start.y] = VISITED;
    int dx[4] = {1, 0, -1, 0};
    int dy[4] = {0, 1, 0, -1};//分别为下右上左,方向数组用0，1，2，3表示
    
  
    while(!IsEmpty(S)){
        SElemType s_top = Get_top(S);
        if(s_top.x == end.x &&s_top.y == end.y){
            cout << "found" << endl;
            while(!IsEmpty(S)){
                SElemType cur1;
                Pop(S,cur1);
                cout <<"("<< cur1.x << "," << cur1.y <<"," << direct[cur1.x][cur1.y] <<")"<<endl;

            }
            for(int i = 0; i < ROW; i++){
                for(int j = 0; j < COL; j++){
                    if(maze[i][j] == 1){
                        cout<<setw(4)<<"#";
                    }
                    else{
                        cout<<setw(4)<<direct[i][j];
                    }                
                }
                cout<<endl;
            }
            return;
        }
        int i = 0;
        for(i = 0; i < 4; i++){
            int nx = S->next->data.x + dx[i];
            int ny = S->next->data.y + dy[i];
            if(nx>=0&&ny>=0&&nx<ROW&&ny<COL&&maze[nx][ny]==0&&visited[nx][ny]==UNVISITED){
                direct[S->next->data.x][S->next->data.y] = i;
                visited[nx][ny] = VISITED;
                SElemType data = {nx, ny};
                Push(S, data);
                break;
            }
        }
        if(i == 4){
            SElemType cur;
            Pop(S,cur);
        }
    }
    
    cout << "not found" <<endl;
    return;
}

int main()
{
    SElemType start = {0, 0};
    SElemType end = {3, 3};
    
    DFS(start, end);
    
    return 0;
}