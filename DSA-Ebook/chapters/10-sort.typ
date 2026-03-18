#import "../components/template.typ": *

= Thuật toán Sắp xếp (Sorting Algorithms)

== Tổng quan chương

=== Nội dung chính

Sorting là một trong những bài toán cơ bản và quan trọng nhất trong khoa học máy tính. Chương này sẽ phân tích các thuật toán sorting từ đơn giản đến phức tạp:

1. *Sorting Concepts:*
   - Sort Stability
   - Sort Efficiency
   - Comparison-based vs Non-comparison

2. *Simple Sorts O(n²):*
   - Bubble Sort
   - Selection Sort
   - Insertion Sort

3. *Advanced Sorts O(n log n):*
   - Shell Sort
   - Merge Sort
   - Quick Sort
   - Heap Sort

4. *So sánh các thuật toán*

=== Kiến thức nền

- Arrays
- Recursion (cho Merge Sort, Quick Sort)
- Heap (cho Heap Sort)

#pagebreak()

== Giải thích từng khái niệm

=== Sorting (Sắp xếp)

*WHAT - Sorting*

*Sorting* là quá trình sắp xếp lại các phần tử trong danh sách theo một thứ tự nhất định (tăng dần hoặc giảm dần).

Input: `[5, 2, 8, 1, 9]`

Output: `[1, 2, 5, 8, 9]` (tăng dần)

*Các khái niệm quan trọng:*

1. *Sort Stability:*
   
   *Stable Sort*
   
   Các phần tử có *key bằng nhau* giữ nguyên thứ tự tương đối sau khi sort.
   
   Input: `[(5,a), (3,b), (5,c), (1,d)]`
   
   Stable: `[(1,d), (3,b), (5,a), (5,c)]` ← a vẫn trước c
   
   Unstable: `[(1,d), (3,b), (5,c), (5,a)]` ← c trước a (sai!)
   
   *Stable sorts:* Merge, Insertion, Bubble
   
   *Unstable sorts:* Quick, Heap, Selection

2. *In-place Sorting:*
   - Không cần extra array
   - Space complexity: O(1)
   - Ví dụ: Bubble, Selection, Insertion, Quick, Heap

3. *Sort Efficiency:*
   ```
   Efficiency = Số comparisons + Số moves (swaps/shifts)
   ```

*Tại sao cần Sorting?*

1. *Tiền xử lý cho search:*
   - Binary search yêu cầu sorted array → O(log n)

2. *Data organization:*
   - Hiển thị data theo thứ tự (tên, điểm, giá...)

3. *Algorithm requirements:*
   - Nhiều thuật toán cần sorted data (merge, median finding...)

4. *Everywhere in real life:*
   - E-commerce: Sort products by price
   - Social media: Sort posts by time
   - Database: ORDER BY clauses
   - File manager: Sort files by name/date/size

#pagebreak()

=== Bubble Sort (Sắp xếp nổi bọt)

*WHAT*

*Bubble Sort:* So sánh 2 phần tử liền kề, swap nếu sai thứ tự. Phần tử lớn "nổi" lên cuối sau mỗi pass.

*Algorithm:*
```
for i = 0 to n-2:
    for j = 0 to n-2-i:
        if arr[j] > arr[j+1]:
            swap(arr[j], arr[j+1])
```

*Ví dụ:* `[5, 2, 8, 1]`
```
Pass 1: [2, 5, 1, 8]  (8 nổi lên cuối)
Pass 2: [2, 1, 5, 8]  (5 đúng vị trí)
Pass 3: [1, 2, 5, 8]  (2 đúng vị trí)
Done!
```

*Time Complexity:* Best: O(n) - đã sorted, Average: O(n²), Worst: O(n²) - reverse sorted

*Space Complexity:* O(1) - In-place

*Stable:* ✓ Yes

=== Selection Sort

*Selection Sort:* Mỗi lần tìm phần tử nhỏ nhất trong phần chưa sort, swap với vị trí đầu.

```
for i = 0 to n-2:
    minIndex = i
    for j = i+1 to n-1:
        if arr[j] < arr[minIndex]:
            minIndex = j
    swap(arr[i], arr[minIndex])
```

*Time Complexity:* O(n²) always - Best/Avg/Worst đều như nhau

*Space Complexity:* O(1)

*Stable:* ✗ No

=== Insertion Sort

*Insertion Sort:* Chia array thành sorted và unsorted. Insert từng phần tử từ unsorted vào đúng vị trí trong sorted.

```
for i = 1 to n-1:
    key = arr[i]
    j = i - 1
    while j >= 0 and arr[j] > key:
        arr[j+1] = arr[j]
        j--
    arr[j+1] = key
```

*Complexity:*
- Time: Best: O(n) - nearly sorted, Average: O(n²), Worst: O(n²) - reverse sorted
- Space: O(1)

*Stable:* ✓ Yes

*Khi nào dùng:* Small arrays (n < 50), nearly sorted data

=== Merge Sort

*Merge Sort:* Divide & Conquer
- Chia array thành 2 nửa
- Sort đệ quy từng nửa
- Merge 2 nửa đã sorted

```
Algorithm mergeSort(arr, left, right):
    if left < right:
        mid = (left + right) / 2
        mergeSort(arr, left, mid)
        mergeSort(arr, mid+1, right)
        merge(arr, left, mid, right)
```

*Time Complexity:* O(n log n) - Tất cả trường hợp!

*Space Complexity:* O(n) - Cần extra array cho merge

*Stable:* ✓ Yes

*Recurrence:* T(n) = 2T(n/2) + O(n) = O(n log n)

=== Quick Sort

*Quick Sort:* Divide & Conquer
- Chọn pivot
- Partition: Đưa nhỏ hơn pivot về trái, lớn hơn về phải
- Đệ quy sort 2 phần

```
Algorithm quickSort(arr, low, high):
    if low < high:
        pivotIndex = partition(arr, low, high)
        quickSort(arr, low, pivotIndex - 1)
        quickSort(arr, pivotIndex + 1, high)
```

*Time Complexity:* Best: O(n log n) - pivot chia đều, Average: O(n log n), Worst: O(n²) - pivot luôn min/max

*Space Complexity:* O(log n) - Stack cho recursion

*Stable:* ✗ No (có thể làm stable nhưng phức tạp)

*Trong thực tế:* Nhanh nhất! (cache-friendly, in-place)

=== Heap Sort

Đã học ở Chapter 8!

*Time Complexity:* O(n log n) - Guaranteed!

*Space Complexity:* O(1) - In-place

*Stable:* ✗ No

#pagebreak()

== Bản chất trong máy tính

=== Tại sao Quick Sort nhanh trong thực tế?

Dù cùng O(n log n), Quick Sort thường nhanh hơn Merge Sort:

1. *In-place:* Không cần extra array → Ít memory access
2. *Cache-friendly:* Sequential access trong partition
3. *Small constant factor:* Ít overhead

*Benchmark (n = 1,000,000):*
- Quick Sort: ~0.5 giây
- Merge Sort: ~0.8 giây
- Heap Sort: ~1.2 giây

Tuy nhiên, worst-case O(n²) của Quick Sort đôi khi là vấn đề!

=== Memory Access Patterns

*Merge Sort:*
```
Merge step: Read from 2 arrays → Write to 1 array
→ Many memory writes (chậm)
```

*Quick Sort:*
```
Partition: Swap in-place
→ Fewer memory operations (nhanh)
```

#pagebreak()

== Lịch sử / Nguồn gốc

*1945: Merge Sort*
- John von Neumann
- First O(n log n) algorithm

*1959: Quick Sort*
- Tony Hoare
- Revolutionary! Still most-used today

*1959: Shell Sort*
- Donald Shell
- Improvement over Insertion Sort

*1964: Heap Sort*
- J.W.J. Williams

*Ngày nay:*
- C++ `std::sort`: Introsort (Quick + Heap + Insertion)
- Java `Arrays.sort`: Dual-Pivot Quick Sort
- Python `sorted()`: Timsort (Merge + Insertion)

#pagebreak()

== Phân tích thuật toán

=== Bảng tổng hợp

#table(
  columns: (1.2fr, 1fr, 1fr, 0.8fr, 0.8fr, 1fr),
  align: (left, center, center, center, center, left),
  [*Algorithm*], [*Best*], [*Average*], [*Worst*], [*Space*], [*Stable*],
  [Bubble], [O(n)], [O(n²)], [O(n²)], [O(1)], [✓],
  [Selection], [O(n²)], [O(n²)], [O(n²)], [O(1)], [✗],
  [Insertion], [O(n)], [O(n²)], [O(n²)], [O(1)], [✓],
  [Shell], [O(n log n)], [O(n^1.25)], [O(n²)], [O(1)], [✗],
  [Merge], [O(n log n)], [O(n log n)], [O(n log n)], [O(n)], [✓],
  [Quick], [O(n log n)], [O(n log n)], [O(n²)], [O(log n)], [✗],
  [Heap], [O(n log n)], [O(n log n)], [O(n log n)], [O(1)], [✗],
)

#pagebreak()

== Minh họa từng bước

=== Quick Sort với Partition

Array: `[5, 2, 8, 1, 9]`, pivot = 5

```
Initial: [5, 2, 8, 1, 9]
         ↑ pivot

Partition:
  i = 0, j = 4
  [5, 2, 8, 1, 9]
   ↑           ↑
  
  2 < 5 → i++
  [5, 2, 8, 1, 9]
      ↑        ↑
  
  8 > 5, 9 > 5, 1 < 5
  Swap 8 and 1
  [5, 2, 1, 8, 9]
         ↑  ↑
  
  Final partition:
  [1, 2] 5 [8, 9]
   left    right

Recursively sort:
  Left: [1, 2] → [1, 2]
  Right: [8, 9] → [8, 9]

Result: [1, 2, 5, 8, 9]
```

#pagebreak()

== Code minh họa C++

=== Bubble Sort

```cpp
void bubbleSort(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        bool swapped = false;
        
        for (int j = 0; j < n - 1 - i; j++) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
                swapped = true;
            }
        }
        
        // Optimization: Stop if no swap (already sorted)
        if (!swapped) break;
    }
}
```

=== Selection Sort

```cpp
void selectionSort(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        int minIndex = i;
        
        // Find minimum in unsorted part
        for (int j = i + 1; j < n; j++) {
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }
        
        // Swap with first unsorted element
        swap(arr[i], arr[minIndex]);
    }
}
```

=== Insertion Sort

```cpp
void insertionSort(int arr[], int n) {
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;
        
        // Shift elements > key to right
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j--;
        }
        
        // Insert key
        arr[j + 1] = key;
    }
}
```

=== Merge Sort

```cpp
void merge(int arr[], int left, int mid, int right) {
    int n1 = mid - left + 1;
    int n2 = right - mid;
    
    // Create temp arrays
    int* L = new int[n1];
    int* R = new int[n2];
    
    // Copy data
    for (int i = 0; i < n1; i++)
        L[i] = arr[left + i];
    for (int j = 0; j < n2; j++)
        R[j] = arr[mid + 1 + j];
    
    // Merge back
    int i = 0, j = 0, k = left;
    
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k++] = L[i++];
        } else {
            arr[k++] = R[j++];
        }
    }
    
    // Copy remaining
    while (i < n1) arr[k++] = L[i++];
    while (j < n2) arr[k++] = R[j++];
    
    delete[] L;
    delete[] R;
}

void mergeSort(int arr[], int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        
        mergeSort(arr, left, mid);
        mergeSort(arr, mid + 1, right);
        merge(arr, left, mid, right);
    }
}
```

=== Quick Sort

```cpp
int partition(int arr[], int low, int high) {
    int pivot = arr[high];  // Choose last as pivot
    int i = low - 1;
    
    for (int j = low; j < high; j++) {
        if (arr[j] < pivot) {
            i++;
            swap(arr[i], arr[j]);
        }
    }
    
    swap(arr[i + 1], arr[high]);
    return i + 1;
}

void quickSort(int arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);
        
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}
```

=== Demo tất cả algorithms

```cpp
#include <iostream>
#include <chrono>
using namespace std;
using namespace chrono;

void testSort(void (*sortFunc)(int[], int), string name, int arr[], int n) {
    int* copy = new int[n];
    for (int i = 0; i < n; i++) copy[i] = arr[i];
    
    auto start = high_resolution_clock::now();
    sortFunc(copy, n);
    auto end = high_resolution_clock::now();
    
    auto duration = duration_cast<microseconds>(end - start);
    cout << name << ": " << duration.count() << " μs" << endl;
    
    delete[] copy;
}

int main() {
    int n = 10000;
    int* arr = new int[n];
    
    // Random array
    srand(time(0));
    for (int i = 0; i < n; i++) {
        arr[i] = rand() % 10000;
    }
    
    cout << "Sorting " << n << " elements:\n" << endl;
    
    testSort(bubbleSort, "Bubble Sort", arr, n);
    testSort(selectionSort, "Selection Sort", arr, n);
    testSort(insertionSort, "Insertion Sort", arr, n);
    testSort(mergeSort, "Merge Sort", arr, n);
    testSort(quickSort, "Quick Sort", arr, n);
    testSort(heapSort, "Heap Sort", arr, n);
    
    delete[] arr;
    return 0;
}
```

*Output (ước tính):*
```
Sorting 10000 elements:

Bubble Sort: 250000 μs (~250 ms)
Selection Sort: 150000 μs (~150 ms)
Insertion Sort: 100000 μs (~100 ms)
Merge Sort: 2000 μs (~2 ms)
Quick Sort: 1500 μs (~1.5 ms)
Heap Sort: 3000 μs (~3 ms)
```

#pagebreak()

== Lỗi phổ biến

*1. Bubble Sort - Quên optimization*

```cpp
// ❌ Chậm: Luôn chạy n² comparisons
for (int i = 0; i < n-1; i++) {
    for (int j = 0; j < n-1-i; j++) {
        if (arr[j] > arr[j+1]) swap(arr[j], arr[j+1]);
    }
}

// ✅ TỐT HƠN: Dừng sớm nếu đã sorted
for (int i = 0; i < n-1; i++) {
    bool swapped = false;
    for (int j = 0; j < n-1-i; j++) {
        if (arr[j] > arr[j+1]) {
            swap(arr[j], arr[j+1]);
            swapped = true;
        }
    }
    if (!swapped) break;  // Đã sorted!
}
```

*2. Merge Sort - Tràn stack với n lớn*

```cpp
// ❌ VẤN ĐỀ: Đệ quy sâu với n rất lớn
void mergeSort(int arr[], int left, int right) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        mergeSort(arr, left, mid);        // Đệ quy
        mergeSort(arr, mid + 1, right);   // Đệ quy
        merge(arr, left, mid, right);
    }
}

// ✅ GIẢI PHÁP: Dùng iterative merge sort hoặc tail recursion
```

*3. Quick Sort - Chọn pivot tệ*

```cpp
// ❌ TỆ: Luôn chọn first/last với sorted array
int pivot = arr[high];  // Nếu array đã sorted → O(n²)!

// ✅ TỐT HƠN: Median-of-three
int mid = low + (high - low) / 2;
int pivot = median(arr[low], arr[mid], arr[high]);
```

#pagebreak()

== Khi nào dùng / không dùng

=== Chọn thuật toán theo tình huống

#table(
  columns: (1.5fr, 2fr),
  align: (left, left),
  [*Tình huống*], [*Thuật toán*],
  [n < 50 (small)], [Insertion Sort - Đơn giản, nhanh với small n],
  [Nearly sorted], [Insertion Sort - O(n) best case],
  [Cần stable], [Merge Sort],
  [Cần in-place + O(n log n)], [Heap Sort],
  [General purpose], [Quick Sort - Fastest in practice],
  [Worst-case guarantee], [Merge hoặc Heap - O(n log n) đảm bảo],
  [Linked List], [Merge Sort - Không cần random access],
)

=== Hybrid Approaches (Thực tế)

*Introsort (C++ `std::sort`):*
```
1. Bắt đầu với Quick Sort
2. Nếu recursion depth > 2 log n → Chuyển sang Heap Sort
3. Nếu subarray < 16 → Chuyển sang Insertion Sort

→ Best of all worlds!
```

*Timsort (Python):*
```
Merge Sort + Insertion Sort
→ O(n) best case, O(n log n) worst
→ Stable!
```

#pagebreak()

== Ứng dụng thực tế

*1. E-commerce - Product Listing:*

```cpp
vector<Product> products = getProducts();

// Sort by price
sort(products.begin(), products.end(), 
     [](Product a, Product b) { return a.price < b.price; });

// Sort by rating (stable - giữ price order nếu rating bằng nhau)
stable_sort(products.begin(), products.end(),
            [](Product a, Product b) { return a.rating > b.rating; });
```

- Quick Sort cho general sorting
- Stable sort khi cần maintain order

*2. Database - ORDER BY:*

```sql
SELECT * FROM employees ORDER BY salary DESC;
```

Internal:
- Small result: Insertion Sort
- Large result: External Merge Sort (data > RAM)
- Index available: Index scan (already sorted)

*3. Operating System - Process Scheduling:*

```cpp
// Sort processes by priority
vector<Process> processes;
sort(processes.begin(), processes.end(),
     [](Process a, Process b) { return a.priority > b.priority; });
```

- Quick Sort cho general
- Heap cho priority queue

*4. Search Engines - Ranking Results:*

```cpp
vector<Page> searchResults = search("DSA tutorial");

// Sort by relevance score
sort(searchResults.begin(), searchResults.end(),
     [](Page a, Page b) { return a.relevance > b.relevance; });
```

Google PageRank kết hợp nhiều factors → Quick Sort

#pagebreak()

== Tóm tắt

*Điểm quan trọng:*

1. *Simple Sorts O(n²):*
   - Bubble, Selection, Insertion
   - Dùng cho small arrays (n < 50)

2. *Advanced Sorts O(n log n):*
   - Merge: Stable, O(n) space
   - Quick: Fastest practice, O(n²) worst
   - Heap: O(n log n) guaranteed, in-place

3. *Best practices:*
   - n < 50: Insertion Sort
   - General: Quick Sort (C++ `std::sort`)
   - Need stable: Merge Sort
   - Need guarantee: Heap Sort

4. *Trade-offs:*
   - Time vs Space: Merge O(n) space
   - Stability vs Speed: Stable sorts usually slower
   - Best-case vs Worst-case

5. *Real-world:* Hybrid algorithms (Introsort, Timsort)

6. *Lỗi thường gặp:*
   - Bubble: Không optimize với swapped flag
   - Quick: Bad pivot choice
   - Merge: Extra space overhead

7. *Applications everywhere:*
   - Databases, Search engines, OS, E-commerce

8. *Remember:*
   - No "best" algorithm for all cases
   - Choose based on: n size, stability, space, data characteristics

#pagebreak()
