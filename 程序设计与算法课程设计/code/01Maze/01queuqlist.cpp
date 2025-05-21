#include <iostream>
using namespace std;

//队列结点
typedef struct Node
{
    int data;
    struct Node* next;
} Node;

//队列
typedef struct Queue
{
    Node* head; //队头
    Node* tail; //队尾
} Queue;

//初始化队列
void initQueue(Queue* q)
{
    q->head = q->tail = NULL;
}

//入队
void enqueue(Queue* q, int data)
{
    Node* new_node = new Node;
    new_node->data = data;
    new_node->next = NULL;
    if (q->head == NULL) //队列为空
        q->head = q->tail = new_node;
    else //队列不为空
    {
        q->tail->next = new_node;
        q->tail = new_node;
    }
}

//出队
int dequeue(Queue* q)
{
    if (q->head == NULL) //队列为空
    {
        cout << "queue is empty!" << endl;
        return -1;
    }
    int data = q->head->data;
    Node* temp = q->head;
    q->head = q->head->next;
    if (q->head == NULL) //队列已经为空
        q->tail = NULL;
    delete temp;
    return data;
}

int main()
{
    Queue q;
    initQueue(&q);
    enqueue(&q, 1);
    enqueue(&q, 2);
    enqueue(&q, 3);

    cout << dequeue(&q) << endl; //1
    cout << dequeue(&q) << endl; //2
    cout << dequeue(&q) << endl; //3
    cout << dequeue(&q) << endl; //队列为空 -1
    return 0;
}
