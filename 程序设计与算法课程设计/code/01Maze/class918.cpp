/**
 * 银行业务模拟系统
 * 核心代码
 * **学生版**
 * **需要补充基础代码**
 */

#include <cstdlib>
#include <ctime>
#include <iostream>
#include <queue>
using namespace std;

#define MAX_SIZE 100
#define NUM_WINDOWS 4
#define SIMULATION_DURATION 10
#define MAX_ARRIVAL_INTERVAL 2
#define MIN_SERVICE_TIME 1
#define MAX_SERVICE_TIME 2



typedef struct Customer {
    int id; // 顾客序号
    int arrival_time; // 到达时刻
    int service_time; // 需要服务的时长
} Customer, ElemType;


typedef struct {
   ElemType data[MAX_SIZE];
   int front, back,size;
} Queue;

typedef struct Window {
    int cur_remaining_service_time; // 当前正在办理业务的客户的剩余服务时长
    int remaining_service_time; // 总剩余服务时长
    int total_wait_time; // 统计该服务窗口所有顾客的等待时长
    Queue queue; // 服务窗口队列
} Window;

typedef struct Bank {
    int open_time, close_time; // 银行上下班时间
    Window windows[NUM_WINDOWS]; // 几个服务窗口
    Queue customer_queue; // 已生成的顾客队列
    int num_to_service; // 需要服务的总人数
} Bank;

bool isEmpty(Queue *q){
	if(q->back == q->front) return true;
	else return false;
}

bool isFull(Queue *q){
	if(q->back - q->front == MAX_SIZE) return true;
	else return false;
}

//入队
void enqueue(Queue* q, ElemType x) {
   if (isFull(q)) {
       printf("Error: Queue is full.\n");
       return;
   }
   q->size = q->back - q->front;
   q->data[q-> back ++] = x;
}

//出队
ElemType dequeue(Queue* q) {
   if (isEmpty(q)) {
       printf("Error: Queue is empty.\n");
       return q->data[q->front++];
   }
    q->size = q->back - q->front;
   return q->data[q->front++];
}

void initQueue(Queue *q){
	q->back = 0;
	q->front = 0;
    q->size = q->back - q->front;
}

ElemType getQueueHead(Queue* q) {
   if (isEmpty(q)) {
       printf("Error: Queue is empty.\n");
       return q->data[q->front];
   }
    return q->data[q->front];
}


void OpenForDay(Bank* bank);
void genCustomers(Bank* bank); // 生成所有顾客
void Clock(Bank* bank); // 时间推移函数
void EventDriven(Bank* bank, Customer* cur_customer, int now);
double CloseForDay(Bank* bank);
void printStatus(Bank *bank, int now);
int genRand(int min, int max);
void setSeed(int seed = -1); // -1可以代表使用时间作为随机种子

int main()
{
    setSeed(2023);
    Bank bank;
    OpenForDay(&bank); // 开门
    Clock(&bank); // 时间流逝 -> 事件驱动
    cout << "Average Staying Time per Customer: " << CloseForDay(&bank) << endl; // 关门
    return 0;
}

void OpenForDay(Bank* bank)
{ // 初始化函数
    bank->open_time = 0;
    bank->close_time = SIMULATION_DURATION;
    for (int i = 0; i < NUM_WINDOWS; ++i) { // 初始化服务窗口
        bank->windows[i].cur_remaining_service_time = 0;
        bank->windows[i].remaining_service_time = 0;
        bank->windows[i].total_wait_time = 0;
        initQueue(&bank->windows[i].queue); // 初始化服务窗口队列
    }
    initQueue(&bank->customer_queue); // 初始化已生成的顾客队列
    bank->num_to_service = 0; // 已服务的顾客数设为0
    genCustomers(bank);
}

void genCustomers(Bank* bank)
{
    int service_duration = bank->close_time - bank->open_time; // 银行开门总时长
    Customer customer = {
        0,
        genRand(0, MAX_ARRIVAL_INTERVAL), // 到达时刻
        genRand(MIN_SERVICE_TIME, MAX_SERVICE_TIME) // 服务时间
    }; // 生成新顾客
    enqueue(&bank->customer_queue, customer); // 将生成的顾客入队
    cout << "Customer " << customer.id << " Arrived at " << customer.arrival_time << " Estimated Service Time is " << customer.service_time << endl;
}

void Clock(Bank* bank)
{
    int service_duration = bank->close_time - bank->open_time; // 银行开门总时长
    for (int now = 0; now < service_duration + 1; ++now) { // 时间流逝
        for (int i = 0; i < NUM_WINDOWS; ++i) { // 时间流逝，每个窗口的剩余服务时长-1
            if (bank->windows->remaining_service_time > 0) { // 若不满足条件，则该服务窗口队列已为空
                bank->windows->remaining_service_time -= 1;
                bank->windows->cur_remaining_service_time -= 1;
                if (bank->windows->cur_remaining_service_time == 0) { // 减1之后等于0，说明顾客该走了
                    dequeue(&bank->windows->queue);
                    if (bank->windows->queue.size != 0) { // 窗口队列不为0，继续办理下一个客户
                        Customer cur_customer = getQueueHead(&bank->windows->queue);
                        bank->windows->cur_remaining_service_time = cur_customer.service_time;
                    }
                }
            }
        }
        if (bank->customer_queue.size > 0) { // 如果还有剩余顾客
            Customer cur_customer = getQueueHead(&bank->customer_queue); // 先取队头顾客，查看该顾客是否已经到达
            if (cur_customer.arrival_time == now) { // 该顾客已到达
                EventDriven(bank, &cur_customer, now);
            }
        }
        // printStatus(bank, now);
    }
}

void EventDriven(Bank* bank, Customer* cur_customer, int now)
{
    // 找到最短服务窗口队列
    int min = 0;
    for (int i = 0; i < NUM_WINDOWS; ++i) {
        if (bank->windows[i].queue.size < min) {
            min = i;
        }
    }
    // 顾客入队
    enqueue(&bank->windows[min].queue, *cur_customer);
    bank->num_to_service += 1; // 总顾客数+1
    // 统计时长
    if (bank->windows[min].remaining_service_time > 0) { // 1. 统计等待时长；要考虑到每个人的等待时长，所以要累加剩余服务时长
        bank->windows[min].total_wait_time += bank->windows[min].remaining_service_time;
    }
    bank->windows[min].total_wait_time += cur_customer->service_time; // 2. 统计服务时长
    if (bank->windows[min].remaining_service_time == 0) {
        bank->windows[min].cur_remaining_service_time = cur_customer->service_time; // 3. 总剩余服务时长为0，说明该客户为当前队列“第一个”客户
    }
    bank->windows[min].remaining_service_time += cur_customer->service_time; // 4. 刷新该队列的剩余服务时长
}

double CloseForDay(Bank* bank)
{ // 计算客户平均逗留时长
    double total_time = 0;
    for (int i = 0; i < NUM_WINDOWS; ++i) {
        total_time += bank->windows[i].total_wait_time;
    }
    return total_time / bank->num_to_service; // 假设关门时没有办理完成的顾客继续办理直到完成
}

// void printStatus(Bank *bank, int now)
// { // 打印当前队列状态
//     cout << "=====CLOCK[" << now << "]=====" << endl;
//     for (int i = 0; i < NUM_WINDOWS; ++i) {
//         ElemType* p = bank->windows[i].queue[bank->windows[i].queue.front];
//         cout << "Queue[" << i << "] ";
//         while (p != NULL) {
//             cout << p->data.id << " ";
//             p = p->next;
//         }
//         cout << "[TAIL]" << endl;
//     }
// }