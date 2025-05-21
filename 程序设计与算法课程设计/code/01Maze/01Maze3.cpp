#include <iostream>
#include <vector>
#include <stack>

using namespace std;

// 迷宫问题
class Solution
{
    using Maze= vector<vector<int> >; //存放迷宫的二维数组
    using Pos = pair<int,int> ; // 坐标 (i,j)
    using Path = vector<Pos>; // 路径
    using Stack= stack<Path>; // 存放路径
public:
    vector<Path> solve_maze(const Maze &m,const Pos s,const Pos e){
        Stack S;
        S.push(vector<Pos>{s});
        vector<Path> L; //所有可能到达终点的路径

        while(!S.empty()){
            Path P=S.top();S.pop();
            Pos pn=P.back();
            if(e==pn){ //末尾就是终点
                L.push_back(P);
            }else{
                for(const auto pos : adj(m,pn)){
                    if(not_in(pos,P)){ //找到一个可行的节点
                        P.push_back(pos);
                        S.push(P);
                    }else{
                    ; //没有下一步可走，直接放弃这条路
                    }
                }
            }
        }
        return L;
    }
		//这一步也可以用一个全局的visited数组来标记
    bool not_in(Pos p,Path P){
        // 检查p是否不在路径P中
        for(const auto &pos:P){
            if(pos==p){
                return false;
            }
        }
        return true;
    }

    vector<Pos> adj(const Maze &m,Pos now){
        // 找出now的下一个可访问的邻居节点放入队列
        vector<Pos> pos_vec;
        int x=now.first;
        int y=now.second;

        int ds[4][2]={{0,1},{1,0},{-1,0},{0,-1}};
        for (size_t i = 0; i < 4; i++)
        {
            int nx=ds[i][0]+x;
            int ny=ds[i][1]+y;

            if (0 <= nx && nx < m.size() &&
                0 <= ny && ny < m[0].size() &&
                m[nx][ny] == 0)
            {
                pos_vec.push_back(Pos(nx, ny));
            }
        }
        return pos_vec;
    }

    void test(){
        Maze m={
            {0,0,1,0,0,0},
            {1,0,1,0,1,1},
            {0,0,0,0,0,0},
            {1,1,1,0,1,0},
            {0,0,0,0,1,0},
            {0,1,1,0,0,0},
        };

        Pos s(0,0),e(5,5);
        vector<Path> paths=solve_maze(m,s,e);
        for(auto &path:paths){
            for(auto &pos:path){
                cout<<"{"<<pos.first<<","<<pos.second<<"} ";
            }
            cout<<endl;
        }
    }
     
};


int main()
{
    Solution sol;
    sol.test();
    return 0;
}


