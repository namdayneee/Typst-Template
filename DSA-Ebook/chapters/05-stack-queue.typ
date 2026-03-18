#import "../components/template.typ": *

= Stack và Queue

== Tổng quan chương

=== Nội dung chính

Stack và Queue là hai cấu trúc dữ liệu *Restricted List* - chỉ cho phép thêm/xóa ở các đầu cụ thể:

*Stack (Ngăn xếp):*
- LIFO: Last-In-First-Out
- Thêm/xóa ở một đầu (top)
- Ứng dụng: Undo/Redo, Function call stack, Expression evaluation

*Queue (Hàng đợi):*
- FIFO: First-In-First-Out
- Thêm ở cuối (rear), xóa ở đầu (front)
- Ứng dụng: Task scheduling, BFS, Print queue

=== Kiến thức nền

- List ADT (Chapter 4)
- Array và Linked List implementation

=== Linear List Concepts

*General list:*
- Không có hạn chế về các thao tác có thể sử dụng
- Không có hạn chế về vị trí thêm/xóa dữ liệu

*Restricted list:*
- Chỉ một số thao tác nhất định có thể sử dụng
- Dữ liệu chỉ có thể thêm/xóa ở các đầu của list

#pagebreak()

== Basic Operations of Stacks

=== Định nghĩa Stack

*Stack* là một dãy hữu hạn các phần tử kiểu T, trong đó tất cả các thao tác thêm và xóa được giới hạn ở một đầu gọi là *top* (đỉnh).

Stack là cấu trúc dữ liệu *LIFO (Last In - First Out)*:
- Phần tử cuối cùng được thêm vào là phần tử đầu tiên được lấy ra

*Ví dụ trực quan:*
```
Stack of plates (chồng đĩa):
    ┌───┐
    │ 3 │ ← Top (thêm/xóa ở đây)
    ├───┤
    │ 2 │
    ├───┤
    │ 1 │
    └───┘

Push 4:     Pop:
┌───┐       ┌───┐
│ 4 │ →     │ 3 │ ← Removed
├───┤       ├───┤
│ 3 │       │ 2 │
├───┤       └───┘
│ 2 │
├───┤
│ 1 │
└───┘
```

=== Các thao tác cơ bản

*Basic operations:*
- Construct: Tạo stack rỗng
- Push: Đưa phần tử mới lên đỉnh stack
- Pop: Lấy phần tử ở đỉnh stack ra
- Top: Truy xuất phần tử ở đỉnh (không xóa)

*Extended operations:*
- isEmpty(): Kiểm tra stack rỗng
- isFull(): Kiểm tra stack đầy
- size(): Số lượng phần tử
- clear(): Xóa toàn bộ stack

=== Tại sao cần Stack?

*Function calls trong chương trình:*
- Mỗi lần gọi hàm → Push vào call stack
- Return → Pop khỏi stack

*Undo/Redo:*
- Mỗi action → Push vào stack
- Undo → Pop ra

*Expression evaluation:*
- Tính toán biểu thức toán học
- Chuyển infix → postfix

#pagebreak()

== Implementation of Stacks

=== Linked-list Implementation

*Stack structure:*
```
stack
  count <integer>
  top <node pointer>
end stack
```

*Stack node structure:*
```
node
  data <dataType>
  next <node pointer>
end node
```

*C++ Implementation:*

```cpp
template <class ItemType>
struct Node {
    ItemType data;
    Node<ItemType>* next;
};

template <class List_ItemType>
class Stack {
public:
    Stack();
    ~Stack();
    void Push(List_ItemType dataIn);
    int Pop(List_ItemType& dataOut);
    int GetStackTop(List_ItemType& dataOut);
    void Clear();
    int IsEmpty();
    int GetSize();
    Stack<List_ItemType>* Clone();
    void Print2Console();
    
private:
    Node<List_ItemType>* top;
    int count;
};
```

=== Create an Empty Linked Stack

*Algorithm createStack:*
```
Algorithm createStack(ref stack <metadata>)
  Pre: stack is a metadata structure of a stack
  Post: metadata initialized
  
  stack.count = 0
  stack.top = null
  return
End createStack
```

*C++ Implementation:*
```cpp
template <class List_ItemType>
Stack<List_ItemType>::Stack() {
    this->top = NULL;
    this->count = 0;
}

template <class List_ItemType>
Stack<List_ItemType>::~Stack() {
    this->Clear();
}
```

#pagebreak()

=== Push Data into a Linked Stack

*Các bước thực hiện:*
- Cấp phát bộ nhớ cho node mới và thiết lập dữ liệu
- Cập nhật con trỏ: Node mới trỏ đến top hiện tại
- Con trỏ top trỏ đến node mới
- Tăng count

*Algorithm pushStack:*
```
Algorithm pushStack(ref stack <metadata>, val data <dataType>)
  Pre: stack is a metadata structure to a valid stack
       data contains value to be pushed into the stack
  Post: data have been pushed in stack
  Return: true if successful; false if memory overflow
  
  if stack full then
    success = false
  else
    allocate(pNew)
    pNew->data = data
    pNew->next = stack.top
    stack.top = pNew
    stack.count = stack.count + 1
    success = true
  end
  return success
End pushStack
```

*C++ Implementation:*
```cpp
template <class List_ItemType>
void Stack<List_ItemType>::Push(List_ItemType value) {
    Node<List_ItemType>* pNew = new Node<List_ItemType>();
    pNew->data = value;
    pNew->next = this->top;
    this->top = pNew;
    this->count++;
}
```

*Lưu ý:*
- Push thành công khi cấp phát bộ nhớ thành công
- Không có sự khác biệt giữa push vào stack có phần tử và stack rỗng

#pagebreak()

=== Pop Linked Stack

*Các bước thực hiện:*
- dltPtr giữ phần tử ở đỉnh stack
- top trỏ đến phần tử kế tiếp
- Giải phóng dltPtr và giảm count

*Algorithm popStack:*
```
Algorithm popStack(ref stack <metadata>, ref dataOut <dataType>)
  Pre: stack is a metadata structure to a valid stack
       dataOut is to receive the popped data
  Post: data have been returned to caller
  Return: true if successful; false if stack is empty
  
  if stack empty then
    success = false
  else
    dltPtr = stack.top
    dataOut = stack.top->data
    stack.top = stack.top->next
    stack.count = stack.count - 1
    recycle(dltPtr)
    success = true
  end
  return success
End popStack
```

*C++ Implementation:*
```cpp
template <class List_ItemType>
int Stack<List_ItemType>::Pop(List_ItemType& dataOut) {
    if (this->GetSize() == 0)
        return 0;
    
    Node<List_ItemType>* dltPtr = this->top;
    dataOut = dltPtr->data;
    this->top = dltPtr->next;
    this->count--;
    delete dltPtr;
    return 1;
}
```

#pagebreak()

=== Stack Top

*Algorithm stackTop:*
```
Algorithm stackTop(ref stack <metadata>, ref dataOut <dataType>)
  Pre: stack is a metadata structure to a valid stack
       dataOut is to receive top stack data
  Post: data have been returned to caller
  Return: true if successful; false if stack is empty
  
  if stack empty then
    success = false
  else
    dataOut = stack.top->data
    success = true
  end
  return success
End stackTop
```

*C++ Implementation:*
```cpp
template <class List_ItemType>
int Stack<List_ItemType>::GetStackTop(List_ItemType& dataOut) {
    if (this->GetSize() == 0)
        return 0;
    dataOut = this->top->data;
    return 1;
}
```

=== Destroy Stack

*Algorithm destroyStack:*
```
Algorithm destroyStack(ref stack <metadata>)
  Pre: stack is a metadata structure to a valid stack
  Post: stack empty and all nodes recycled
  
  if stack not empty then
    while stack.top not null do
      temp = stack.top
      stack.top = stack.top->next
      recycle(temp)
    end
  end
  stack.count = 0
  return
End destroyStack
```

*C++ Implementation:*
```cpp
template <class List_ItemType>
void Stack<List_ItemType>::Clear() {
    Node<List_ItemType>* temp;
    while (this->top != NULL) {
        temp = this->top;
        this->top = this->top->next;
        delete temp;
    }
    this->count = 0;
}
```

#pagebreak()

=== isEmpty và isFull Linked Stack

*isEmpty Algorithm:*
```
Algorithm isEmpty(ref stack <metadata>)
  Pre: stack is a metadata structure to a valid stack
  Post: return stack status
  Return: true if the stack is empty, false otherwise
  
  if count = 0 then
    Return true
  else
    Return false
  end
End isEmpty
```

*C++ Implementation:*
```cpp
template <class List_ItemType>
int Stack<List_ItemType>::IsEmpty() {
    return (count == 0);
}

template <class List_ItemType>
int Stack<List_ItemType>::GetSize() {
    return count;
}

template <class List_ItemType>
int Stack<List_ItemType>::IsFull() {
    Node<List_ItemType>* pNew = new Node<List_ItemType>();
    if (pNew != NULL) {
        delete pNew;
        return 0;
    } else {
        return 1;
    }
}
```

=== Print Stack

```cpp
template <class List_ItemType>
void Stack<List_ItemType>::Print2Console() {
    Node<List_ItemType>* p;
    p = this->top;
    while (p != NULL) {
        cout << p->data << " ";
        p = p->next;
    }
    cout << endl;
}
```

#pagebreak()

=== Using Linked Stack

```cpp
int main(int argc, char* argv[]) {
    Stack<int>* myStack = new Stack<int>();
    int val;
    
    myStack->Push(7);
    myStack->Push(9);
    myStack->Push(10);
    myStack->Push(8);
    
    myStack->Print2Console();  // 8 10 9 7
    
    myStack->Pop(val);
    myStack->Print2Console();  // 10 9 7
    
    delete myStack;
    return 0;
}
```

#pagebreak()

== Array-based Stack Implementation

=== Nguyên lý

Implementation của array-based stack rất đơn giản. Sử dụng biến `top` để trỏ đến phần tử trên cùng của stack trong mảng.

*Các bước:*
- Ban đầu: top = -1
- Push: Tăng top lên 1 và ghi phần tử vào storage[top]
- Pop: Kiểm tra top != -1 và giảm top đi 1
- getTop: Kiểm tra top != -1 và trả về storage[top]
- isEmpty: Trả về boolean nếu top == -1

=== C++ Implementation

```cpp
#include <string>
using namespace std;

class ArrayStack {
private:
    int top;
    int capacity;
    int* storage;
    
public:
    ArrayStack(int capacity) {
        storage = new int[capacity];
        this->capacity = capacity;
        top = -1;
    }
    
    ~ArrayStack() {
        delete[] storage;
    }
    
    void push(int value) {
        if (top == capacity - 1)
            throw string("Stack is overflow");
        top++;
        storage[top] = value;
    }
    
    void pop(int& dataOut) {
        if (top == -1)
            throw string("Stack is empty");
        dataOut = storage[top];
        top--;
    }
    
    int getTop() {
        if (top == -1)
            throw string("Stack is empty");
        return storage[top];
    }
    
    bool isEmpty() {
        return (top == -1);
    }
    
    bool isFull() {
        return (top == capacity - 1);
    }
    
    int getSize() {
        return top + 1;
    }
    
    void print2Console() {
        if (top > -1) {
            for (int i = top; i >= 0; i--) {
                cout << storage[i] << " ";
            }
            cout << endl;
        }
    }
};
```

#pagebreak()

=== Using Array-based Stack

```cpp
int main(int argc, char* argv[]) {
    ArrayStack* myStack = new ArrayStack(10);
    int val;
    
    myStack->push(7);
    myStack->push(9);
    myStack->push(10);
    myStack->push(8);
    
    myStack->print2Console();  // 8 10 9 7
    
    myStack->pop(val);
    myStack->print2Console();  // 10 9 7
    
    delete myStack;
    return 0;
}
```

=== So sánh Array vs Linked Stack

*Array-based Stack:*
- Độ phức tạp: Push/Pop/Top: O(1)
- Không gian: Fixed size O(MAX_SIZE)
- Ưu điểm: Đơn giản, truy xuất nhanh
- Nhược điểm: Kích thước cố định

*Linked Stack:*
- Độ phức tạp: Push/Pop/Top: O(1)
- Không gian: Dynamic O(n)
- Ưu điểm: Kích thước linh hoạt
- Nhược điểm: Overhead của con trỏ

#pagebreak()

== Applications of Stack

Stack được sử dụng trong nhiều ứng dụng quan trọng:

*Reversing Data:*
- Đảo ngược danh sách
- Chuyển đổi Decimal sang Binary

*Parsing:*
- Kiểm tra cặp ngoặc (Brackets Parse)
- Phân tích cú pháp

*Postponement of Processing:*
- Chuyển đổi Infix sang Postfix
- Tính giá trị biểu thức Postfix

*Backtracking:*
- Bài toán Goal Seeking
- Knight's Tour
- Thoát khỏi mê cung
- Bài toán Eight Queens

*Function Call Stack:*
```cpp
void c() { /* ... */ }
void b() { c(); }
void a() { b(); }
int main() { a(); }

Call Stack:
┌─────────┐
│  c()    │ ← Top
├─────────┤
│  b()    │
├─────────┤
│  a()    │
├─────────┤
│ main()  │
└─────────┘
```

Khi c() return → Pop khỏi stack → Quay lại b()

*Stack Overflow:*
```cpp
void infiniteRecursion() {
    infiniteRecursion();  // Không có base case!
}
// → Stack tràn → Program crash!
```

#pagebreak()

== Basic Operations of Queues

=== Định nghĩa Queue

*Queue* là một dãy hữu hạn các phần tử kiểu T, trong đó dữ liệu chỉ có thể được thêm vào ở một đầu gọi là *rear* (cuối) và xóa từ đầu kia gọi là *front* (đầu).

Queue là cấu trúc dữ liệu *FIFO (First In - First Out)*:
- Phần tử đầu tiên được thêm vào là phần tử đầu tiên được lấy ra

*Ví dụ trực quan:*
```
Queue at ticket counter (hàng mua vé):
                    Rear (thêm vào đây)
                      ↓
Front → [1][2][3][4][5]
↑
Dequeue (lấy ra ở đây)

Enqueue 6:          Dequeue:
Front → [1][2][3][4][5][6]    Front → [2][3][4][5]
                                      (1 removed)
```

=== Các thao tác cơ bản

*Basic operations:*
- Construct: Tạo queue rỗng
- Enqueue: Đưa phần tử mới vào cuối queue
- Dequeue: Lấy phần tử ở đầu queue ra
- Queue Front: Truy xuất phần tử đầu (không xóa)
- Queue Rear: Truy xuất phần tử cuối (không xóa)

=== Tại sao cần Queue?

*Task Scheduling:*
- CPU scheduling: Các process chờ CPU
- Print queue: Các file chờ in

*BFS (Breadth-First Search):*
- Duyệt graph/tree theo từng cấp độ

*Buffering:*
- Keyboard buffer
- Network packet queue

#pagebreak()

== Implementation of Queue

=== Linked-list Implementation

*Queue structure:*
```
queue
  count <integer>
  front <node pointer>
  rear <node pointer>
end queue
```

*Queue node structure:*
```
node
  data <dataType>
  next <node pointer>
end node
```

*C++ Implementation:*

```cpp
template <class ItemType>
struct Node {
    ItemType data;
    Node<ItemType>* next;
};

template <class List_ItemType>
class Queue {
public:
    Queue();
    ~Queue();
    void Enqueue(List_ItemType dataIn);
    int Dequeue(List_ItemType& dataOut);
    int GetQueueFront(List_ItemType& dataOut);
    int GetQueueRear(List_ItemType& dataOut);
    void Clear();
    int IsEmpty();
    int GetSize();
    void Print2Console();
    
private:
    Node<List_ItemType>* front;
    Node<List_ItemType>* rear;
    int count;
};
```

#pagebreak()

=== Create Queue

*Algorithm createQueue:*
```
Algorithm createQueue(ref queue <metadata>)
  Pre: queue is a metadata structure of a queue
  Post: metadata initialized
  
  queue.count = 0
  queue.front = null
  queue.rear = null
  return
End createQueue
```

*C++ Implementation:*
```cpp
template <class List_ItemType>
Queue<List_ItemType>::Queue() {
    this->count = 0;
    this->front = NULL;
    this->rear = NULL;
}

template <class List_ItemType>
Queue<List_ItemType>::~Queue() {
    this->Clear();
}
```

=== Enqueue

*Algorithm enqueue:*
```
Algorithm enqueue(ref queue <metadata>, val data <dataType>)
  Pre: queue is a metadata structure of a valid queue
       data contains data to be inserted into queue
  Post: data have been inserted in queue
  Return: true if successful, false if memory overflow
  
  if queue full then
    return false
  end
  
  allocate(newPtr)
  newPtr->data = data
  newPtr->next = null
  
  if queue.count = 0 then
    queue.front = newPtr  // Insert into an empty queue
  else
    queue.rear->next = newPtr  // Insert into a queue with data
  end
  
  queue.rear = newPtr
  queue.count = queue.count + 1
  return true
End enqueue
```

#pagebreak()

*C++ Implementation:*
```cpp
template <class List_ItemType>
void Queue<List_ItemType>::Enqueue(List_ItemType value) {
    Node<List_ItemType>* newPtr = new Node<List_ItemType>();
    newPtr->data = value;
    newPtr->next = NULL;
    
    if (this->count == 0)
        this->front = newPtr;
    else
        this->rear->next = newPtr;
    
    this->rear = newPtr;
    this->count++;
}
```

=== Dequeue

*Algorithm dequeue:*
```
Algorithm dequeue(ref queue <metadata>, ref dataOut <dataType>)
  Pre: queue is a metadata structure of a valid queue
       dataOut is to receive dequeued data
  Post: front data have been returned to caller
  Return: true if successful, false if queue is empty
  
  if queue empty then
    return false
  end
  
  dataOut = queue.front->data
  dltPtr = queue.front
  
  if queue.count = 1 then
    queue.rear = NULL  // Delete data in a queue with only one item
  end
  
  queue.front = queue.front->next
  queue.count = queue.count - 1
  recycle(dltPtr)
  return true
End dequeue
```

#pagebreak()

*C++ Implementation:*
```cpp
template <class List_ItemType>
int Queue<List_ItemType>::Dequeue(List_ItemType& dataOut) {
    if (count == 0)
        return 0;
    
    dataOut = front->data;
    Node<List_ItemType>* dltPtr = this->front;
    
    if (count == 1)
        this->rear = NULL;
    
    this->front = this->front->next;
    this->count--;
    delete dltPtr;
    return 1;
}
```

=== Queue Front and Rear

```cpp
template <class List_ItemType>
int Queue<List_ItemType>::GetQueueFront(List_ItemType& dataOut) {
    if (count == 0)
        return 0;
    dataOut = this->front->data;
    return 1;
}

template <class List_ItemType>
int Queue<List_ItemType>::GetQueueRear(List_ItemType& dataOut) {
    if (count == 0)
        return 0;
    dataOut = this->rear->data;
    return 1;
}
```

#pagebreak()

=== Destroy Queue

*Algorithm destroyQueue:*
```
Algorithm destroyQueue(ref queue <metadata>)
  Pre: queue is a metadata structure of a valid queue
  Post: queue empty and all nodes recycled
  
  if queue not empty then
    while queue.front not null do
      temp = queue.front
      queue.front = queue.front->next
      recycle(temp)
    end
  end
  
  queue.front = NULL
  queue.rear = NULL
  queue.count = 0
  return
End destroyQueue
```

*C++ Implementation:*
```cpp
template <class List_ItemType>
void Queue<List_ItemType>::Clear() {
    Node<List_ItemType>* temp;
    while (this->front != NULL) {
        temp = this->front;
        this->front = this->front->next;
        delete temp;
    }
    this->front = NULL;
    this->rear = NULL;
    this->count = 0;
}
```

=== Queue Empty

```cpp
template <class List_ItemType>
int Queue<List_ItemType>::IsEmpty() {
    return (this->count == 0);
}

template <class List_ItemType>
int Queue<List_ItemType>::GetSize() {
    return this->count;
}
```

#pagebreak()

=== Print Queue

```cpp
template <class List_ItemType>
void Queue<List_ItemType>::Print2Console() {
    Node<List_ItemType>* p;
    p = this->front;
    cout << "Front: ";
    while (p != NULL) {
        cout << p->data << " ";
        p = p->next;
    }
    cout << endl;
}
```

=== Using Linked Queue

```cpp
int main(int argc, char* argv[]) {
    Queue<int>* myQueue = new Queue<int>();
    int val;
    
    myQueue->Enqueue(7);
    myQueue->Enqueue(9);
    myQueue->Enqueue(10);
    myQueue->Enqueue(8);
    
    myQueue->Print2Console();  // Front: 7 9 10 8
    
    myQueue->Dequeue(val);
    myQueue->Print2Console();  // Front: 9 10 8
    
    delete myQueue;
    return 1;
}
```

#pagebreak()

== Array-based Queue Implementation

=== C++ Implementation

```cpp
#include <string>
using namespace std;

class ArrayQueue {
private:
    int capacity;
    int front;
    int rear;
    int* storage;
    
public:
    ArrayQueue(int capacity) {
        storage = new int[capacity];
        this->capacity = capacity;
        front = -1;
        rear = -1;
    }
    
    ~ArrayQueue() {
        delete[] storage;
    }
    
    void enQueue(int value) {
        if (isFull())
            throw string("Queue is full");
        
        if (front == -1)
            front = 0;
        
        rear++;
        storage[rear % capacity] = value;
    }
    
    void deQueue(int& valueOut) {
        if (isEmpty())
            throw string("Queue is empty");
        
        valueOut = storage[front % capacity];
        front++;
    }
    
    int getFront() {
        if (isEmpty())
            throw string("Queue is empty");
        return storage[front % capacity];
    }
    
    int getRear() {
        if (isEmpty())
            throw string("Queue is empty");
        return storage[rear % capacity];
    }
    
    bool isEmpty() {
        return (front > rear || front == -1);
    }
    
    bool isFull() {
        return (rear - front + 1 == capacity);
    }
    
    int getSize() {
        return rear - front + 1;
    }
};
```

#pagebreak()

=== Using Array-based Queue

```cpp
int main(int argc, char* argv[]) {
    ArrayQueue* myQueue = new ArrayQueue(10);
    int val;
    
    myQueue->enQueue(7);
    myQueue->enQueue(9);
    myQueue->enQueue(10);
    myQueue->enQueue(8);
    
    myQueue->deQueue(val);  // val = 7
    
    delete myQueue;
    return 1;
}
```

=== So sánh Array vs Linked Queue

*Array-based Queue (Circular):*
- Độ phức tạp: Enqueue/Dequeue: O(1)
- Không gian: Fixed O(MAX_SIZE)
- Ưu điểm: Đơn giản, hiệu quả
- Nhược điểm: Kích thước cố định

*Linked Queue:*
- Độ phức tạp: Enqueue/Dequeue: O(1)
- Không gian: Dynamic O(n)
- Ưu điểm: Kích thước linh hoạt
- Nhược điểm: Overhead của con trỏ

#pagebreak()

== Applications of Queue

Queue được sử dụng trong nhiều ứng dụng:

*Polynomial Arithmetic:*
- Tính toán đa thức

*Categorizing Data:*
- Phân loại dữ liệu

*Expression Evaluation:*
- Tính giá trị biểu thức Prefix

*Radix Sort:*
- Thuật toán sắp xếp cơ số

*Queue Simulation:*
- Mô phỏng hàng đợi

*Task Scheduling:*
- CPU scheduling
- Print spooler
- Network packet routing

*BFS Algorithm:*
- Duyệt đồ thị theo chiều rộng

#pagebreak()

== Lỗi phổ biến

*Stack Overflow:*
```cpp
// ❌ Không kiểm tra full
void push(int x) {
    data[++top] = x;  // Nguy hiểm!
}

// ✅ ĐÚNG
void push(int x) {
    if (isFull()) {
        throw "Stack overflow!";
    }
    data[++top] = x;
}
```

*Queue: Quên dùng modulo trong circular queue:*
```cpp
// ❌ SAI
rear = rear + 1;

// ✅ ĐÚNG
rear = (rear + 1) % MAX_SIZE;
```

*Pop/Dequeue từ cấu trúc rỗng:*
```cpp
// ❌ Không kiểm tra empty
int pop() {
    return data[top--];  // Lỗi nếu stack rỗng!
}

// ✅ ĐÚNG
int pop() {
    if (isEmpty()) {
        throw "Stack underflow!";
    }
    return data[top--];
}
```

#pagebreak()

== Khi nào dùng Stack và Queue

*Dùng Stack khi:*
- Cần LIFO (phần tử gần nhất vào - gần nhất ra)
- Undo/Redo operations
- Backtracking algorithms
- Expression evaluation
- DFS (Depth-First Search)
- Function call management

*Dùng Queue khi:*
- Cần FIFO (xử lý theo thứ tự đến)
- Task scheduling
- BFS (Breadth-First Search)
- Buffering (keyboard, network)
- Print queue management
- Request handling

#pagebreak()

== Tóm tắt

*Stack - LIFO:*
- Thêm và xóa ở một đầu (top)
- Operations: Push, Pop, Top - tất cả O(1)
- Implementation: Array (fixed size) hoặc Linked List (dynamic)
- Ứng dụng: Function calls, Undo/Redo, Expression evaluation, DFS

*Queue - FIFO:*
- Thêm ở rear, xóa ở front
- Operations: Enqueue, Dequeue, Front, Rear - tất cả O(1)
- Implementation: Array (circular, fixed) hoặc Linked List (dynamic)
- Ứng dụng: Scheduling, BFS, Buffering, Print queue

*Lựa chọn Implementation:*
- Array: Khi biết trước kích thước tối đa, cần truy xuất nhanh
- Linked List: Khi kích thước thay đổi động, không biết trước giới hạn

#pagebreak()
