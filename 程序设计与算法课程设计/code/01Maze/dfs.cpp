#include<iostream>
#include<cstdio>
#include<cstdlib>
#include<cstring>
#define maxn 1000
using namespace std;
int n = 4,m = 4;//n*m�Թ� 
int flag=0; //�����ܵ��յ��·����flag��Ϊ1
int dir[4][2]={{1,0},{-1,0},{0,1},{0,-1}}; //�������� ,�ֱ�Ϊ�£��ϣ��ң��� ������ֱ���Ϊ0,1,2,3
int vis[maxn][maxn];//DFS������� 

int mp[maxn][maxn] = {
	{1, 1, 1, 1, 1, 1},
	{1, 0, 1, 1, 1, 1},
	{1, 0, 0, 0, 0, 1},
	{1, 0, 1, 0, 1, 1},
	{1, 0, 1, 0, 0, 1},
	{1, 1, 1, 1, 1, 1}
};  //������Թ� 

char mp2[maxn][maxn]; //��������Թ� 
typedef struct Point
{
    int x,y;
}SElemType;
SElemType pre[maxn][maxn];//��¼ÿ��λ�õ�ǰ��
SElemType solution[maxn*maxn];//������¼����
 
//��ջ���弰���� 
typedef struct Snode
{
    SElemType data;
    struct Snode *next;
}Snode,*Linkstack;
 
void Init_S(Linkstack &S)//��ʼ��
{
    S=(Linkstack)malloc(sizeof(Snode));
    S->next=NULL;
}
 
int IsEmpty(Linkstack S) //�ж���ջ�Ƿ�Ϊ��
{
    if(S->next==NULL) return 1; //1��ʾΪ�� 
	else return 0;
}
 
void Push(Linkstack &S,SElemType e) //ѹջ 
{
    Linkstack p=(Linkstack)malloc(sizeof(Snode));
    p->data=e;
	p->next=S->next;
    S->next=p;
}
 
void Pop(Linkstack &S,SElemType &e) //��ջ 
{
    
    if(S->next==NULL) return ;
    Linkstack p=S->next;
    e=p->data;
    S->next=p->next;
    free(p);
}
 
int Check(SElemType u)  //�����Ƿ����ϰ����Ƿ��Ѿ������� 
{
	if(mp[u.x][u.y]==0&&vis[u.x][u.y]==0)
		return 1;
	else return 0;
}
 
void Input() //�����Թ� 
{
	memset(mp,1,sizeof(mp));  //memset��ʼ�������������ǽ�ĳһ���ڴ��е�����ȫ������Ϊָ����ֵ
	for(int i=1;i<=n;++i)
        for(int j=1;j<=m;++j)
            cin>>mp[i][j];
}
 
void Output() //����Թ� 
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
 
int Direction(SElemType a,SElemType b)  //�ڵ�a->b�ķ��򣨷����������˽��ͣ� int dir[4][2]={{1,0},{-1,0},{0,1},{0,-1}}; //�������� ,�ֱ�Ϊ�£��ϣ��ң��� ������ֱ���Ϊ0,1,2,3
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
	/*k��ʾ��ǰ�ߵ��ڼ�����x��y��ʾ��ǰ��λ��*/
    //solution[k]={inx,iny};
    solution[k].x = inx;
	solution[k].y = iny;
	vis[inx][iny]=1;
    if(inx==outx&&iny==outy) Output2(k);//��������յ������˷���
    else
    for(int i=0;i<4;++i)//�ĸ��������(��������)
    {
        int u=inx+dir[i][0],v=iny+dir[i][1];
		SElemType temp = {u, v};
        if(!Check(temp)) continue;
        DFS(k+1,u,v,outx,outy);
    }
    vis[inx][iny]=0;//���ݣ�vis��Ϣ����
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