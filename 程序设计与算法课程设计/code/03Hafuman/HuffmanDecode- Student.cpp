#include <iostream>
#include <fstream>
#include <vector>
#include <vector>
#include <sstream>
using namespace std;
struct HuffmanTreeNode {
    int weight;
    int parent, lchild, rchild;
};
struct HuffManCode {
    string ch;
    int  code;
};

// ����ȡHuffman.data�ļ��Ĵ����װ�ɺ���
vector<HuffmanTreeNode> readHuffmanData() {
    vector<HuffmanTreeNode> nodes;  // ���Huffman���ڵ�Ľṹ������
    ifstream infile("C://Users//KC//Desktop//�����ļ�//HuffmanTree.data");  // ��Huffman.data�ļ�
    // ��ȡ�ļ��е�ÿһ�У��������ݴ���ṹ����
    int weight, parent, lchild, rchild;
    while (infile >> weight >> parent >> lchild >> rchild)
    {

        HuffmanTreeNode node = { weight, parent, lchild, rchild };
        nodes.push_back(node);
    }

    infile.close();  // �ر��ļ�
    return nodes;
}

// ����ȡHCode.data�ļ��Ĵ����װ�ɺ���
vector<HuffManCode> readHuffmanCode() {
    vector<HuffManCode> codes;  // ��Ź���������Ľṹ������
    ifstream infile("C://Users//KC//Desktop//�����ļ�//Hcode.data");  // ��HCode.data�ļ�
    // ��ȡ�ļ��е�ÿһ�У��������ݴ���ṹ����
    string ch;
    int code;
    while (infile >> ch >> code) {
        HuffManCode hc = { ch, code };
        codes.push_back(hc);
    }

    infile.close();  // �ر��ļ�
    return codes;
}


int main() {
    int  len;
    vector<HuffmanTreeNode> nodes = readHuffmanData();  // ��ȡHuffman.data�ļ��������ݴ���nodes��

    // ����ṹ�������д洢������
    for (int i = 0; i < nodes.size(); ++i) {
        cout << "weight: " << nodes[i].weight << ", parent: " << nodes[i].parent
            << ", lchild: " << nodes[i].lchild << ", rchild: " << nodes[i].rchild << endl;
    }

    vector<HuffManCode> codes = readHuffmanCode();  // ��ȡHCode.data�ļ��������ݴ���codes��

    // ����ṹ�������д洢������
    for (int i = 0; i < codes.size(); ++i) {
        cout << "ch: " << codes[i].ch << ", code: " << codes[i].code << endl;
    }
    string str;
    ifstream codefile("C://Users//KC//Desktop//�����ļ�//CodeFile.data");    // ����ΪCodeFile.data���ļ���
    getline(codefile, str);   // ���ļ����ж�ȡһ�е��ַ���str��
    cout << "��ȡCodeFile.data:" << str << endl;    // �����ȡ�����ַ���
    len = nodes.size();
    cout << len << endl;
    ofstream textfile("C://Users//KC//Desktop//�����ļ�//Textfile.txt");  // ������ΪTextfile.txt���ļ���
    cout << "������Ϊ:";
    int q = 2 * len - 1;// ����һ�����ͱ���q������2 * len - 1���г�ʼ������ʾ���ڵ���±�
    for (int i = 0; i < str.length(); ++i)
    {
        // �ж������Ƿ񳬳���Χ
        if (i >= str.length())
        {
            break;
        }
        if (str[i] == '0') {
            q = nodes[q-1].rchild;
        }  // ������ַ�Ϊ'0'������������
        else if (str[i] == '1') {
            q = nodes[q-1].lchild;  // ������ַ�Ϊ'1'������������
        }
        if (nodes[q-1].lchild == 0 && nodes[q-1].rchild == 0)
        {//���ýڵ�ΪҶ�ӽڵ�ʱ
            
                textfile << codes[q - 1].code;   // ����Ҷ�ӽڵ��Ӧ���ַ�д�뵽Textfile.txt��
                cout << codes[q - 1].ch;  // �����Ҷ�ӽڵ��Ӧ���ַ�
            
            q = 2 * len - 1;   // ��q����Ϊ���ڵ���±�
        }
    }
    cout << "\n�������ѱ�����Textfile.txt�У�" << endl;


    return 0;
}