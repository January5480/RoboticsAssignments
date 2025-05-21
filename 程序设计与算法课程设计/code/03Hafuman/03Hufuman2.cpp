// 统计字符串，大小不统一

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


    int letterCount[52] = { 0 }; // 统计52个字母的个数，数组下标从0到25分别代表a到z，26到51代表A到Z
    char c;
    int spacecount = 0;
    while (inFile.get(c))
    {
        
        if (c >= 'a' && c <= 'z')
        {
            letterCount[c - 'a']++; // 如果是小写字母，则对应字母计数器加1
        }
        if(c >= 'A' && c <= 'Z')
        {
            letterCount[c - 'A' + 26]++; // 如果是大写字母，则对应字母计数器加1
        }
        if (c == ' '){
            spacecount++;
        }
    }

    ofstream outFile("./data/DataFile.data");
    //用于创建一个文件流对象 outFile，并打开名为 DataFile.data 的文件，以便将数据写入该文件。如果文件不存在，将会创建一个新的文件；如果文件已经存在，将会覆盖原有的内容。
    //通常，我们可以通过 << 操作符将数据写入文件
    if (!outFile)
    {
        cout << "Failed to create output file!" << endl;
        return 0;
    }
    // 输出每个字母的频率
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
