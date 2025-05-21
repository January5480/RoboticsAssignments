#include <iostream>
using namespace std;

typedef struct Node {
    int data;
    struct Node* next;
} Node;

void push(Node** head, int data) {
    Node* new_node = new Node;
    new_node->data = data;
    new_node->next = *head;
    *head = new_node;
}

int pop(Node** head) {
    if (*head == NULL) {
        cout << "Stack is empty." << endl;
        return -1;
    }
    int data = (*head)->data;
    Node* temp = *head;
    *head = (*head)->next;
    delete temp;
    return data;
}

int main() {
    Node* head = NULL;
    push(&head, 1);
    push(&head, 2);
    push(&head, 3);

    cout << pop(&head) << endl; // output: 3
    cout << pop(&head) << endl; // output: 2
    cout << pop(&head) << endl; // output: 1
    cout << pop(&head) << endl; // output: Stack is empty. -1
    return 0;
}
