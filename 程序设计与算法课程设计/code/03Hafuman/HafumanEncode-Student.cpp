#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <string>
#include <fstream>
#include <vector>
#include <sstream>
#include <cstring>
using namespace std;
#define OK 1
#define ERR 0
#define MAXSIZE 200
#define NUM 10000
string list;
int len;//当前字符串的长度
int TreeNum = 0;//标记是否成功创建哈夫曼树
typedef struct
{
	int weight;
	int parent, lchild, rchild;
}HTNode, * HuffmanTree;
typedef struct
{ 
	char ch;
	char code[NUM];
}HuffmanCode, *Hcode;


//选择两个双亲域为0且权值最小的结点
void Select(HuffmanTree HTree, int end, int& s1, int& s2)
{
	for (int i = 1; i <= end; i++)
	{
		if (HTree[i].parent == 0)
		{
			s1 = i;
			break;
		}
	}
	for (int i = 1; i <= end; i++)
	{
		if (HTree[i].weight < HTree[s1].weight && HTree[i].parent == 0)
			s1 = i;//最小权值
	}

	for (int i = 1; i <= end; i++)
	{
		if (HTree[i].parent == 0 && i != s1)
		{
			s2 = i;
			break;
		}
	}
	for (int i = 1; i <= end; i++)
	{
		if (HTree[i].weight < HTree[s2].weight && i != s1 && HTree[i].parent == 0)
			s2 = i;//次小权值
	}
}

//初始化哈夫曼树
void InitTree(HuffmanTree& HTree)
{
    string filename = "../data/DataFile.data";
    ifstream infile(filename.c_str());
    // 读取权重
	vector<int> weights;     // 定义一个int类型的向量weights
	vector<string> characters;     // 定义一个string类型的向量characters
	string line;     // 定义一个string类型的变量line
	while (getline(infile, line))     //
	{
		string character;     // 定义一个string类型的变量character
		int weight;     // 定义一个int类型的变量weight
		stringstream ss(line);     
		ss >> character >> weight;     
		if (character == "workspace")     
		{
			character = " ";     
		}
		cout << character << ":" << weight << endl;   
		weights.push_back(weight);     
	}

	stringstream SS;     // 创建一个stringstream对象SS
	for (int i = 0; i < characters.size(); i++)     
	{
		SS << characters[i];     // 将每个元素追加到SS字符串流中
	}
	list = SS.str();
	len = list.length();
	HTree = new HTNode[2 * len + 1 ];
	



	 //初始化哈夫曼树
	 for (int i = 1; i <= 2 * len - 1; i++)
      {
        HTree[i].parent = 0;
        HTree[i].lchild = 0;
        HTree[i].rchild = 0;
       }

    // 输出结果
    cout << list << endl;
	cout << len << endl;



    // 设置哈夫曼树的节点权值
    for (int i = 1; i < len; i++)
    {  
        HTree[i].weight = weights[i-1];
		cout<< HTree[i].weight<<endl;
    }
    infile.close();



	//构建哈夫曼树
	for (int i = len +1 ; i <= 2 * len - 1; i++)
	{
		int s1, s2;
		Select(HTree, i-1, s1, s2);
		HTree[s1].parent = i;
		HTree[s2].parent = i;
		HTree[i].lchild = s1; HTree[i].rchild = s2;
		HTree[i].weight = HTree[s1].weight + HTree[s2].weight;
	}


    // 在此处添加保存哈夫曼树到文件的代码
    string huffmantreefile = "./data/HuffmanTree.data";
    ofstream htreefile(huffmantreefile.c_str());
    for (int i = 1; i <= 2 * len - 1; i++) { 

        htreefile << HTree[i].weight << " " << HTree[i].parent << " " << HTree[i].lchild << " " << HTree[i].rchild << endl;
                                      
	}
	cout << "哈夫曼树结构结果已保存到HuffmanTree.data文件中" << endl;
    htreefile.close();



	//打印哈夫曼树
	cout << "\n\n" << endl;
	cout << "                       哈夫曼树如下" << endl;
	cout << "序号---" << "字符---" << "权值---" << "双亲---" << "左孩子---" << "右孩子---" << endl;
	for (int i = 1; i <= 2 * len - 1; i++)
	{
		if (i <= len)
			 
			cout << i << "	" << list[i-1] << "	" << HTree[i].weight << "	" << HTree[i].parent << "	" << HTree[i].lchild << "	" << HTree[i].rchild << endl;
		if (i > len)
			cout << i << "		" << HTree[i].weight << "	" << HTree[i].parent << "	" << HTree[i].lchild << "	" << HTree[i].rchild << endl;
	}
	TreeNum = 1;
}

//哈夫曼编码
void EnCoding(HuffmanTree HTree, Hcode &Hcode)
{
	//逐个求解l个字符的编码
	char* codenunm; // 用于存储每个字符的哈夫曼编码的字符数组
	int start,now, father; // 分别表示计算哈夫曼编码过程中的开始位置、当前节点、父节点
	cout << len << endl;
	Hcode = new HuffmanCode[len + 1]; // 动态分配空间存储哈夫曼编码表，包括len + 1个指针
	// 第0个指针不用，第1到len个指针存储每个字符的编码
	codenunm = new char[len]; // 分配空间存储临时的哈夫曼编码
	codenunm[len - 1] = '\0'; // 在最后一个位置上存储一个空字符
	for (int i = 1; i <= len; i++)
	{
		start = len - 1; // 初始化开始位置
		now = i; 
		father = HTree[i].parent;
		// 当前节点从i开始，一直追溯到根节点
		while (father != 0)
		{
			--start; 
			// 每一次追溯到父节点时，将当前节点的编码存入cd中
			if (HTree[father].lchild == now) 
				codenunm[start] = '1';
			else 
				codenunm[start] = '0';
			
			now = father; 
			father = HTree[father].parent;
			// 将当前节点的父节点赋给当前节点，向上追溯
		}
		Hcode[i].ch = list[i-1];
        strcpy(Hcode[i].code, &codenunm[start]);
	}
	delete codenunm;
	// 释放临时编码数组cd的空间
	cout << "  序号" << "	字符" << "	哈夫曼码" << endl;
	for (int i = 1; i <= len; i++)
	{
		int j = 0;
		cout << "  " << i << "	(" <<list[i-1] << ")	 ";
		 while (Hcode[i].code[j] != '\0')
        {
            cout << Hcode[i].code[j];
            j++;
        }
		cout << endl;
	}
	cout << endl;
	// 将哈夫曼编码结果输出到文件Hcode.data
	ofstream outfile("../data/Hcode.data");
    if (outfile)
      {
	       for (int i = 1; i <= len; i++)
	      {
			
		          outfile << Hcode[i].ch << " " << Hcode[i].code << endl;
			  
	       }
	       outfile.close();
	        cout << "哈夫曼编码结果已保存到Hcode.data文件中" << endl;
       }
     else
      {
	        cout << "无法打开文件Hcode.data" << endl;
       }

	//读取文件ToBeTran.data，将文本编码成报文
	ifstream tobetran("../data/ToBeTran.data");
	string Tobetran;
	getline(tobetran, Tobetran);
	cout << "读取ToBeTran.data:" << Tobetran << endl;

	ofstream code("../data/Code.txt");
	for (int i = 0; i < Tobetran.length(); i++)//每一个字符
	{
		int i_index;
		if (list.find(Tobetran[i]) != EOF)
			i_index = list.find(Tobetran[i]) + 1;//对于这个字符，在哈夫曼树中找到这个字符
		else
		{
			cout << "在您构造的哈夫曼树中找不到字符 '" << Tobetran[i] << "' !" << endl;
			return;
		}

		cout << "'" << Tobetran[i] << "'  index:" << i_index << "	" << "code:";
		int j = 0;
		while (Hcode[i_index].code[j] != '\0')
		{
			code <<  Hcode[i_index].code[j];//将得到的编码写入Code.txt中
			cout << Hcode[i_index].code[j];
			j++;
		}//每一个字符的哈夫曼编码
		cout << endl;
	}
	cout << "          编码已成功写入Code.txt文件中！" << endl;
	code.close();
}


int main()
{
	HuffmanTree hTree = NULL;
	Hcode hCode = NULL;
	int num;
	while (true)
	{
		cout << "\n" << endl;
		cout << "■■■■■■■■■■■■■■■■■■■■" << endl;
		cout << "----------创建哈夫曼树请选1-------------" << endl;
		cout << "------------进行编码请选2---------------" << endl;
		cout << "------------结束程序请选3---------------" << endl;
		cout << "■■■■■■■■■■■■■■■■■■■■" << endl;
		cout << "选择：";
		cin >> num;
		switch (num)
		{
		case 1:
		{
			cout << "\n============================================================" << endl;
			InitTree(hTree);
			cout << "============================================================\n\n" << endl;
		}break;

		case 2:
		{
			if (TreeNum == 0)
			{
				cout << "哈夫曼树尚未创建!" << endl;
				break;
			}
			cout << "\n============================================================" << endl;
			cout << "	Huffman Encode\n" << endl;
			EnCoding(hTree , hCode);
			cout << "============================================================\n\n" << endl;
		}break;

		case 3:
		{
			exit(0);
		}break;
		}
	}
	return 0;
}

