// ͳ���ַ�������С��ͳһ

#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main()
{
    string filename;
    cout << "Start " << endl;
    ifstream inFile("E:/ClassCode/C++/03Hafuman/data/Words.txt");
    if (!inFile)
    {
        cout << "error????" << endl;
        cout << "File not found!" << endl;
        return 0;
    }


    int letterCount[52] = { 0 }; // ͳ��52����ĸ�ĸ����������±��0��25�ֱ����a��z��26��51����A��Z
    char c;
    int spacecount = 0;
    while (inFile.get(c))
    {
        
        if (c >= 'a' && c <= 'z')
        {
            letterCount[c - 'a']++; // �����Сд��ĸ�����Ӧ��ĸ��������1
        }
        if(c >= 'A' && c <= 'Z')
        {
            letterCount[c - 'A' + 26]++; // ����Ǵ�д��ĸ�����Ӧ��ĸ��������1
        }
        if (c == ' '){
            spacecount++;
        }
    }

    ofstream outFile("./data/DataFile.data");
    //���ڴ���һ���ļ������� outFile��������Ϊ DataFile.data ���ļ����Ա㽫����д����ļ�������ļ������ڣ����ᴴ��һ���µ��ļ�������ļ��Ѿ����ڣ����Ḳ��ԭ�е����ݡ�
    //ͨ�������ǿ���ͨ�� << ������������д���ļ�
    if (!outFile)
    {
        cout << "Failed to create output file!" << endl;
        return 0;
    }
    // ���ÿ����ĸ��Ƶ��
    for (int i = 0; i < 26; i++)
    {
        outFile << (char)('a' + i) << "  " << letterCount[i] << endl;
        outFile << (char)('A' + i) << "  " << letterCount[i + 26] << endl;
    }
    outFile << "workspace" << "  " << spacecount << endl;
    cout << "Counting completed! Result saved in DataFile.data." << endl;

    inFile.close();
    outFile.close();

    return 0;
}
