#include <iostream>
#include <queue>
#include <vector>
#include <stack>
using namespace std;
const int ROW = 4;
const int COL = 4;
const int UNVISITED = 0;  
const int VISITED = 1;  
struct Node
{
    int x; 
    int y;    
};
int maze[ROW][COL] =
{
    { 0, 1, 1, 1 },
    { 0, 0, 0, 0 },
    { 0, 1, 0, 1 },
    { 0, 1, 1, 0 },
};               
void BFS(Node start, Node end)
{   
    queue<Node> q;    
    int visited[ROW][COL] = { 0 };    
    Node pre[ROW][COL];    
    q.push(start);
    visited[start.x][start.y] = VISITED;    
    Node cur;    
    Node adj[4] = { {-1, 0}, {1, 0}, {0, 1}, {0, -1} };
    while (!q.empty())
	{        
        cur = q.front();
        q.pop();        
        if (cur.x == end.x && cur.y == end.y)
		{
            cout << "found" << endl;             
            stack<Node> s;
            Node p = cur;
            while (!(p.x == start.x && p.y == start.y))
			{
                s.push(p);
                p = pre[p.x][p.y];
            }
            s.push(start);
            cout << "pass is:" << endl;
            while (!s.empty())
			{
                p = s.top();
                s.pop();
                cout << "(" << p.x << ", " << p.y << ")" << endl;
            }
            return;
        }        
        for (int i = 0; i < 4; i++)
		{            
            int nx = cur.x + adj[i].x;
            int ny = cur.y + adj[i].y;            
            if (nx < 0 || nx >= ROW || ny < 0 || ny >= COL || maze[nx][ny] == 1 ||visited[nx][ny] == VISITED) {
                continue;
            }            
			struct Node temp;
			temp.x = nx;
			temp.y = ny;
            q.push(temp);
            visited[nx][ny] = VISITED;
            pre[nx][ny] = cur;  
        }
    }    
    cout << "not found" << endl;
}
int main()
{   
    Node start = {0, 0};
    Node end = {3, 3};        
    BFS(start, end);
    return 0;
}