#include<iostream>
#include<cstdio>
#include<cstdlib>
#include<cstring>
#define maxn 1000
using namespace std;
int n = 4,m = 4;//n*m迷宫 
int flag=0; //若有能到终点的路，则flag变为1
int dir[4][2]={{1,0},{-1,0},{0,1},{0,-1}}; //方向数组 ,分别为下，上，右，左 ，输出分别设为0,1,2,3
int vis[maxn][maxn];//DFS标记数组 

int mp[maxn][maxn] = {
	{1, 1, 1, 1, 1, 1},
	{1, 0, 1, 1, 1, 1},
	{1, 0, 0, 0, 0, 1},
	{1, 0, 1, 0, 1, 1},
	{1, 0, 1, 0, 0, 1},
	{1, 1, 1, 1, 1, 1}
};  //输入的迷宫 

char mp2[maxn][maxn]; //待输出的迷宫 
typedef struct Point
{
    int x,y;
}SElemType;
SElemType pre[maxn][maxn];//记录每个位置的前驱
SElemType solution[maxn*maxn];//方案记录数组
 
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
 
int Check(SElemType u)  //检查点是否有障碍和是否已经遍历过 
{
	if(mp[u.x][u.y]==0&&vis[u.x][u.y]==0)
		return 1;
	else return 0;
}
 
void Input() //输入迷宫 
{
	memset(mp,1,sizeof(mp));  //memset初始化函数。作用是将某一块内存中的内容全部设置为指定的值
	for(int i=1;i<=n;++i)
        for(int j=1;j<=m;++j)
            cin>>mp[i][j];
}
 
void Output() //输出迷宫 
{
	printf("maze is:\n\n");
    for(int i=1;i<=n;++i)
    {
        for(int j=1;j<=m;++j) 
			cout<<mp[i][j];
        cout<<endl;
    }
    cout<<endl;	
}
 
int Direction(SElemType a,SElemType b)  //节点a->b的方向（方向数组做了解释） int dir[4][2]={{1,0},{-1,0},{0,1},{0,-1}}; //方向数组 ,分别为下，上，右，左 ，输出分别设为0,1,2,3
{
	for(int i=0;i<4;++i)
		if(b.x==a.x+dir[i][0]&&b.y==a.y+dir[i][1])
			return i;
    return 4;
}
 
void Output2(int len) 
{
	for(int i=1;i<=n;++i)
        for(int j=1;j<=m;++j)
            mp2[i][j]=mp[i][j]+48;
    for(int i=1;i<len;++i)
    {
        int x=solution[i].x,y=solution[i].y,d=Direction(solution[i],solution[i+1]);
        if(d==0) mp2[x][y]='D';
        if(d==1) mp2[x][y]='U';
        if(d==2) mp2[x][y]='R';
        if(d==3) mp2[x][y]='L';    //DOWN,UP,RIGHT,LEFT
    }
    flag=1;
    for(int i=1;i<=n;++i)
    {
        for(int j=1;j<=m;++j)
            printf("%c ",mp2[i][j]);
        printf("\n");
    }
    printf("\n");
}
void DFS(int k,int inx,int iny,int outx,int outy) 
{
	/*k表示当前走到第几步，x，y表示当前的位置*/
    //solution[k]={inx,iny};
    solution[k].x = inx;
	solution[k].y = iny;
	vis[inx][iny]=1;
    if(inx==outx&&iny==outy) Output2(k);//如果到了终点就输出此方案
    else
    for(int i=0;i<4;++i)//四个方向遍历(下上右左)
    {
        int u=inx+dir[i][0],v=iny+dir[i][1];
		SElemType temp = {u, v};
        if(!Check(temp)) continue;
        DFS(k+1,u,v,outx,outy);
    }
    vis[inx][iny]=0;//回溯，vis信息清零
}
void Solve2(int a,int b,int c,int d)
{
	cout<<"found"<<endl;
	flag=0;
	memset(vis,0,sizeof(vis));
	DFS(1,a,b,c,d);
	if(!flag) cout<<"not found"<<endl;
}
 
int main(){
//	freopen("text1.txt","r",stdin); 

	int a = 1,b = 1,c = 4,d = 4;
		//Input();
	Output();
	Solve2(a,b,c,d);
	cout<<"xxxxxxxxxxxxxxxxxxxxxx"<<endl;
	
	return 0;
} 