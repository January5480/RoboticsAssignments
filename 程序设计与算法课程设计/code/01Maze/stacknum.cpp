#include <iostream>

using namespace std;

#define MAX_SIZE 5

typedef struct Stack {
    int data[MAX_SIZE];
    int top;
} Stack;

void push(Stack* s, int x) {
    if (s->top == MAX_SIZE - 1) {
        cout << "stack is full" << endl;
        return;
    }
    s->data[++s->top] = x;
}

int pop(Stack* s) {
    if (s->top == -1) {
        cout << "stack is empty" << endl;
        return -1;
    }
    return s->data[s->top--];
}

int main() {
   Stack s = { {0}, -1 };
   push(&s, 1);
   push(&s, 2);
   push(&s, 3);
   push(&s, 4);
   push(&s, 5);
   while (s.top >= 0)
       cout << pop(&s) << std::endl;
   return 0;
}
