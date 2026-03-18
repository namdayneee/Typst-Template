#import "../components/template.typ": *

= Heap

== Tổng quan chương

=== Nội dung chính

Heap là cấu trúc dữ liệu dạng tree đặc biệt, được dùng cho Priority Queue và Heap Sort - một trong những thuật toán sắp xếp hiệu quả nhất.

Nội dung:
1. Heap Definition (Max Heap, Min Heap)
2. Heap Structure và Array Representation
3. Basic Heap Algorithms (ReheapUp, ReheapDown)
4. Insert và Delete operations
5. Build Heap
6. Heap Sort
7. Priority Queue

=== Kiến thức nền

- Binary Tree (Chapter 6)
- Complete Binary Tree
- Array manipulation

#pagebreak()

== Giải thích từng khái niệm

=== Heap

*WHAT - Heap là gì?*

*Heap* là một Complete Binary Tree (hoặc gần Complete) với tính chất heap order:

*Max Heap:*
- Mỗi node ≥ tất cả descendants của nó
- Root = phần tử lớn nhất

*Min Heap:*
- Mỗi node ≤ tất cả descendants của nó
- Root = phần tử nhỏ nhất

*Max Heap example:*
```
        90
       /  \
     80    70
    / \    /
  50  40  60

90 ≥ 80, 70
80 ≥ 50, 40
70 ≥ 60
```

*Min Heap example:*
```
        10
       /  \
     20    30
    / \    /
  40  50  60

10 ≤ 20, 30
20 ≤ 40, 50
30 ≤ 60
```

*Lưu ý quan trọng:*
- Heap ≠ BST! Không có quan hệ left < right
- Chỉ đảm bảo parent-child relationship
- BST: Left < Root < Right (global order)
- Heap: Parent ≥/≤ Children (local order)

*Tại sao cần Heap?*

1. *Priority Queue:*
   - Luôn lấy được max/min trong O(1)
   - Insert/Delete max trong O(log n)

2. *Heap Sort:*
   - O(n log n) worst-case
   - In-place sorting (không cần extra array)

3. *Efficient max/min tracking:*
   - Không cần sort toàn bộ data
   - Chỉ cần maintain heap property

*Ví dụ thực tế:*
- CPU Scheduling: Process với priority cao được xử lý trước
- Dijkstra's Algorithm: Luôn lấy node với distance nhỏ nhất
- Event-driven simulation: Xử lý events theo timestamp
- Top K elements: Tìm K số lớn nhất trong stream

#pagebreak()

=== Heap Array Representation

*WHAT - Heap trong Array*

Vì Heap là *Complete Binary Tree*, có thể lưu hiệu quả trong array mà không lãng phí space!

*Công thức quan hệ:*
- Node i:
  - Parent: `(i-1)/2`
  - Left child: `2i+1`
  - Right child: `2i+2`

*Ví dụ:*
```
Tree:
        90
       /  \
     80    70
    / \    /
  50  40  60

Array: [90, 80, 70, 50, 40, 60]
Index:  0   1   2   3   4   5

Quan hệ:
- Node 0 (90): left=1(80), right=2(70)
- Node 1 (80): parent=0(90), left=3(50), right=4(40)
- Node 2 (70): parent=0(90), left=5(60), right=6(không có)
- Node 3 (50): parent=1(80)
```

*Lợi ích:*
- Không cần pointers → Tiết kiệm memory
- Cache-friendly (data liên tiếp)
- Dễ navigate (chỉ cần tính toán index)

#pagebreak()

=== ReheapUp và ReheapDown

*WHAT - Reheap Operations*

*ReheapUp:* Đẩy node lên trên cho đến đúng vị trí (dùng khi insert)

*ReheapDown:* Đẩy node xuống dưới cho đến đúng vị trí (dùng khi delete root)

*ReheapUp Algorithm:*
```
Algorithm reheapUp(heap, position):
    if position > 0:
        parent = (position - 1) / 2
        if heap[position] > heap[parent]:  // Max heap
            swap(heap[position], heap[parent])
            reheapUp(heap, parent)  // Đệ quy lên trên
```

*ReheapDown Algorithm:*
```
Algorithm reheapDown(heap, position, lastPosition):
    leftChild = 2 * position + 1
    rightChild = 2 * position + 2
    
    if leftChild <= lastPosition:
        // Tìm child lớn hơn
        if rightChild <= lastPosition AND heap[rightChild] > heap[leftChild]:
            largeChild = rightChild
        else:
            largeChild = leftChild
        
        if heap[largeChild] > heap[position]:
            swap(heap[largeChild], heap[position])
            reheapDown(heap, largeChild, lastPosition)  // Đệ quy xuống
```

*Cách hoạt động:*

*ReheapUp (Insert 95):*
```
Initial:         After insert:    After reheapUp:
    90               90                95
   /  \             /  \              /  \
 80    70    →    80    70     →    90    70
/ \              / \                / \
50  40          50  40              80  40
                   \              /
                   95*          50

Step 1: Add 95 at end (index 5)
Step 2: Compare with parent 40 → Swap
Step 3: Compare with parent 80 → Swap
Step 4: Compare with parent 90 → Swap
Done!
```

*ReheapDown (Delete root 90):*
```
Initial:         After delete:    After reheapDown:
    90               50                80
   /  \             /  \              /  \
 80    70    →    80    70     →    50    70
/ \              /                 /
50  40          40                 40

Step 1: Move last (50) to root
Step 2: Compare with children (80, 70) → Swap with 80
Step 3: Compare with children (40) → Swap with 40
Done!
```

#pagebreak()

== Bản chất trong máy tính

=== Memory Layout

*Heap trong Array:*
```
Array: [90, 80, 70, 50, 40, 60]

Memory (contiguous):
0x1000: 90  ← heap[0] (root)
0x1004: 80  ← heap[1]
0x1008: 70  ← heap[2]
0x100C: 50  ← heap[3]
0x1010: 40  ← heap[4]
0x1014: 60  ← heap[5]
```

*So với Tree Pointers:*
- Heap: 6 × 4 bytes = 24 bytes
- BST với pointers: 6 × (4 + 8) = 72 bytes (data + 2 pointers)
→ Heap tiết kiệm 3x memory!

=== Cache Performance

Array-based heap rất *cache-friendly*:
- Parent và children gần nhau trong memory
- CPU prefetch hiệu quả
- Thực tế nhanh hơn pointer-based tree

#pagebreak()

== Lịch sử / Nguồn gốc

*1964: Heap Sort*
- J.W.J. Williams phát minh Heap Sort
- First in-place O(n log n) sorting algorithm

*1964: Priority Queue*
- Williams nhận ra Heap hoàn hảo cho Priority Queue

*1970s: Fibonacci Heap*
- Fredman & Tarjan
- Better amortized complexity

*Ngày nay:*
- C++ `std::priority_queue` dùng Heap
- Java `PriorityQueue`
- Python `heapq` module

*Applications mở rộng:*
- Dijkstra's shortest path
- Prim's MST
- Huffman coding
- Median maintenance

#pagebreak()

== Phân tích thuật toán

=== Insert into Heap

```
Algorithm insertHeap(heap, last, data):
    if heap full:
        return false
    
    last = last + 1
    heap[last] = data
    reheapUp(heap, last)
    
    return true
```

*Phân tích reheapUp:*
- Worst case: Node bubble up từ leaf đến root
- Số swap tối đa = height = ⌊log₂ n⌋

*Complexity:*
- Time: O(log n)
- Space: O(1) iterative, O(log n) recursive

=== Delete Max (Root)

```
Algorithm deleteHeap(heap, last, dataOut):
    if heap empty:
        return false
    
    dataOut = heap[0]      // Save root
    heap[0] = heap[last]   // Move last to root
    last = last - 1
    reheapDown(heap, 0, last)
    
    return true
```

*Complexity:*
- Time: O(log n)
- Space: O(1) iterative, O(log n) recursive

=== Build Heap

*Naive approach:*
```
for i = 1 to n-1:
    reheapUp(heap, i)
```
Time: O(n log n)

*Optimized approach:*
```
for i = (n/2 - 1) down to 0:
    reheapDown(heap, i, n-1)
```
Time: *O(n)* - Tốt hơn!

*Giải thích tại sao O(n):*
- Nodes ở level h: ≤ n/2^(h+1)
- Work per node: h
- Total: Σ (n/2^(h+1)) × h ≈ 2n = O(n)

*Complexity:*
- Time: O(n) - Linear!
- Space: O(1)

=== Heap Sort

```
Algorithm heapSort(array, n):
    // 1. Build max heap
    buildHeap(array, n)  // O(n)
    
    // 2. Extract max n-1 times
    for i = n-1 down to 1:
        swap(array[0], array[i])  // Move max to end
        reheapDown(array, 0, i-1) // O(log n)
    
    return array
```

*Complexity:*
- Time: O(n log n) - Guaranteed worst-case!
- Space: O(1) - In-place sorting

*So sánh với Quick Sort:*
- Quick Sort: O(n log n) average, O(n²) worst
- Heap Sort: O(n log n) always, but slower in practice (cache-unfriendly swaps)

#pagebreak()

== Minh họa từng bước

=== Build Heap từ array

Array: `[40, 50, 90, 70, 80, 60]`

```
Initial (not heap):
      40
     /  \
   50    90
  / \    /
70  80  60

Step 1: ReheapDown from index 2 (90)
90 ≥ 60 → OK

Step 2: ReheapDown from index 1 (50)
50 < 80 → Swap
      40
     /  \
   80    90
  / \    /
70  50  60

Step 3: ReheapDown from index 0 (40)
40 < max(80, 90) → Swap with 90
      90
     /  \
   80    40
  / \    /
70  50  60

40 < 60 → Swap
      90
     /  \
   80    60
  / \    /
70  50  40

Result: Valid Max Heap!
Array: [90, 80, 60, 70, 50, 40]
```

=== Heap Sort

```
Initial heap: [90, 80, 60, 70, 50, 40]

Iteration 1: Extract max (90)
  Swap 90 with 40: [40, 80, 60, 70, 50 | 90]
  ReheapDown:      [80, 70, 60, 40, 50 | 90]

Iteration 2: Extract max (80)
  Swap 80 with 50: [50, 70, 60, 40 | 80, 90]
  ReheapDown:      [70, 50, 60, 40 | 80, 90]

Iteration 3: Extract max (70)
  Swap 70 with 40: [40, 50, 60 | 70, 80, 90]
  ReheapDown:      [60, 50, 40 | 70, 80, 90]

Iteration 4: Extract max (60)
  Swap 60 with 40: [40, 50 | 60, 70, 80, 90]
  ReheapDown:      [50, 40 | 60, 70, 80, 90]

Iteration 5: Extract max (50)
  Swap 50 with 40: [40 | 50, 60, 70, 80, 90]

Final sorted: [40, 50, 60, 70, 80, 90]
```

#pagebreak()

== Code minh họa C++

```cpp
#include <iostream>
#include <vector>
using namespace std;

class MaxHeap {
private:
    vector<int> heap;
    
    int parent(int i) { return (i - 1) / 2; }
    int leftChild(int i) { return 2 * i + 1; }
    int rightChild(int i) { return 2 * i + 2; }
    
    void reheapUp(int position) {
        if (position > 0) {
            int parentPos = parent(position);
            if (heap[position] > heap[parentPos]) {
                swap(heap[position], heap[parentPos]);
                reheapUp(parentPos);
            }
        }
    }
    
    void reheapDown(int position, int lastPosition) {
        int leftPos = leftChild(position);
        int rightPos = rightChild(position);
        
        if (leftPos <= lastPosition) {
            int largeChild = leftPos;
            
            if (rightPos <= lastPosition && heap[rightPos] > heap[leftPos]) {
                largeChild = rightPos;
            }
            
            if (heap[largeChild] > heap[position]) {
                swap(heap[largeChild], heap[position]);
                reheapDown(largeChild, lastPosition);
            }
        }
    }
    
public:
    MaxHeap() {}
    
    void insert(int value) {
        heap.push_back(value);
        reheapUp(heap.size() - 1);
    }
    
    bool extractMax(int& maxValue) {
        if (heap.empty()) return false;
        
        maxValue = heap[0];
        heap[0] = heap.back();
        heap.pop_back();
        
        if (!heap.empty()) {
            reheapDown(0, heap.size() - 1);
        }
        
        return true;
    }
    
    int getMax() {
        return heap.empty() ? -1 : heap[0];
    }
    
    bool isEmpty() {
        return heap.empty();
    }
    
    int size() {
        return heap.size();
    }
    
    void print() {
        cout << "[";
        for (int i = 0; i < heap.size(); i++) {
            cout << heap[i];
            if (i < heap.size() - 1) cout << ", ";
        }
        cout << "]" << endl;
    }
    
    // Build heap from array - O(n)
    void buildHeap(vector<int>& arr) {
        heap = arr;
        // Start from last non-leaf node
        for (int i = heap.size() / 2 - 1; i >= 0; i--) {
            reheapDown(i, heap.size() - 1);
        }
    }
};

// Heap Sort
void heapSort(vector<int>& arr) {
    int n = arr.size();
    
    // 1. Build max heap - O(n)
    for (int i = n / 2 - 1; i >= 0; i--) {
        // ReheapDown inline
        int pos = i;
        while (true) {
            int left = 2 * pos + 1;
            int right = 2 * pos + 2;
            int largest = pos;
            
            if (left < n && arr[left] > arr[largest])
                largest = left;
            if (right < n && arr[right] > arr[largest])
                largest = right;
            
            if (largest != pos) {
                swap(arr[pos], arr[largest]);
                pos = largest;
            } else {
                break;
            }
        }
    }
    
    // 2. Extract max n-1 times - O(n log n)
    for (int i = n - 1; i > 0; i--) {
        swap(arr[0], arr[i]);  // Move max to end
        
        // ReheapDown on reduced heap
        int pos = 0;
        while (true) {
            int left = 2 * pos + 1;
            int right = 2 * pos + 2;
            int largest = pos;
            
            if (left < i && arr[left] > arr[largest])
                largest = left;
            if (right < i && arr[right] > arr[largest])
                largest = right;
            
            if (largest != pos) {
                swap(arr[pos], arr[largest]);
                pos = largest;
            } else {
                break;
            }
        }
    }
}

int main() {
    MaxHeap heap;
    
    // Insert elements
    cout << "Inserting 50, 30, 70, 20, 40, 60, 80..." << endl;
    heap.insert(50);
    heap.insert(30);
    heap.insert(70);
    heap.insert(20);
    heap.insert(40);
    heap.insert(60);
    heap.insert(80);
    
    heap.print();  // [80, 40, 70, 20, 30, 60, 50]
    cout << "Max: " << heap.getMax() << endl;  // 80
    
    // Extract max
    int maxVal;
    heap.extractMax(maxVal);
    cout << "Extracted: " << maxVal << endl;  // 80
    heap.print();  // [70, 40, 60, 20, 30, 50]
    
    // Heap Sort demo
    cout << "\n--- Heap Sort ---" << endl;
    vector<int> arr = {40, 50, 90, 70, 80, 60};
    cout << "Before: ";
    for (int x : arr) cout << x << " ";
    cout << endl;
    
    heapSort(arr);
    
    cout << "After: ";
    for (int x : arr) cout << x << " ";
    cout << endl;
    
    return 0;
}
```

*Output:*
```
Inserting 50, 30, 70, 20, 40, 60, 80...
[80, 40, 70, 20, 30, 60, 50]
Max: 80
Extracted: 80
[70, 40, 60, 20, 30, 50]

--- Heap Sort ---
Before: 40 50 90 70 80 60
After: 40 50 60 70 80 90
```

#pagebreak()

== Lỗi phổ biến

*1. Sai công thức parent/child*
```cpp
// ❌ SAI
int parent(int i) { return i / 2; }        // Thiếu -1
int leftChild(int i) { return 2 * i; }     // Thiếu +1

// ✅ ĐÚNG
int parent(int i) { return (i - 1) / 2; }
int leftChild(int i) { return 2 * i + 1; }
int rightChild(int i) { return 2 * i + 2; }
```

*2. Không kiểm tra bounds*
```cpp
// ❌ SAI
void reheapDown(int pos) {
    int left = leftChild(pos);
    int right = rightChild(pos);
    if (heap[left] > heap[pos]) {  // left có thể out of bounds!
        swap(heap[left], heap[pos]);
    }
}

// ✅ ĐÚNG
void reheapDown(int pos, int lastPos) {
    int left = leftChild(pos);
    if (left <= lastPos) {  // Kiểm tra bounds
        // ...
    }
}
```

*3. Heap Sort - Quên giảm heap size*
```cpp
// ❌ SAI
for (int i = n-1; i > 0; i--) {
    swap(arr[0], arr[i]);
    reheapDown(arr, 0, n-1);  // SAI: Vẫn dùng n-1, không phải i-1!
}

// ✅ ĐÚNG
for (int i = n-1; i > 0; i--) {
    swap(arr[0], arr[i]);
    reheapDown(arr, 0, i-1);  // Heap size giảm dần
}
```

#pagebreak()

== Khi nào dùng / không dùng

=== Khi nào dùng Heap?

#table(
  columns: (1.5fr, 2fr),
  align: (left, left),
  [*Tình huống*], [*Lý do*],
  [Priority Queue], [Luôn lấy max/min O(1), insert O(log n)],
  [Top K elements], [Maintain K largest/smallest elements],
  [Median tracking], [2 heaps: max-heap + min-heap],
  [Sorting in-place], [Heap Sort không cần extra space],
  [Graph algorithms], [Dijkstra, Prim với priority queue],
)

=== Heap vs BST vs Array

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  align: (left, center, center, center),
  [*Operation*], [*Heap*], [*BST*], [*Sorted Array*],
  [Find max/min], [O(1)], [O(log n)], [O(1)],
  [Extract max/min], [O(log n)], [O(log n)], [O(n)],
  [Insert], [O(log n)], [O(log n)], [O(n)],
  [Search arbitrary], [O(n)], [O(log n)], [O(log n)],
  [Get sorted], [O(n log n)], [O(n)], [O(1)],
  [Space], [O(n)], [O(n)+pointers], [O(n)],
)

*Kết luận:*
- Heap: Tốt nhất cho *max/min operations*
- BST: Tốt nhất cho *general search*
- Sorted Array: Tốt khi *static data*

#pagebreak()

== Ứng dụng thực tế

*1. CPU Scheduling (OS):*

```cpp
class ProcessScheduler {
    MaxHeap readyQueue;  // Priority = CPU burst time
    
public:
    void addProcess(Process p) {
        readyQueue.insert(p);  // O(log n)
    }
    
    Process getNextProcess() {
        Process p;
        readyQueue.extractMax(p);  // Highest priority
        return p;
    }
};
```

Priority levels:
- Real-time processes: Priority 100
- User processes: Priority 50
- Background: Priority 10

*2. Dijkstra's Shortest Path:*

```cpp
void dijkstra(Graph g, int source) {
    MinHeap pq;  // (distance, node)
    vector<int> dist(n, INF);
    
    dist[source] = 0;
    pq.insert({0, source});
    
    while (!pq.isEmpty()) {
        auto [d, u] = pq.extractMin();  // O(log n)
        
        for (auto [v, weight] : g.adj[u]) {
            if (dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                pq.insert({dist[v], v});
            }
        }
    }
}
```

*3. Event-Driven Simulation:*

```cpp
class EventQueue {
    MinHeap events;  // Sorted by timestamp
    
public:
    void scheduleEvent(Event e) {
        events.insert(e);
    }
    
    Event getNextEvent() {
        Event e;
        events.extractMin(e);  // Earliest event
        return e;
    }
};

// Game engine, Network simulator
```

*4. Top K Elements (Streaming Data):*

```cpp
// Find K largest numbers in a stream
class TopK {
    MinHeap heap;  // Size = K
    int k;
    
public:
    TopK(int k) : k(k) {}
    
    void add(int num) {
        if (heap.size() < k) {
            heap.insert(num);
        } else if (num > heap.getMin()) {
            heap.extractMin();
            heap.insert(num);
        }
    }
    
    vector<int> getTopK() {
        return heap.getAll();
    }
};

// YouTube trending videos, Twitter trending topics
```

*5. Median Maintenance:*

```cpp
class MedianFinder {
    MaxHeap lowerHalf;  // Smaller half
    MinHeap upperHalf;  // Larger half
    
public:
    void addNumber(int num) {
        if (lowerHalf.isEmpty() || num <= lowerHalf.getMax()) {
            lowerHalf.insert(num);
        } else {
            upperHalf.insert(num);
        }
        
        // Balance sizes
        if (lowerHalf.size() > upperHalf.size() + 1) {
            int val;
            lowerHalf.extractMax(val);
            upperHalf.insert(val);
        } else if (upperHalf.size() > lowerHalf.size()) {
            int val;
            upperHalf.extractMin(val);
            lowerHalf.insert(val);
        }
    }
    
    double getMedian() {
        if (lowerHalf.size() == upperHalf.size()) {
            return (lowerHalf.getMax() + upperHalf.getMin()) / 2.0;
        } else {
            return lowerHalf.getMax();
        }
    }
};

// Find median in streaming data - O(log n) per add!
```

#pagebreak()

== Tóm tắt

*Điểm quan trọng:*

1. *Heap:*
   - Complete Binary Tree
   - Max Heap: Parent ≥ Children, Root = max
   - Min Heap: Parent ≤ Children, Root = min

2. *Array Representation:*
   - Node i: left=2i+1, right=2i+2, parent=(i-1)/2
   - Tiết kiệm memory, cache-friendly

3. *Operations:*
   - Insert: Add at end → ReheapUp → O(log n)
   - Extract max: Move last to root → ReheapDown → O(log n)
   - Get max: O(1)
   - Build Heap: O(n) - Not O(n log n)!

4. *Heap Sort:*
   - O(n log n) worst-case guaranteed
   - In-place (không cần extra array)
   - Không stable

5. *Priority Queue:*
   - Best implementation: Heap
   - Insert/Delete: O(log n)
   - Get max/min: O(1)

6. *Ứng dụng:*
   - CPU Scheduling
   - Dijkstra, Prim algorithms
   - Top K problems
   - Median finding
   - Event simulation

7. *Heap vs BST:*
   - Heap: Tốt cho max/min, không tốt cho search
   - BST: Tốt cho search, OK cho max/min
   - Heap: Array-based, BST: Pointer-based

8. *Lỗi thường gặp:*
   - Sai công thức parent/child
   - Không check bounds
   - Heap Sort quên giảm heap size

9. *Build Heap: O(n) not O(n log n)*
   - Nhiều người nghĩ O(n log n)
   - Thực tế: O(n) với bottom-up approach

10. *C++ STL:*
    - `std::priority_queue` - Max heap default
    - `make_heap()`, `push_heap()`, `pop_heap()`

#pagebreak()
