#include <stdio.h>

#define MAX_SIZE 100

typedef struct {
    int data[MAX_SIZE];
    int front, rear;
} Queue;

void init(Queue* q) {
    q->front = q->rear = 0;
}

int isEmpty(Queue* q) {
    return q->front == q->rear;
}

int isFull(Queue* q) {
    return q->rear == MAX_SIZE;
}

int size(Queue* q) {
    return q->rear - q->front;
}

void enqueue(Queue* q, int x) {
    if (isFull(q)) {
        printf("Error: Queue is full.\n");
        return;
    }
    q->data[q->rear++] = x;
}

int dequeue(Queue* q) {
    if (isEmpty(q)) {
        printf("Error: Queue is empty.\n");
        return -1;
    }
    return q->data[q->front++];
}

int main() {
    Queue q;
    init(&q);
    enqueue(&q, 1);
    enqueue(&q, 2);
    enqueue(&q, 3);
    printf("Size of queue: %d\n", size(&q));
	printf("%d\n", dequeue(&q));
    printf("%d\n", dequeue(&q));
    printf("%d\n", dequeue(&q));

    
    printf("Size of queue: %d\n", size(&q));
    dequeue(&q); // Test dequeue from empty queue
    return 0;
}
