#include <iostream>
#include <fstream>
#include <vector>
#include <vector>
#include <sstream>
using namespace std;
#define NUM 10000
struct HuffmanTreeNode {
    int weight;
    int parent, lchild, rchild;
};
struct HuffManCode {
    string ch;
    string  code;
};

// 将读取Huffman.data文件的代码封装成函数
vector<HuffmanTreeNode> readHuffmanData() {
    vector<HuffmanTreeNode> nodes;  // 存放Huffman树节点的结构体数组
    ifstream infile("E:/ClassCode/C++/03Hafuman/data/HuffmanTree.data");  // 打开Huffman.data文件
    // 读取文件中的每一行，并将数据存入结构体中
    int weight, parent, lchild, rchild;
    while (infile >> weight >> parent >> lchild >> rchild)
    {
        HuffmanTreeNode node = { weight, parent, lchild, rchild };
        nodes.push_back(node);
    }

    infile.close();  // 关闭文件
    return nodes;
}

// 将读取HCode.data文件的代码封装成函数
vector<HuffManCode> readHuffmanCode() {
    vector<HuffManCode> codes;  // 存放哈夫曼编码的结构体数组
    ifstream infile("E:/ClassCode/C++/03Hafuman/data/Hcode.data");  // 打开HCode.data文件
    // 读取文件中的每一行，并将数据存入结构体中
    string ch;
    string code;
    while (infile >> ch >> code) {
        HuffManCode hc = { ch, code };
        codes.push_back(hc);
    }

    infile.close();  // 关闭文件
    return codes;
}


int main() {
    int  len;
    vector<HuffmanTreeNode> nodes = readHuffmanData();  // 读取Huffman.data文件并将内容存入nodes中

    // 输出结构体数组中存储的数据
    for (int i = 0; i < nodes.size(); ++i) {
        cout << "weight: " << nodes[i].weight << ", parent: " << nodes[i].parent
            << ", lchild: " << nodes[i].lchild << ", rchild: " << nodes[i].rchild << endl;
    }

    vector<HuffManCode> codes = readHuffmanCode();  // 读取HCode.data文件并将内容存入codes中

    // 输出结构体数组中存储的数据
    for (int i = 0; i < codes.size(); ++i) {
        cout << "ch: " << codes[i].ch << ", code: " << codes[i].code << endl;
    }
    string str;
    ifstream codefile("E:/ClassCode/C++/03Hafuman/data/Code.txt");    // 打开名为CodeFile.data的文件流
    getline(codefile, str);   // 从文件流中读取一行到字符串str中
    cout << " read CodeFile.data:\n" << str << endl;    // 输出读取到的字符串
    len = nodes.size();
    cout << len << endl;
    ofstream textfile("E:/ClassCode/C++/03Hafuman/data/Textfile.txt");  // 创建名为Textfile.txt的文件流
    cout << "the result of decode:"<<endl;
    int q = len;// 声明一个整型变量q，并用2 * len - 1进行初始化，表示根节点的下标
    // int q = 2*len-1;
    for (int i = 0; i < str.length(); ++i)
    {
        // 判断索引是否超出范围
        if (i >= str.length())
        {
            break;
        }
        if (str[i] == '0') {
            q = nodes[q-1].lchild;
        }  // 如果该字符为'0'，进入左子树
        if (str[i] == '1') {
            q = nodes[q-1].rchild;  // 如果该字符为'1'，进入右子树
        }
        if (nodes[q-1].lchild == 0 && nodes[q-1].rchild == 0)
        {//当该节点为叶子节点时
            if(codes[q - 1].ch == "spacework"){
                textfile << " ";   // 将该叶子节点对应的字符写入到Textfile.txt中
                cout << " ";  // 输出该叶子节点对应的字符
                
            }
            else{
                textfile << codes[q - 1].ch;   // 将该叶子节点对应的字符写入到Textfile.txt中
                cout << codes[q - 1].ch;  // 输出该叶子节点对应的字符
            }
            
            q = len;   // 将q重置为根节点的下标
            // q = 2*len-1;   // 将q重置为根节点的下标
        }
    }
    cout << "\nthe result of decode have been saved in Textfile.txt!" << endl;


    return 0;
}