#define _CRT_SECURE_NO_WARNINGS 1
#include<stdio.h>
#include<stdlib.h>
#include<string>
#include<iostream>
using namespace std;
#define MAXSIZE 100
#define INF 65535

typedef struct {
	string* Vertex; //所代表的景点名
	int Matrix[MAXSIZE][MAXSIZE]; // 景点之间的权重
	int EdgeNum, VexNum; //边的个数和顶点的个数
}MGraph;

//13个顶点，18条边
void InitMGraph(MGraph* g) {
	g->VexNum = 13;
	g->EdgeNum = 18;
	string *s = new string[13]{
		"玉屏索道入口",
		"玉屏索道出口",
		"天都峰",
		"迎客松",
		"排云溪站",
		"探海亭",
		"排云亭",
		"光明顶",
		"松谷庵站",
		"白鹤岭",
		"始信峰",
		"云谷索道入口",
		"云谷索道出口"
	};

	g->Vertex = s;


	//初始化邻接矩阵
	for (int i = 0; i < g->VexNum; i++) {
		for (int j = 0; j < g->VexNum; j++) {
			g->Matrix[i][j] = INF;
		}
	}
	g->Matrix[0][1] = 6;
	g->Matrix[1][2] = 6;
	g->Matrix[1][3] = 1;
	g->Matrix[2][3] = 2;
	g->Matrix[3][4] = 12;
	g->Matrix[4][5] = 1;
	g->Matrix[4][6] = 2;
	g->Matrix[5][6] = 2;
	g->Matrix[6][7] = 2;
	g->Matrix[6][8] = 9;
	g->Matrix[6][9] = 2;
	g->Matrix[6][10] = 2;
	g->Matrix[7][9] = 1;
	g->Matrix[8][10] = 9;
	g->Matrix[9][11] = 1;
	g->Matrix[10][11] = 2;
	g->Matrix[11][10] = 2;
	g->Matrix[11][12] = 5;
}

void PrintfMGraph(MGraph g) {
	printf("带权无向图的邻接矩阵为：\n");
	for (int i = 0; i < g.VexNum; i++) {
		for (int j = 0; j < g.VexNum; j++) {
			printf("%-10d", g.Matrix[i][j]);
		}
		printf("\n");
	}
}

//dijkstra

void dijkstra_method(MGraph* g, int dist[MAXSIZE], int path[MAXSIZE], int v0) {
	//int *tag = new int[MAXSIZE];
	int k;
	int temp;
	int min;
	
	int flag[MAXSIZE] = { 0 };
	flag[v0] = 1;
	
	for (int i = 0; i < g->VexNum; i++) {
		dist[i] = g->Matrix[v0][i];
	}
	
	for (int i = 0; i < g->VexNum; i++) {
		path[i] = -1;
	}
	int f = 0;
	for (int k = 0; k < g->VexNum; k++) {
		min = INF;
		for (int i = 0; i < g->VexNum; i++) {
			if (flag[i] == 0 && dist[i] < INF) {
				if (dist[i] < min) {
					min = dist[i];
					f = i;
				}
			}
		}
		// flag[k] = 1;
		flag[f] = 1;
		for (int i = 0; i < g->VexNum; i++) {
			temp = (g->Matrix[f][i] == INF ? INF :  g->Matrix[f][i]);
			if (flag[i] == 0 && temp + min < dist[i]) {
				dist[i] = temp + min;
				path[i] = f;
			}
		}
	}
}

int print_vi_to_vj_path(MGraph* g, int dist[MAXSIZE], int path[MAXSIZE], int vi, int vj) {
	int i;
	if (vi == vj) {
		cout<<"You are currently at this attraction."<<endl;
		return 0;
	}
	if (dist[vj] == INF) {
		cout << "sorry, " << g->Vertex[vi] << " to " << g->Vertex[vj] << "no alternative path to choose." << endl;
		return 0;
	}
	if (path[vj] == -1) {
		cout << g->Vertex[vi] << " to" << g->Vertex[vj] << " be able to reach directly, the distance is " << dist[vj] << endl;
		return 0;
	}
	cout << g->Vertex[vi] << " to " << g->Vertex[vj] << " be able to reach through the following path, the total distance is " << dist[vj] << endl;
	int road = vj;
	while (road != -1) {
		cout << g->Vertex[road] << " <- ";
		road = path[road];
	}
	cout  << g->Vertex[vi] << endl;
	return 0;
}

int select(MGraph* g, string s) {
	for (int i = 0; i < g->VexNum; i++) {
		if (g->Vertex[i].compare(s) == 0) {
			return i;
		}
	}
	return 0;
}
int main() {
	MGraph g;
	InitMGraph(&g);
	// PrintfMGraph(g);
	string start;
	string end;
	int vi;
	int vj;
	cin >> vi >> vj; 
	// printf("Please input start scenic spot:\n");
	// cin >> start;
	// start = "排云亭";
	// printf("Please input end scenic spot:\n");
	// cin >> end;
	// end = "始信峰";
	// int vi = select(&g, start);
	// int vj = select(&g, end);
	int dist[MAXSIZE];
	int path[MAXSIZE];
	dijkstra_method(&g, dist, path, vi);
	print_vi_to_vj_path(&g, dist, path, vi, vj);
	return 0;
}