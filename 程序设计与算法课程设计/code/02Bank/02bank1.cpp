// 一个顾客已经ok
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <queue>
#include <vector>
#include<cstdio>
#include<cstring>
using namespace std;

#define MAX_SIZE 100
#define NUM_WINDOWS 4
#define SIMULATION_DURATION 40
#define MAX_ARRIVAL_INTERVAL 10
#define MIN_SERVICE_TIME 5
#define MAX_SERVICE_TIME 40



typedef struct Customer {
    int id; // 顾客序号
    int arrival_time; // 到达时刻
    int service_time; // 需要服务的时长
} Customer, ElemType;


typedef struct Queue
{
    Customer data[MAX_SIZE];
    int front,rear,size;
} Queue;


void initQueue(Queue *Q){
    memset(Q->data,-1,sizeof(Q));
    Q->front = 0;
    Q->rear = 0;
    Q->size = Q->rear - Q->front;
}

void enqueue(Queue* Q, Customer data)
{
    Q->data[Q-> front ++] = data;
    Q->size = Q->front - Q->rear;
}

Customer dequeue(Queue* Q)
{
    Q->size = Q->rear - Q->front;
    return Q->data[Q->rear++];
    
}

Customer getQueueHead(Queue *q){
    int t = q->front-1;
    return q->data[t];
}


typedef struct Window {
    int cur_remaining_service_time; // 当前正在办理业务的客户的剩余服务时长
    int remaining_service_time; // 总剩余服务时�?
    int total_wait_time; // 统计该服务窗口所有顾客的等待时长
    Queue queue; // 服务窗口队列
} Window;

typedef struct Bank {
    int open_time, close_time; // 银行上下班时�?
    Window windows[NUM_WINDOWS]; // 几个服务窗口
    Queue customer_queue; // 已生成的顾客队列
    int num_to_service; // 需要服务的总人�?
} Bank;

void OpenForDay(Bank* bank);
void genCustomers(Bank* bank); // 生成所有顾�?
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
    OpenForDay(&bank); // 开�?
    Clock(&bank); // 时间流�?-> 事件驱动
    cout << "Average Staying Time per Customer: " << CloseForDay(&bank)<< endl; // 关门
    return 0;
}

void setSeed(int seed){
    srand(seed);
}


int genRand(int min, int max) { // 生成[min, max]的随机整数
    // srand((unsigned)time(0));
    return (rand() % (max - min + 1)) + min;
}

void OpenForDay(Bank* bank)
{ // 初始化函�?
    bank->open_time = 0;
    bank->close_time = SIMULATION_DURATION;
    for (int i = 0; i < NUM_WINDOWS; ++i){ // 初始化服务窗�?
        bank->windows[i].cur_remaining_service_time = 0;
        bank->windows[i].remaining_service_time = 0;
        bank->windows[i].total_wait_time = 0;
        initQueue(&bank->windows[i].queue); // 初始化服务窗口队�?
    }
    initQueue(&bank->customer_queue); // 初始化已生成的顾客队�?
    bank->num_to_service = 0; // 已服务的顾客数设�?
    
    genCustomers(bank);
    
    
}

void genCustomers(Bank* bank)
{
    int service_duration = bank->close_time - bank->open_time; // 银行开门总时�?
    Customer customer = {
        0,
        genRand(0, MAX_ARRIVAL_INTERVAL), // 到达时刻
        genRand(MIN_SERVICE_TIME, MAX_SERVICE_TIME) // 服务时间
    }; // 生成新顾�?
    enqueue(&bank->customer_queue, customer); // 将生成的顾客入队
    cout << "Customer " << customer.id << " Arrived at " << customer.arrival_time << " Estimated Service Time is " << customer.service_time << endl;
}

void Clock(Bank* bank)
{
    int service_duration = bank->close_time - bank->open_time; // 银行开门总时�?
    for (int now = 0; now < service_duration + 1; ++now){ // 时间流�?
        for (int i = 0; i < NUM_WINDOWS; ++i) { // 时间流逝，每个窗口的剩余服务时�?1
            if (bank->windows[i].remaining_service_time > 0){ // 若不满足条件，则该服务窗口队列已为空
                bank->windows[i].remaining_service_time -= 1;
                bank->windows[i].cur_remaining_service_time -= 1;
                if (bank->windows[i].cur_remaining_service_time == 0) { // �?之后等于0，说明顾客该走了
                    dequeue(&bank->windows->queue);
                    if (bank->windows->queue.size != 0) { // 窗口队列不为0，继续办理下一个客�?
                        Customer cur_customer = getQueueHead(&bank->windows->queue);
                        bank->windows[i].cur_remaining_service_time = cur_customer.service_time;
                    }
                }
            }
        }
        if (bank->customer_queue.size > 0){ // 如果还有剩余顾客
            Customer cur_customer = getQueueHead(&bank->customer_queue); // 先取队头顾客，查看该顾客是否已经到达
            if (cur_customer.arrival_time == now) { // 该顾客已到达
                EventDriven(bank, &cur_customer, now);
            }
        }
        printStatus(bank, now);
    }
}

void EventDriven(Bank* bank, Customer* cur_customer, int now)
{
    // 找到最短服务窗口队�?
    int min = 0;
    for (int i = 0; i < NUM_WINDOWS; ++i){
        if (bank->windows[i].queue.size < min){
            min = i;
        }
    }
    // 顾客入队
    enqueue(&bank->windows[min].queue, *cur_customer);
    bank->num_to_service += 1; // 总顾客数+1
    // 统计时长
    if (bank->windows[min].remaining_service_time > 0){ // 1. 统计等待时长；要考虑到每个人的等待时长，所以要累加剩余服务时长
        bank->windows[min].total_wait_time += bank->windows[min].remaining_service_time;
    }
    bank->windows[min].total_wait_time += cur_customer->service_time; // 2. 统计服务时长
    if (bank->windows[min].remaining_service_time == 0){
        bank->windows[min].cur_remaining_service_time = cur_customer->service_time; // 3. 总剩余服务时长为0，说明该客户为当前队列“第一个”客�?
    }
    bank->windows[min].remaining_service_time += cur_customer->service_time; // 4. 刷新该队列的剩余服务时长
}

double CloseForDay(Bank* bank)
{ // 计算客户平均逗留时长
    double total_time = 0;
    for (int i = 0; i < NUM_WINDOWS; ++i){
        total_time += bank->windows[i].total_wait_time;
    }
    return total_time / bank->num_to_service; // 假设关门时没有办理完成的顾客继续办理直到完成
}

void printStatus(Bank *bank, int now)
{ // 打印当前队列状�?
    cout << "=====CLOCK[" << now << "]=====" << endl;
    for (int i = 0; i < NUM_WINDOWS; ++i){
        Queue p = (bank->windows[i]).queue;
        cout << "Queue[" << i << "] ";
        int rear = p.rear;
        while (rear != p.front) {
            cout << p.data[rear].id << " ";
            rear++;
        }
        cout << "[TAIL]" << endl;
    }
}
