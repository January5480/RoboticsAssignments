// # // // #include <iostream>
// # // // using namespace std;
// # // // void setSeed(int seed = -1); 
// # // // int main()
// # // // {
// # // //     printf("helloworld");
// # // //     setSeed(2023);
// # // //     return 0;
// # // // }
// # // #include <cstdlib>
// # // #include <ctime>
// # // #include <iostream>
// # // using namespace std;

// # // int genRand(int min, int max) { // 生成[min, max]的随机整数
// # //     return (rand() % (max - min + 1)) + min;
// # // }

// # // int main() {
// # //     srand((unsigned)time(NULL)); // 使用当前时间作为种子
// # //     cout << genRand(0, 60) << endl;
// # //     return 0;
// # // }

#include <iostream>
#include<time.h> 
#include <sstream>
#include<unistd.h>
#include<iomanip>
using namespace std;
int main()
{
	// time_t now = time(NULL);
	// tm* tm_t = localtime(&now);
    // cout << tm_t->tm_hour<<":"<<tm_t->tm_min<<":"<<tm_t->tm_sec<<endl;
    // // sleep(3);
    // sleep(15/100);
    // time_t now1 = time(NULL);
	// tm* tm_t1 = localtime(&now1);
    // cout << tm_t1->tm_hour<<":"<<tm_t1->tm_min<<":"<<tm_t->tm_sec<<endl;
    // double a = 0.15;
    // # // cout<<  ((rand() % (80 - 40 + 1)) + 40)/100;
    // # // cout<<setprecision(4)<<double(15/100);
    
	// # // stringstream ss;
	// # // ss << "year:" << tm_t->tm_year + 1900 << " month:" << tm_t->tm_mon + 1 << " day:" << tm_t->tm_mday
	// # // 	<< " hour:" << tm_t->tm_hour << " minute:" << tm_t->tm_min << " second:" << tm_t->tm_sec;
 
    // # // cout << ss.str();
	
	// # // int wait;

	// # // std::cin >> wait;

    // int num;
    // cin >> num;
    // cout << num;

    return 0;
}
