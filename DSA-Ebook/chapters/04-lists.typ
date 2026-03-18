#import "../components/template.typ": *

= Danh sách liên kết (Linked Lists)

== Tổng quan chương

=== Nội dung chính của chương

Danh sách (List) là một trong những cấu trúc dữ liệu cơ bản và quan trọng nhất. Chương này sẽ giúp bạn hiểu sâu về Lists qua các nội dung:

1. *Linear List Concepts:*
   - Định nghĩa List
   - General List vs Restricted List
   - List ADT (Abstract Data Type)

2. *Array Implementation:*
   - Static Array
   - Dynamic Array
   - Các phép toán cơ bản

3. *Singly Linked List:*
   - Node structure
   - Các phép toán: Insert, Delete, Search
   - Traversal

4. *Other Linked Lists:*
   - Doubly Linked List
   - Circular Linked List

5. *So sánh các cách triển khai:*
   - Array vs Linked List
   - Ưu/nhược điểm
   - Khi nào dùng cái gì

=== Kiến thức nền cần biết trước

- Con trỏ (Pointers) trong C++
- Cấp phát bộ nhớ động (`new`, `delete`)
- Struct/Class trong C++

#pagebreak()

== Giải thích từng khái niệm

=== Linear List (Danh sách tuyến tính)

*WHAT - List là gì?*

*Linear List* (Danh sách tuyến tính) là một chuỗi hữu hạn, có thứ tự các phần tử dữ liệu.

*"Có thứ tự"* nghĩa là:
- Mỗi phần tử có một vị trí (position) trong danh sách
- Có phần tử đầu (head) và phần tử cuối (tail)
- Mỗi phần tử (trừ đầu/cuối) có phần tử đứng trước và đứng sau

*Ví dụ:*
```
List of students: [An, Binh, Cuong, Dung, Em]
                   ↑                          ↑
                 head                       tail
```

*Các loại List:*

1. *General List (Danh sách tổng quát):*
   - Không hạn chế phép toán nào
   - Có thể insert/delete ở bất kỳ vị trí nào
   - *Unsorted List:* Phần tử không sắp xếp theo thứ tự cụ thể
   - *Sorted List:* Phần tử được sắp xếp theo key

2. *Restricted List (Danh sách hạn chế):*
   - Chỉ cho phép một số phép toán
   - Insert/delete chỉ ở đầu hoặc cuối
   - *Stack:* LIFO (Last-In-First-Out)
   - *Queue:* FIFO (First-In-First-Out)

*Tại sao cần List?*

1. *Lưu trữ tập hợp phần tử:*
   - Danh sách sinh viên
   - Lịch sử duyệt web
   - Playlist nhạc

2. *Duy trì thứ tự:*
   - Vị trí phần tử quan trọng
   - Có thể truy xuất theo vị trí

3. *Kích thước động:*
   - Có thể thêm/xóa phần tử
   - Không cần biết trước số lượng

*Ví dụ thực tế:*
- Facebook News Feed: List of posts
- Gmail: List of emails
- Music Player: Playlist
- E-commerce: Shopping cart

#pagebreak()

=== List ADT (Abstract Data Type)

*WHAT - List ADT*

List ADT định nghĩa các phép toán trên List mà không quan tâm đến cách triển khai.

*Basic Concepts:*
- Empty list: Không có phần tử nào
- Length/Size: Số lượng phần tử hiện tại
- Head: Đầu danh sách
- Tail: Cuối danh sách

*Basic Operations:*

1. `Create()` - Tạo list rỗng
2. `Insert(element, position)` - Chèn phần tử
3. `Remove(position)` - Xóa phần tử
4. `Search(element)` - Tìm kiếm
5. `Retrieve(position)` - Lấy phần tử tại vị trí
6. `Traverse()` - Duyệt qua tất cả phần tử

*Extended Operations:*

1. `isEmpty()` - Kiểm tra rỗng
2. `isFull()` - Kiểm tra đầy (với array)
3. `Size()` - Lấy số lượng phần tử
4. `Clear()` - Xóa tất cả
5. `Replace(position, element)` - Thay thế
6. `Merge(list1, list2)` - Gộp 2 list
7. `Append(list1, list2)` - Nối 2 list

*Điều kiện thành công:*
- Insert: List chưa đầy
- Remove/Retrieve: List không rỗng và vị trí hợp lệ

#pagebreak()

=== Array-based List (Danh sách dựa trên mảng)

*WHAT - Array-based List*

List được triển khai bằng mảng (array), các phần tử được lưu liên tiếp trong bộ nhớ.

*Cấu trúc:*
```cpp
class ArrayList {
private:
    int* data;      // Mảng lưu dữ liệu
    int size;       // Số phần tử hiện tại
    int capacity;   // Dung lượng tối đa
};
```

*Dynamic Array:*

Để linh hoạt hơn, ta dùng *Dynamic Array* - mảng có thể tự động mở rộng:

```cpp
class DynamicArray {
private:
    int* storage;
    int size;
    int capacity;
    
public:
    DynamicArray() {
        capacity = 10;  // Khởi tạo với 10 phần tử
        size = 0;
        storage = new int[capacity];
    }
    
    void ensureCapacity(int minCapacity) {
        if (minCapacity > capacity) {
            int newCapacity = (capacity * 3) / 2 + 1;  // Tăng 1.5 lần
            if (newCapacity < minCapacity) {
                newCapacity = minCapacity;
            }
            resize(newCapacity);
        }
    }
    
    void resize(int newCapacity) {
        int* newStorage = new int[newCapacity];
        memcpy(newStorage, storage, sizeof(int) * size);
        delete[] storage;
        storage = newStorage;
        capacity = newCapacity;
    }
};
```

*Tại sao dùng Dynamic Array?*

1. *Flexible size:* Không cần biết trước số lượng phần tử
2. *Fast access:* Truy xuất O(1) theo index
3. *Cache-friendly:* Dữ liệu liên tiếp → CPU cache hiệu quả

*Nhược điểm:*
- Insert/Delete ở giữa → O(n) (phải dịch chuyển phần tử)
- Resize tốn thời gian (copy toàn bộ mảng)

#pagebreak()

=== Singly Linked List (Danh sách liên kết đơn)

*WHAT - Linked List*

*Linked List* là danh sách các node, mỗi node chứa:
1. *Data:* Dữ liệu
2. *Link (next):* Con trỏ tới node tiếp theo

```
[Data|next] → [Data|next] → [Data|next] → NULL
  head
```

*Node Structure:*

```cpp
struct Node {
    int data;
    Node* next;
    
    Node() : next(nullptr) {}
    Node(int d) : data(d), next(nullptr) {}
};
```

*Linked List Structure:*

```cpp
class LinkedList {
private:
    Node* head;
    int count;
    
public:
    LinkedList() : head(nullptr), count(0) {}
    
    ~LinkedList() {
        // Giải phóng tất cả node
        Node* current = head;
        while (current != nullptr) {
            Node* temp = current;
            current = current->next;
            delete temp;
        }
    }
};
```

*Tại sao dùng Linked List?*

1. *Dynamic size:* Dễ dàng thêm/xóa phần tử
2. *Efficient insert/delete:* O(1) nếu biết vị trí (không cần dịch chuyển)
3. *No resize:* Không cần cấp phát lại bộ nhớ như array

*Nhược điểm:*
- Truy xuất chậm: O(n) để tìm phần tử thứ i
- Tốn bộ nhớ: Mỗi node cần lưu con trỏ next
- Cache-unfriendly: Node rải rác trong RAM

*Trong bộ nhớ:*

Array-based List:
```
Memory: [1][2][3][4][5] ← Liên tiếp
Address: 0x100, 0x104, 0x108, 0x10C, 0x110
```

Linked List:
```
Memory:
Node 1: [data: 1, next: 0x500] ← 0x100
Node 2: [data: 2, next: 0x300] ← 0x500
Node 3: [data: 3, next: 0x700] ← 0x300
Node 4: [data: 4, next: NULL]  ← 0x700

Nodes rải rác trong RAM, không liên tiếp!
```

#pagebreak()

== Bản chất trong máy tính

=== Array-based List trong Memory

```
ArrayList (capacity = 10, size = 5):

Stack:
  [data = 0x1000]  ← Con trỏ tới heap
  [size = 5]
  [capacity = 10]

Heap:
  0x1000: [10]  ← data[0]
  0x1004: [20]  ← data[1]
  0x1008: [30]  ← data[2]
  0x100C: [40]  ← data[3]
  0x1010: [50]  ← data[4]
  0x1014: [?]   ← data[5] (unused)
  ...
  0x1024: [?]   ← data[9] (unused)
```

*Truy xuất data[i]:*
```
Address = base_address + i * sizeof(int)
Address of data[3] = 0x1000 + 3 * 4 = 0x100C
→ O(1) - Rất nhanh!
```

=== Linked List trong Memory

```
LinkedList:

Stack:
  [head = 0x2000]
  [count = 4]

Heap (rải rác):
  0x2000: [data: 10, next: 0x3500]  ← Node 1 (head)
  0x3500: [data: 20, next: 0x2800]  ← Node 2
  0x2800: [data: 30, next: 0x4100]  ← Node 3
  0x4100: [data: 40, next: NULL]    ← Node 4
```

*Truy xuất phần tử thứ 3:*
```
current = head;           // 0x2000
current = current->next;  // 0x3500
current = current->next;  // 0x2800
return current->data;     // 30
→ O(n) - Phải duyệt qua từng node!
```

*Tại sao Linked List chậm hơn?*
1. Phải duyệt tuần tự (không random access)
2. Cache miss: Node rải rác → CPU phải đọc từ RAM nhiều lần

#pagebreak()

== Lịch sử / Nguồn gốc

=== Lịch sử của List

*1955: Linked List*
- Được phát minh bởi Allen Newell, Cliff Shaw, và Herbert A. Simon
- Dùng trong ngôn ngữ IPL (Information Processing Language)
- Mục đích: Lưu trữ biểu tượng trong AI research

*1958: LISP (List Processing)*
- John McCarthy tạo ngôn ngữ LISP
- Linked List là cấu trúc dữ liệu chính
- `car` (head) và `cdr` (tail) - Thuật ngữ vẫn dùng đến giờ

*1960s-1970s:*
- Doubly Linked List
- Circular Linked List
- Skip List (1989)

*Ngày nay:*
- `std::list` (C++ STL) - Doubly Linked List
- `std::vector` (C++ STL) - Dynamic Array
- `ArrayList` (Java)
- `LinkedList` (Java)

#pagebreak()

== Phân tích thuật toán

=== Array-based List Operations

*Insert at position i:*

```
Algorithm insertAt(arr, i, value, size, capacity)
Pre: 0 <= i <= size, size < capacity
Post: value inserted at position i

1. Ensure capacity (resize if needed)
2. Shift elements from i to size-1 right by 1
3. arr[i] = value
4. size++
End insertAt
```

*Phân tích:*
- Best case: Insert ở cuối → O(1)
- Worst case: Insert ở đầu → O(n) (shift n phần tử)
- Average: O(n/2) = O(n)

*Remove at position i:*
```
Algorithm removeAt(arr, i, size)
Pre: 0 <= i < size
Post: element at position i removed

1. Shift elements from i+1 to size-1 left by 1
2. size--
End removeAt
```

*Phân tích:*
- Best case: Remove cuối → O(1)
- Worst case: Remove đầu → O(n)
- Average: O(n)

*Bảng tổng hợp:*

*Complexity:*
- Time: Insert/Remove: Best O(1), Worst O(n), Avg O(n); Access: O(1); Search: O(n) unsorted, O(log n) sorted
- Space: O(n)

=== Singly Linked List Operations

*Insert at head:*

```
Algorithm insertHead(list, value)
Pre: list is initialized
Post: new node inserted at head

1. newNode = create new node with value
2. newNode->next = list.head
3. list.head = newNode
4. list.count++
End insertHead
```

*Complexity:*
- Time: O(1) - Chỉ thay đổi con trỏ
- Space: O(1)

*Insert after a node:*

```
Algorithm insertAfter(pPre, value)
Pre: pPre points to a node in list
Post: new node inserted after pPre

1. newNode = create new node with value
2. newNode->next = pPre->next
3. pPre->next = newNode
4. list.count++
End insertAfter
```

*Complexity:*
- Time: O(1) - Nếu biết pPre
- Space: O(1)

*Delete at head:*

```
Algorithm deleteHead(list)
Pre: list is not empty
Post: first node deleted

1. temp = list.head
2. list.head = list.head->next
3. delete temp
4. list.count--
End deleteHead
```

*Complexity:*
- Time: O(1)
- Space: O(1)

*Search:*

```
Algorithm search(list, value)
Pre: list is initialized
Post: return node with value or NULL

1. current = list.head
2. while current != NULL
3.     if current->data == value
4.         return current
5.     current = current->next
6. return NULL
End search
```

*Complexity:*
- Time: Best: O(1), Worst: O(n), Avg: O(n)
- Space: O(1)

#pagebreak()

== Minh họa từng bước

=== Array List - Insert at position 2

```
Initial: [10, 20, 30, 40, 50]  size = 5
Insert 99 at position 2

Step 1: Shift elements from position 2 to 4
  [10, 20, 30, 40, 50, ?]
              ↓   ↓   ↓
  [10, 20, ?, 30, 40, 50]

Step 2: Insert 99 at position 2
  [10, 20, 99, 30, 40, 50]

Step 3: size++
  size = 6

Result: [10, 20, 99, 30, 40, 50]
```

=== Linked List - Insert at head

```
Initial:
  head → [20|●] → [30|●] → [40|NULL]

Insert 10 at head:

Step 1: Create new node
  newNode → [10|NULL]

Step 2: newNode->next = head
  newNode → [10|●]
              ↓
  head → [20|●] → [30|●] → [40|NULL]

Step 3: head = newNode
  head → [10|●] → [20|●] → [30|●] → [40|NULL]

Result:
  head → [10|●] → [20|●] → [30|●] → [40|NULL]
```

=== Linked List - Delete first node

```
Initial:
  head → [10|●] → [20|●] → [30|NULL]

Step 1: temp = head
  temp ────┐
  head → [10|●] → [20|●] → [30|NULL]

Step 2: head = head->next
  temp → [10|●] ╳
  head ────────→ [20|●] → [30|NULL]

Step 3: delete temp
  head → [20|●] → [30|NULL]

Result:
  head → [20|●] → [30|NULL]
```

#pagebreak()

== Code minh họa bằng C++

=== Dynamic Array List - Complete Implementation

```cpp
#include <iostream>
#include <cstring>
using namespace std;

class DynamicArray {
private:
    int* storage;
    int size;
    int capacity;
    
    void setCapacity(int newCapacity) {
        int* newStorage = new int[newCapacity];
        memcpy(newStorage, storage, sizeof(int) * size);
        delete[] storage;
        storage = newStorage;
        capacity = newCapacity;
    }
    
    void ensureCapacity(int minCapacity) {
        if (minCapacity > capacity) {
            int newCapacity = (capacity * 3) / 2 + 1;
            if (newCapacity < minCapacity) {
                newCapacity = minCapacity;
            }
            setCapacity(newCapacity);
        }
    }
    
    void pack() {
        if (size <= capacity / 2) {
            int newCapacity = (size * 3) / 2 + 1;
            setCapacity(newCapacity);
        }
    }
    
    void rangeCheck(int index) {
        if (index < 0 || index >= size) {
            throw "Index out of bounds!";
        }
    }
    
public:
    DynamicArray(int cap = 10) {
        capacity = cap;
        size = 0;
        storage = new int[capacity];
    }
    
    ~DynamicArray() {
        delete[] storage;
    }
    
    int getSize() { return size; }
    bool isEmpty() { return size == 0; }
    
    int get(int index) {
        rangeCheck(index);
        return storage[index];
    }
    
    void set(int index, int value) {
        rangeCheck(index);
        storage[index] = value;
    }
    
    void insertAt(int index, int value) {
        if (index < 0 || index > size) {
            throw "Index out of bounds!";
        }
        ensureCapacity(size + 1);
        
        // Shift elements right
        int moveCount = size - index;
        if (moveCount > 0) {
            memmove(storage + index + 1,
                    storage + index,
                    sizeof(int) * moveCount);
        }
        
        storage[index] = value;
        size++;
    }
    
    void add(int value) {
        insertAt(size, value);  // Insert at end
    }
    
    void removeAt(int index) {
        rangeCheck(index);
        
        // Shift elements left
        int moveCount = size - index - 1;
        if (moveCount > 0) {
            memmove(storage + index,
                    storage + index + 1,
                    sizeof(int) * moveCount);
        }
        
        size--;
        pack();
    }
    
    int search(int value) {
        for (int i = 0; i < size; i++) {
            if (storage[i] == value) {
                return i;
            }
        }
        return -1;  // Not found
    }
    
    void print() {
        cout << "[";
        for (int i = 0; i < size; i++) {
            cout << storage[i];
            if (i < size - 1) cout << ", ";
        }
        cout << "]" << endl;
    }
};

int main() {
    DynamicArray arr;
    
    arr.add(10);
    arr.add(20);
    arr.add(30);
    arr.print();  // [10, 20, 30]
    
    arr.insertAt(1, 99);
    arr.print();  // [10, 99, 20, 30]
    
    arr.removeAt(2);
    arr.print();  // [10, 99, 30]
    
    cout << "Index of 99: " << arr.search(99) << endl;  // 1
    
    return 0;
}
```

#pagebreak()

=== Singly Linked List - Complete Implementation

```cpp
#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* next;
    
    Node() : next(nullptr) {}
    Node(int d) : data(d), next(nullptr) {}
};

class LinkedList {
private:
    Node* head;
    int count;
    
public:
    LinkedList() : head(nullptr), count(0) {}
    
    ~LinkedList() {
        clear();
    }
    
    int getSize() { return count; }
    bool isEmpty() { return head == nullptr; }
    
    // Insert at head - O(1)
    void insertHead(int value) {
        Node* newNode = new Node(value);
        newNode->next = head;
        head = newNode;
        count++;
    }
    
    // Insert at tail - O(n)
    void insertTail(int value) {
        Node* newNode = new Node(value);
        
        if (head == nullptr) {
            head = newNode;
        } else {
            Node* current = head;
            while (current->next != nullptr) {
                current = current->next;
            }
            current->next = newNode;
        }
        count++;
    }
    
    // Insert after a specific node
    void insertAfter(Node* pPre, int value) {
        if (pPre == nullptr) {
            cout << "Previous node cannot be NULL!" << endl;
            return;
        }
        
        Node* newNode = new Node(value);
        newNode->next = pPre->next;
        pPre->next = newNode;
        count++;
    }
    
    // Delete at head - O(1)
    void deleteHead() {
        if (head == nullptr) {
            cout << "List is empty!" << endl;
            return;
        }
        
        Node* temp = head;
        head = head->next;
        delete temp;
        count--;
    }
    
    // Delete node with specific value - O(n)
    bool deleteNode(int value) {
        if (head == nullptr) return false;
        
        // Special case: head node
        if (head->data == value) {
            deleteHead();
            return true;
        }
        
        // Find predecessor of node to delete
        Node* current = head;
        while (current->next != nullptr && current->next->data != value) {
            current = current->next;
        }
        
        if (current->next == nullptr) {
            return false;  // Not found
        }
        
        // Delete node
        Node* temp = current->next;
        current->next = temp->next;
        delete temp;
        count--;
        return true;
    }
    
    // Search - O(n)
    Node* search(int value) {
        Node* current = head;
        while (current != nullptr) {
            if (current->data == value) {
                return current;
            }
            current = current->next;
        }
        return nullptr;
    }
    
    // Get node at position - O(n)
    Node* getAt(int position) {
        if (position < 0 || position >= count) {
            return nullptr;
        }
        
        Node* current = head;
        for (int i = 0; i < position; i++) {
            current = current->next;
        }
        return current;
    }
    
    // Clear all nodes
    void clear() {
        Node* current = head;
        while (current != nullptr) {
            Node* temp = current;
            current = current->next;
            delete temp;
        }
        head = nullptr;
        count = 0;
    }
    
    // Print list
    void print() {
        Node* current = head;
        cout << "[";
        while (current != nullptr) {
            cout << current->data;
            if (current->next != nullptr) cout << " -> ";
            current = current->next;
        }
        cout << "]" << endl;
    }
    
    // Print reverse (using recursion)
    void printReverseHelper(Node* node) {
        if (node == nullptr) return;
        printReverseHelper(node->next);
        cout << node->data;
        if (node != head) cout << " <- ";
    }
    
    void printReverse() {
        cout << "[";
        printReverseHelper(head);
        cout << "]" << endl;
    }
};

int main() {
    LinkedList list;
    
    list.insertHead(30);
    list.insertHead(20);
    list.insertHead(10);
    list.print();  // [10 -> 20 -> 30]
    
    list.insertTail(40);
    list.print();  // [10 -> 20 -> 30 -> 40]
    
    Node* node20 = list.search(20);
    if (node20 != nullptr) {
        list.insertAfter(node20, 25);
    }
    list.print();  // [10 -> 20 -> 25 -> 30 -> 40]
    
    list.deleteNode(25);
    list.print();  // [10 -> 20 -> 30 -> 40]
    
    list.printReverse();  // [40 <- 30 <- 20 <- 10]
    
    return 0;
}
```

#pagebreak()

== Những lỗi phổ biến khi code

*1. Array: Index out of bounds*

```cpp
// ❌ SAI: Không kiểm tra index
void insertAt(int index, int value) {
    storage[index] = value;  // Nguy hiểm!
}

// ✅ ĐÚNG: Kiểm tra
void insertAt(int index, int value) {
    if (index < 0 || index > size) {
        throw "Index out of bounds!";
    }
    // ...
}
```

*2. Array: Quên resize khi đầy*

```cpp
// ❌ SAI: Không kiểm tra capacity
void add(int value) {
    storage[size++] = value;  // Overflow khi size >= capacity!
}

// ✅ ĐÚNG
void add(int value) {
    ensureCapacity(size + 1);
    storage[size++] = value;
}
```

*3. Linked List: Memory leak*

```cpp
// ❌ SAI: Không giải phóng node
void deleteNode(int value) {
    if (head->data == value) {
        head = head->next;  // Mất node cũ!
    }
}

// ✅ ĐÚNG
void deleteNode(int value) {
    if (head->data == value) {
        Node* temp = head;
        head = head->next;
        delete temp;  // Giải phóng bộ nhớ
    }
}
```

*4. Linked List: Dangling pointer*

```cpp
// ❌ SAI: Thay đổi next trước khi lưu
void insertAfter(Node* pPre, int value) {
    Node* newNode = new Node(value);
    pPre->next = newNode;          // Mất link tới node tiếp theo!
    newNode->next = pPre->next;    // newNode->next trỏ tới chính nó!
}

// ✅ ĐÚNG: Lưu next trước
void insertAfter(Node* pPre, int value) {
    Node* newNode = new Node(value);
    newNode->next = pPre->next;    // Lưu next trước
    pPre->next = newNode;
}
```

*5. Linked List: NULL pointer dereference*

```cpp
// ❌ SAI: Không kiểm tra NULL
void deleteAt(int index) {
    Node* current = head;
    for (int i = 0; i < index - 1; i++) {
        current = current->next;  // Có thể NULL!
    }
    current->next = current->next->next;  // Crash nếu current NULL!
}

// ✅ ĐÚNG
void deleteAt(int index) {
    if (index < 0 || index >= count) return;
    // ... kiểm tra NULL ở mọi bước
}
```

#pagebreak()

== Khi nào nên dùng / không nên dùng

=== ArrayList vs LinkedList

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  align: (left, left, left),
  [*Tiêu chí*], [*ArrayList*], [*LinkedList*],
  [*Access*], [O(1) - Random access], [O(n) - Sequential only],
  [*Insert/Delete đầu*], [O(n) - Shift elements], [O(1) - Change pointer],
  [*Insert/Delete cuối*], [O(1) amortized], [O(n) - Must traverse],
  [*Insert/Delete giữa*], [O(n) - Shift], [O(1) if know position],
  [*Search*], [O(n) unsorted, O(log n) sorted], [O(n) always],
  [*Memory*], [Liên tiếp, cache-friendly], [Rải rác, cache-unfriendly],
  [*Space overhead*], [Capacity > size], [Extra pointer per node],
  [*Resize*], [Cần khi đầy (O(n))], [Không cần],
)

=== Khi nào dùng ArrayList?

*Dùng ArrayList khi:*

1. *Cần random access (truy xuất theo index):*
   - `arr[5]` → O(1)

2. *Ít insert/delete, nhiều read:*
   - Đọc dữ liệu cấu hình
   - Display list (không thay đổi)

3. *Thao tác chủ yếu ở cuối:*
   - Add/remove at end → O(1)

4. *Cần sort hiệu quả:*
   - Quick Sort, Merge Sort hoạt động tốt trên array

*Ví dụ:*
- Lưu điểm sinh viên (100 sinh viên cố định)
- Reading list of products (display only)
- Image pixels trong game

=== Khi nào dùng LinkedList?

*Dùng LinkedList khi:*

1. *Nhiều insert/delete ở đầu:*
   - Browser history (thêm URL mới)
   - Undo/Redo stack

2. *Không biết trước kích thước:*
   - Chat messages (vô hạn)
   - Streaming data

3. *Không cần random access:*
   - Chỉ duyệt tuần tự from head to tail

4. *Cần insert/delete giữa list thường xuyên:*
   - Music playlist (insert, remove songs)
   - Task queue

*Ví dụ:*
- Browser history
- Music player playlist
- LRU Cache implementation

#pagebreak()

== Ứng dụng thực tế

*1. Operating System:*

*Process Queue:*
```cpp
// Ready queue cho CPU scheduler
LinkedList<Process> readyQueue;

void addProcess(Process p) {
    readyQueue.insertTail(p);  // FIFO
}

Process getNextProcess() {
    Process p = readyQueue.head->data;
    readyQueue.deleteHead();
    return p;
}
```

*LRU Cache:*
- Doubly Linked List + Hash Map
- Least Recently Used page replacement

*2. Web Browser:*

*History (Back/Forward buttons):*
```cpp
// Browser history using Doubly Linked List
DoublyLinkedList<URL> history;
Node* current;  // Current page

void visitPage(URL url) {
    // Delete all forward history
    while (current->next != nullptr) {
        deleteAfter(current);
    }
    insertAfter(current, url);
    current = current->next;
}

void goBack() {
    if (current->prev != nullptr) {
        current = current->prev;
    }
}

void goForward() {
    if (current->next != nullptr) {
        current = current->next;
    }
}
```

*3. Music Player:*

*Playlist:*
```cpp
// Doubly Linked List để navigate forward/backward
class Playlist {
    DoublyLinkedList<Song> songs;
    Node* currentSong;
    
    void next() {
        if (currentSong->next != nullptr) {
            currentSong = currentSong->next;
            playSong(currentSong->data);
        }
    }
    
    void previous() {
        if (currentSong->prev != nullptr) {
            currentSong = currentSong->prev;
            playSong(currentSong->data);
        }
    }
    
    void shuffle() {
        // Convert to ArrayList, shuffle, convert back
    }
};
```

*4. Text Editor:*

*Undo/Redo:*
```cpp
// Stack (using LinkedList)
LinkedList<Action> undoStack;
LinkedList<Action> redoStack;

void execute(Action action) {
    performAction(action);
    undoStack.insertHead(action);
    redoStack.clear();  // Clear redo history
}

void undo() {
    if (!undoStack.isEmpty()) {
        Action action = undoStack.head->data;
        undoStack.deleteHead();
        reverseAction(action);
        redoStack.insertHead(action);
    }
}

void redo() {
    if (!redoStack.isEmpty()) {
        Action action = redoStack.head->data;
        redoStack.deleteHead();
        performAction(action);
        undoStack.insertHead(action);
    }
}
```

*5. E-commerce:*

*Shopping Cart:*
```cpp
// ArrayList cho shopping cart (ít thay đổi sau khi add)
ArrayList<Product> cart;

void addToCart(Product p) {
    cart.add(p);  // O(1) - add at end
}

void updateQuantity(int index, int quantity) {
    cart.get(index).quantity = quantity;  // O(1) - random access
}

double calculateTotal() {
    double total = 0;
    for (int i = 0; i < cart.size(); i++) {
        total += cart.get(i).price * cart.get(i).quantity;
    }
    return total;
}
```

#pagebreak()

== Tóm tắt chương

*Những điểm quan trọng nhất cần nhớ:*

1. *List ADT* có 2 cách triển khai chính:
   - *Array-based:* Fast access O(1), slow insert/delete O(n)
   - *Linked List:* Slow access O(n), fast insert/delete O(1) at known position

2. *Array-based List:*
   - Truy xuất: O(1)
   - Insert/Delete: O(n) (shift elements)
   - Memory: Liên tiếp, cache-friendly
   - Space: O(n), có thể lãng phí (capacity > size)

3. *Singly Linked List:*
   - Truy xuất: O(n)
   - Insert/Delete at head: O(1)
   - Insert/Delete after known node: O(1)
   - Memory: Rải rác, cache-unfriendly
   - Space: O(n) + O(n) pointers

4. *Khi nào dùng gì:*
   - ArrayList: Cần random access, ít insert/delete
   - LinkedList: Nhiều insert/delete, không cần random access

5. *Các biến thể Linked List:*
   - Singly: Chỉ có next → Duyệt một chiều
   - Doubly: Có next + prev → Duyệt 2 chiều, dễ delete
   - Circular: Cuối nối đầu → Vòng lặp vô hạn

6. *Lỗi thường gặp:*
   - Array: Index out of bounds, quên resize
   - Linked List: Memory leak, NULL pointer, dangling pointer

7. *Ứng dụng thực tế:*
   - ArrayList: Shopping cart, Fixed data, Configuration
   - LinkedList: Browser history, Music playlist, Undo/Redo

8. *Trade-offs:*
   - Time vs Space: Linked List tốn bộ nhớ hơn (pointers)
   - Simplicity vs Flexibility: Array đơn giản nhưng Linked List linh hoạt

9. *C++ STL:*
   - `std::vector` → Dynamic Array
   - `std::list` → Doubly Linked List
   - `std::forward_list` → Singly Linked List

10. *Luôn nhớ:*
    - Array: Fast random access, slow modification
    - Linked List: Slow access, fast modification
    - Choose based on your use case!

#pagebreak()
