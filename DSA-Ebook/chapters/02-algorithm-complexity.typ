#import "../components/template.typ": *

= Độ phức tạp giải thuật (Algorithm Complexity)

== Tổng quan chương

=== Nội dung chính của chương

Chương này giúp bạn hiểu cách đánh giá hiệu suất của giải thuật - một kỹ năng cốt lõi trong lập trình. Nội dung bao gồm:

1. *Algorithm Efficiency (Hiệu quả giải thuật):*
   - Khái niệm computational complexity
   - Time complexity và Space complexity

2. *Big-O Notation:*
   - Ký hiệu toán học để biểu diễn độ phức tạp
   - Các quy tắc tính Big-O

3. *Các loại vòng lặp và độ phức tạp:*
   - Linear loops: O(n)
   - Logarithmic loops: O(log n)
   - Nested loops: O(n²), O(n log n)

4. *Best, Worst, Average case*

5. *Các complexity classes phổ biến:*
   - Constant, Logarithmic, Linear, Linearithmic, Quadratic, Polynomial, Exponential, Factorial

6. *P và NP Problems*

=== Kiến thức nền cần biết trước

- Toán học cơ bản: logarithm, luỹ thừa
- Vòng lặp trong lập trình (for, while)
- Hiểu cách đọc và phân tích code

#pagebreak()

== Giải thích từng khái niệm

=== Algorithm Efficiency (Hiệu quả giải thuật)

*WHAT - Hiệu quả giải thuật là gì?*

*Computational Complexity* (Độ phức tạp tính toán) là thước đo mức độ khó khăn (về thời gian và/hoặc bộ nhớ) của một giải thuật.

Hai câu hỏi quan trọng:
1. *Time Complexity:* Giải thuật chạy nhanh thế nào?
2. *Space Complexity:* Giải thuật tốn bao nhiêu bộ nhớ?

Dạng tổng quát:
#align(center)[
  #text(size: 14pt)[
    efficiency = f(n)
  ]
]

Trong đó n là *kích thước bài toán* (số lượng phần tử đầu vào).

Tại sao cần đánh giá hiệu quả giải thuật?

1. *So sánh các giải thuật:* Một bài toán có nhiều cách giải, cái nào tốt hơn?

2. *Dự đoán hiệu suất:* Liệu giải thuật có chạy được trên dữ liệu lớn không?

3. *Tối ưu hóa code:* Tìm điểm nghẽn (bottleneck) để cải thiện

*Ví dụ thực tế:*
- Tìm kiếm trong Google: Phải xử lý hàng tỷ trang web → Cần giải thuật hiệu quả
- Sắp xếp 1 triệu sản phẩm trên Shopee → Giải thuật O(n²) sẽ quá chậm
- GPS tìm đường đi ngắn nhất → Phải tính nhanh để người dùng không phải đợi

*Cách đo hiệu quả:*

1. *Đếm số phép toán cơ bản:*
   - So sánh (comparisons)
   - Phép tính (arithmetic operations)
   - Gán (assignments)
   - Truy xuất bộ nhớ (memory access)

2. *Tập trung vào phép toán tốn thời gian nhất:*
   - Data movement to/from memory/storage (chậm nhất)
   - CPU operations (nhanh hơn)

3. *Phân tích theo kích thước đầu vào n:*
   - n càng lớn, thời gian/bộ nhớ tăng như thế nào?

#pagebreak()

=== Big-O Notation

*WHAT - Big-O là gì?*

*Big-O Notation* là ký hiệu toán học để mô tả *tốc độ tăng trưởng* của hàm khi n → ∞.

Big-O chỉ quan tâm đến *xu hướng tăng trưởng*, không quan tâm đến:
- Hằng số nhân (constant factor)
- Các số hạng nhỏ hơn

*Quy tắc rút gọn:*
1. Bỏ hệ số: `5n → n`
2. Giữ số hạng lớn nhất: `n² + n → n²`

*Ví dụ:*

#table(
  columns: (1.5fr, 1.5fr, 1fr),
  align: (left, left, left),
  [*Hàm f(n)*], [*Rút gọn*], [*Big-O*],
  [`f(n) = 5n`], [Bỏ hệ số 5], [`O(n)`],
  [`f(n) = n²/2 + n/2`], [Giữ n², bỏ n/2], [`O(n²)`],
  [`f(n) = 3n² + 100n + 50`], [Giữ n²], [`O(n²)`],
  [`f(n) = log₂n + 100`], [Giữ log n], [`O(log n)`],
)

Tại sao dùng Big-O?

1. *Đơn giản hóa:* Không cần tính toán chính xác số phép toán

2. *Tập trung vào điều quan trọng:* Khi n lớn, chỉ số hạng lớn nhất mới quan trọng

3. *Độc lập với hardware:* Không phụ thuộc vào tốc độ CPU cụ thể

4. *Dễ so sánh:* O(n) < O(n log n) < O(n²)

*Ví dụ minh họa:*
- Khi n = 1,000,000:
  - `n² = 1,000,000,000,000`
  - `100n = 100,000,000`
- Rõ ràng n² lớn hơn 100n rất nhiều, nên 100n không còn quan trọng

*Định nghĩa chính thức (toán học):*

f(n) = O(g(n)) nếu tồn tại hằng số c > 0 và n₀ sao cho:

#align(center)[
  f(n) ≤ c × g(n) với mọi n ≥ n₀
]

*Nói đơn giản:* f(n) không tăng nhanh hơn g(n) (với hệ số c nào đó) khi n đủ lớn.

#pagebreak()

=== Các loại Complexity Classes

Sau đây là các độ phức tạp phổ biến, từ tốt nhất đến tệ nhất:

#table(
  columns: (1.2fr, 1fr, 1.5fr, 1.5fr),
  align: (left, left, left, left),
  [*Tên*], [*Big-O*], [*n=10,000*], [*Thời gian ước tính*],
  [Constant], [`O(1)`], [1], [~10 ns],
  [Logarithmic], [`O(log n)`], [~14], [~140 ns],
  [Linear], [`O(n)`], [10,000], [~0.1 ms],
  [Linearithmic], [`O(n log n)`], [~140,000], [~1.4 ms],
  [Quadratic], [`O(n²)`], [100,000,000], [~15-20 phút],
  [Cubic], [`O(n³)`], [10¹²], [~vài giờ],
  [Exponential], [`O(2ⁿ)`], [2¹⁰⁰⁰⁰], [Không khả thi],
  [Factorial], [`O(n!)`], [10000!], [Không khả thi],
)

*Giả sử:* 
- 1 phép toán = 1 microsecond (10⁻⁶ giây)
- Mỗi vòng lặp có 10 phép toán

#pagebreak()

*Biểu đồ so sánh:*

```
Thời gian
    ^
    |                                            n²
    |                                       .·
    |                                  .··
    |                            .·····
    |                      .·····    n log n
    |               .······
    |         .·····      n
    |   .·····
    | ··············  log n
    |________________> n (kích thước dữ liệu)
```

*Ghi nhớ:* Khi n = 1 triệu:
- O(log n): ~20 bước
- O(n): ~1 triệu bước
- O(n log n): ~20 triệu bước
- O(n²): ~1 nghìn tỷ bước (quá chậm!)

#pagebreak()

=== Phân tích các loại vòng lặp

==== Linear Loops (Vòng lặp tuyến tính)

*Ví dụ 1:*
```cpp
for (int i = 0; i < 1000; i++) {
    // application code
}
```
- Số lần lặp: 1000
- f(n) = n → *O(n)*

*Ví dụ 2:*
```cpp
for (int i = 0; i < 1000; i += 2) {
    // application code
}
```
- Số lần lặp: 500
- f(n) = n/2 → *O(n)* (bỏ hằng số 1/2)

*Nhận xét:* Vòng lặp tăng/giảm theo *cộng* (i++, i+=2, i+=k) → O(n)

==== Logarithmic Loops (Vòng lặp logarit)

*Ví dụ 1: Multiply loop (nhân đôi)*
```cpp
int i = 1;
while (i <= n) {
    // application code
    i = i * 2;  // i nhân đôi mỗi lần
}
```
- Các giá trị i: 1, 2, 4, 8, 16, ..., n
- Số bước: log₂(n)
- *O(log n)*

*Ví dụ 2: Divide loop (chia đôi)*
```cpp
int i = n;
while (i >= 1) {
    // application code
    i = i / 2;  // i giảm một nửa mỗi lần
}
```
- Các giá trị i: n, n/2, n/4, n/8, ..., 1
- Số bước: log₂(n)
- *O(log n)*

*Nhận xét:* Vòng lặp tăng/giảm theo *nhân/chia* (i\*2, i/2) → O(log n)

*Tại sao log n nhanh?*
- n = 1,000,000 → log₂(n) ≈ 20 bước
- Giảm kích thước bài toán rất nhanh!

==== Nested Loops (Vòng lặp lồng nhau)

*Quy tắc:*
#align(center)[
  Iterations = Outer loop iterations × Inner loop iterations
]

*Ví dụ 1: Quadratic (Bậc 2)*
```cpp
int i = 1;
while (i <= n) {
    int j = 1;
    while (j <= n) {
        // application code
        j = j + 1;  // O(n)
    }
    i = i + 1;  // O(n)
}
```
- Vòng ngoài: n lần
- Vòng trong: n lần (mỗi lần vòng ngoài)
- Tổng: n × n = n²
- *O(n²)*

*Ví dụ 2: Linearithmic (n log n)*
```cpp
int i = 1;
while (i <= n) {
    int j = 1;
    while (j <= n) {
        // application code
        j = j * 2;  // O(log n)
    }
    i = i + 1;  // O(n)
}
```
- Vòng ngoài: n lần
- Vòng trong: log n lần
- Tổng: n × log n
- *O(n log n)*

*Ví dụ 3: Dependent Quadratic (Vòng trong phụ thuộc vòng ngoài)*
```cpp
int i = 1;
while (i <= n) {
    int j = 1;
    while (j <= i) {  // j <= i (không phải j <= n)
        // application code
        j = j + 1;
    }
    i = i + 1;
}
```
- Vòng ngoài: n lần
- Vòng trong: 1, 2, 3, ..., n lần (tùy theo i)
- Tổng: 1 + 2 + 3 + ... + n = n(n+1)/2
- *O(n²)* (bỏ hằng số 1/2 và n)

#pagebreak()

=== Best, Worst, Average Case

*WHAT - Ba trường hợp phân tích*

1. *Best Case:* Trường hợp tốt nhất - số bước ít nhất
2. *Worst Case:* Trường hợp xấu nhất - số bước nhiều nhất
3. *Average Case:* Trường hợp trung bình

Tại sao phân tích 3 trường hợp?

1. *Best case:* Hiểu giới hạn dưới của giải thuật
2. *Worst case:* Đảm bảo giải thuật không chậm quá mức cho phép
3. *Average case:* Ước lượng hiệu suất thực tế

Trong thực tế, ta thường quan tâm đến *Worst Case* vì nó đảm bảo giải thuật luôn chạy trong thời gian cho phép.

#pagebreak()

== Bản chất trong máy tính

=== Tại sao Big-O quan trọng?

*Ví dụ thực tế: Tìm kiếm trong mảng*

Giả sử bạn có 1 tỷ số (n = 10⁹) và cần tìm một số cụ thể:

*Cách 1: Linear Search (O(n))*
```cpp
for (int i = 0; i < n; i++) {
    if (arr[i] == target) return i;
}
```
- Thời gian: ~10⁹ phép so sánh
- Với CPU 1 GHz: ~1 giây

*Cách 2: Binary Search (O(log n))*
```cpp
// Mảng đã sắp xếp
int left = 0, right = n-1;
while (left <= right) {
    int mid = (left + right) / 2;
    if (arr[mid] == target) return mid;
    else if (arr[mid] < target) left = mid + 1;
    else right = mid - 1;
}
```
- Thời gian: ~log₂(10⁹) ≈ 30 phép so sánh
- Với CPU 1 GHz: ~0.00003 giây

*Kết luận:* Binary Search nhanh hơn ~33 triệu lần!

=== Cache và Memory Access

*Tại sao array nhanh hơn linked list?*

```
Array (cache-friendly):
Memory: [1][2][3][4][5][6][7][8]  <- Liên tiếp
        ↑  Khi đọc [1], CPU tự động load [2][3][4] vào cache

Linked List (cache-unfriendly):
Memory: [1]→ [2]→ [3]→ [4]  <- Rải rác trong RAM
        ↑    ↑    ↑    ↑
      0x100 0x500 0x300 0x700
      Mỗi node phải đọc riêng → chậm hơn
```

*Hiệu suất thực tế:*
- Truy xuất array: ~1-2 ns (cache hit)
- Truy xuất linked list: ~100 ns (RAM access)

→ Dù cùng O(n) nhưng array thường nhanh hơn 50-100 lần trong thực tế!

#pagebreak()

== Lịch sử / Nguồn gốc

=== Sự ra đời của Big-O Notation

*1894: Paul Bachmann*
- Nhà toán học Đức đầu tiên đề xuất ký hiệu O trong sách "Analytische Zahlentheorie"
- Mục đích: Mô tả tốc độ tăng trưởng của hàm số

*1914: G.H. Hardy & J.E. Littlewood*
- Phát triển thêm các ký hiệu Big-O, Big-Ω, Big-Θ
- Ứng dụng trong lý thuyết số

*1960s-1970s: Khoa học máy tính*
- Donald Knuth (Cha đẻ của TeX, tác giả "The Art of Computer Programming")
- Đưa Big-O vào phân tích giải thuật
- Phổ biến trong ngành khoa học máy tính

=== Tại sao cần phân tích độ phức tạp?

*Thời kỳ đầu (1950s):*
- Máy tính rất chậm và đắt
- Mỗi giây CPU rất quý giá
- Phải tối ưu hóa từng dòng code

*Ngày nay:*
- Máy tính nhanh hơn hàng triệu lần
- Nhưng dữ liệu cũng lớn hơn hàng tỷ lần!
- Google, Facebook xử lý hàng tỷ requests/ngày
- Giải thuật O(n²) vs O(n log n) có thể chênh lệch hàng giờ đồng hồ

*Ví dụ: Google Search*
- Dữ liệu: Hàng tỷ trang web
- Nếu dùng O(n²): Không bao giờ trả về kết quả
- Thực tế dùng: O(log n) với index tree → Kết quả trong < 0.5 giây

#pagebreak()

== Phân tích thuật toán

=== Binary Search (Tìm kiếm nhị phân)

*Ý tưởng:*
- Mảng đã sắp xếp
- Mỗi bước chia đôi không gian tìm kiếm
- So sánh phần tử giữa với target

*Các bước:*
1. Tìm phần tử giữa `mid`
2. Nếu `arr[mid] == target` → Tìm thấy
3. Nếu `arr[mid] < target` → Tìm bên phải
4. Nếu `arr[mid] > target` → Tìm bên trái
5. Lặp lại

*Recurrence Equation:*
```
T(n) = 1 + T(n/2)
```
- 1: Phép so sánh ở bước hiện tại
- T(n/2): Bài toán con với kích thước n/2

*Giải:*
```
T(n) = 1 + T(n/2)
     = 1 + [1 + T(n/4)]
     = 1 + 1 + [1 + T(n/8)]
     = ...
     = log₂(n) + T(1)
     = O(log n)
```

*Complexity:*
- *Best case:* O(1) - Target ngay ở giữa
- *Worst case:* O(log n) - Target ở đầu/cuối hoặc không tồn tại
- *Average case:* O(log n)

*Complexity:*
- Time: O(log n)
- Space: O(1)

#pagebreak()

=== Sequential Search (Tìm kiếm tuần tự)

*Ý tưởng:*
- Duyệt từng phần tử từ đầu đến cuối
- So sánh với target

*Các bước:*
1. Bắt đầu từ phần tử đầu tiên
2. So sánh với target
3. Nếu bằng → Tìm thấy
4. Nếu không → Tiếp tục phần tử tiếp theo
5. Lặp lại cho đến hết mảng

*Complexity:*
- *Best case:* O(1) - Target ở đầu mảng
- *Worst case:* O(n) - Target ở cuối hoặc không có
- *Average case:* O(n)
  - Xác suất target ở vị trí i: p_i = 1/n
  - Số bước trung bình: (1 + 2 + 3 + ... + n) / n = (n+1)/2 = O(n)

*Complexity:*
- Time: Best: O(1), Worst: O(n), Avg: O(n)
- Space: O(1)

=== Quick Sort (Sắp xếp nhanh)

*Ý tưởng:*
- Chọn pivot (phần tử chốt)
- Partition: Chia mảng thành 2 phần (< pivot và > pivot)
- Đệ quy sắp xếp 2 phần

*Recurrence Equation:*
```
T(n) = O(n) + 2T(n/2)
```
- O(n): Thời gian partition
- 2T(n/2): Hai bài toán con, mỗi bài toán kích thước n/2

*Complexity:*
- *Best case:* O(n log n) - Pivot luôn chia đều
- *Worst case:* O(n²) - Pivot luôn là min/max (mảng đã sắp xếp)
- *Average case:* O(n log n)

*Complexity:*
- Time: Best: O(n log n), Worst: O(n²), Avg: O(n log n)
- Space: O(log n) - Stack cho đệ quy

#pagebreak()

== Minh họa từng bước

=== Binary Search - Tìm số 21

Mảng đã sắp xếp: `[1, 2, 3, 5, 8, 13, 21, 34, 55, 89]`

Target: 21

```
Bước 1:
[1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
 ↑              ↑                  ↑
left          mid                right
mid = (0+9)/2 = 4, arr[4] = 8
8 < 21 → Tìm bên phải

Bước 2:
[1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
                ↑   ↑           ↑
              left mid        right
mid = (5+9)/2 = 7, arr[7] = 34
34 > 21 → Tìm bên trái

Bước 3:
[1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
                ↑   ↑   ↑
              left mid right
mid = (5+6)/2 = 5, arr[5] = 13
13 < 21 → Tìm bên phải

Bước 4:
[1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
                    ↑
                  left=mid=right
mid = 6, arr[6] = 21
Tìm thấy! → Index = 6
```

Tổng số bước: 4 bước = log₂(10) ≈ 3.32 → Làm tròn lên 4

#pagebreak()

=== Sequential Search - Tìm số 7

Mảng: `[8, 5, 21, 2, 1, 13, 4, 34, 7, 18]`

Target: 7

```
Bước 1: arr[0] = 8  ≠ 7 → Tiếp tục
Bước 2: arr[1] = 5  ≠ 7 → Tiếp tục
Bước 3: arr[2] = 21 ≠ 7 → Tiếp tục
Bước 4: arr[3] = 2  ≠ 7 → Tiếp tục
Bước 5: arr[4] = 1  ≠ 7 → Tiếp tục
Bước 6: arr[5] = 13 ≠ 7 → Tiếp tục
Bước 7: arr[6] = 4  ≠ 7 → Tiếp tục
Bước 8: arr[7] = 34 ≠ 7 → Tiếp tục
Bước 9: arr[8] = 7  = 7 → Tìm thấy! Index = 8
```

Tổng số bước: 9 bước (gần worst case)

#pagebreak()

== Code minh họa bằng C++

=== Binary Search

```cpp
#include <iostream>
using namespace std;

// Binary Search - Yêu cầu mảng đã sắp xếp
int binarySearch(int arr[], int n, int target) {
    int left = 0;
    int right = n - 1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;  // Tránh overflow
        
        if (arr[mid] == target) {
            return mid;  // Tìm thấy
        }
        else if (arr[mid] < target) {
            left = mid + 1;  // Tìm bên phải
        }
        else {
            right = mid - 1;  // Tìm bên trái
        }
    }
    
    return -1;  // Không tìm thấy
}

int main() {
    int arr[] = {1, 2, 3, 5, 8, 13, 21, 34, 55, 89};
    int n = sizeof(arr) / sizeof(arr[0]);
    int target = 21;
    
    int index = binarySearch(arr, n, target);
    
    if (index != -1) {
        cout << "Found " << target << " at index " << index << endl;
    } else {
        cout << target << " not found" << endl;
    }
    
    return 0;
}
```

*Output:*
```
Found 21 at index 6
```

#pagebreak()

=== Sequential Search

```cpp
#include <iostream>
using namespace std;

// Sequential Search - Không yêu cầu mảng sắp xếp
int sequentialSearch(int arr[], int n, int target) {
    for (int i = 0; i < n; i++) {
        if (arr[i] == target) {
            return i;  // Tìm thấy
        }
    }
    return -1;  // Không tìm thấy
}

int main() {
    int arr[] = {8, 5, 21, 2, 1, 13, 4, 34, 7, 18};
    int n = sizeof(arr) / sizeof(arr[0]);
    int target = 7;
    
    int index = sequentialSearch(arr, n, target);
    
    if (index != -1) {
        cout << "Found " << target << " at index " << index << endl;
    } else {
        cout << target << " not found" << endl;
    }
    
    return 0;
}
```

*Output:*
```
Found 7 at index 8
```

#pagebreak()

=== Code phân tích các loại vòng lặp

```cpp
#include <iostream>
#include <chrono>
using namespace std;
using namespace chrono;

// O(n) - Linear
void linearLoop(int n) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        count++;
    }
    cout << "Linear: " << count << " iterations" << endl;
}

// O(log n) - Logarithmic
void logLoop(int n) {
    int count = 0;
    int i = 1;
    while (i <= n) {
        count++;
        i = i * 2;
    }
    cout << "Logarithmic: " << count << " iterations" << endl;
}

// O(n²) - Quadratic
void quadraticLoop(int n) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            count++;
        }
    }
    cout << "Quadratic: " << count << " iterations" << endl;
}

// O(n log n) - Linearithmic
void nLogNLoop(int n) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        int j = 1;
        while (j <= n) {
            count++;
            j = j * 2;
        }
    }
    cout << "n log n: " << count << " iterations" << endl;
}

int main() {
    int n = 1000;
    
    cout << "n = " << n << endl << endl;
    
    linearLoop(n);       // 1,000 iterations
    logLoop(n);          // ~10 iterations
    nLogNLoop(n);        // ~10,000 iterations
    
    // Quadratic quá chậm, demo với n nhỏ hơn
    quadraticLoop(100);  // 10,000 iterations
    
    return 0;
}
```

*Output:*
```
n = 1000

Linear: 1000 iterations
Logarithmic: 10 iterations
n log n: 10000 iterations
Quadratic: 10000 iterations
```

#pagebreak()

=== Đo thời gian thực tế

```cpp
#include <iostream>
#include <chrono>
#include <vector>
#include <algorithm>
using namespace std;
using namespace chrono;

int main() {
    int n = 100000;
    vector<int> arr(n);
    
    // Tạo mảng ngẫu nhiên
    for (int i = 0; i < n; i++) {
        arr[i] = rand();
    }
    
    // Đo thời gian Binary Search (yêu cầu mảng sắp xếp)
    sort(arr.begin(), arr.end());
    
    auto start = high_resolution_clock::now();
    binary_search(arr.begin(), arr.end(), arr[n/2]);
    auto end = high_resolution_clock::now();
    
    auto duration = duration_cast<microseconds>(end - start);
    cout << "Binary Search time: " << duration.count() << " microseconds" << endl;
    
    // Đo thời gian Linear Search
    start = high_resolution_clock::now();
    find(arr.begin(), arr.end(), arr[n/2]);
    end = high_resolution_clock::now();
    
    duration = duration_cast<microseconds>(end - start);
    cout << "Linear Search time: " << duration.count() << " microseconds" << endl;
    
    return 0;
}
```

#pagebreak()

== Những lỗi phổ biến khi code

*1. Tính mid sai (Integer overflow):*

```cpp
// ❌ SAI: Có thể bị overflow khi left + right > INT_MAX
int mid = (left + right) / 2;

// ✅ ĐÚNG: Tránh overflow
int mid = left + (right - left) / 2;
```

*2. Điều kiện dừng sai trong Binary Search:*

```cpp
// ❌ SAI: while (left < right) → Có thể bỏ sót phần tử cuối
while (left < right) {
    // ...
}

// ✅ ĐÚNG: while (left <= right)
while (left <= right) {
    // ...
}
```

*3. Không kiểm tra mảng rỗng:*

```cpp
// ❌ SAI: Không kiểm tra n <= 0
int binarySearch(int arr[], int n, int target) {
    int left = 0, right = n - 1;
    // ...
}

// ✅ ĐÚNG: Kiểm tra trước
int binarySearch(int arr[], int n, int target) {
    if (n <= 0) return -1;
    // ...
}
```

*4. Dùng Binary Search trên mảng chưa sắp xếp:*

```cpp
int arr[] = {8, 5, 21, 2, 1};  // ❌ Chưa sắp xếp
int index = binarySearch(arr, 5, 2);  // ❌ Kết quả sai!

// ✅ ĐÚNG: Sắp xếp trước
sort(arr, arr + 5);
int index = binarySearch(arr, 5, 2);
```

*5. Lãng phí thời gian phân tích sai:*

```cpp
// Lập trình viên nghĩ đây là O(n)
for (int i = 0; i < n; i++) {
    sort(arr, arr + n);  // ❌ sort() là O(n log n)!
}
// Thực tế: O(n² log n) - rất chậm!

// ✅ ĐÚNG: Sắp xếp 1 lần
sort(arr, arr + n);  // O(n log n)
for (int i = 0; i < n; i++) {
    // ...
}
```

#pagebreak()

== Khi nào nên dùng / không nên dùng

=== Binary Search vs Sequential Search

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  align: (left, left, left),
  [*Tiêu chí*], [*Binary Search*], [*Sequential Search*],
  [*Yêu cầu*], [Mảng đã sắp xếp], [Không yêu cầu],
  [*Time Complexity*], [O(log n)], [O(n)],
  [*Ưu điểm*], [Rất nhanh với dữ liệu lớn], [Đơn giản, không cần sort],
  [*Nhược điểm*], [Phải sắp xếp trước (O(n log n))], [Chậm với dữ liệu lớn],
  [*Khi nào dùng*], [Mảng đã sắp xếp, tìm kiếm nhiều lần], [Mảng nhỏ, tìm 1 lần],
)

*Ví dụ:*
```cpp
// Tìm 1 lần trong mảng chưa sort → Dùng Sequential
int arr[] = {8, 5, 21, 2, 1};
sequentialSearch(arr, 5, 2);  // ✅ O(n)

// Tìm nhiều lần → Sort 1 lần rồi dùng Binary
sort(arr, arr + 5);  // O(n log n) - chỉ 1 lần
binarySearch(arr, 5, 2);  // ✅ O(log n) × k lần
binarySearch(arr, 5, 8);
binarySearch(arr, 5, 21);
```

=== So sánh Complexity Classes

#table(
  columns: (1fr, 1fr, 2fr),
  align: (left, left, left),
  [*Complexity*], [*Ưu*], [*Nhược*],
  [O(1)], [Nhanh nhất, không phụ thuộc n], [Hiếm gặp],
  [O(log n)], [Rất nhanh, scale tốt], [Cần cấu trúc đặc biệt (sorted, tree)],
  [O(n)], [Chấp nhận được, đơn giản], [Chậm với n lớn (> 10⁶)],
  [O(n log n)], [Tốt nhất cho sorting], [Hơi chậm với n rất lớn],
  [O(n²)], [OK với n nhỏ (< 1000)], [Quá chậm với n > 10⁴],
  [O(2ⁿ), O(n!)], [Giải được bài toán], [Chỉ dùng với n rất nhỏ (< 20)],
)

#pagebreak()

== Ứng dụng thực tế

=== Hệ điều hành (Operating System)

*1. Process Scheduling:*
- O(1) scheduler: Linux CFS (Completely Fair Scheduler)
- Priority queue: O(log n) insert/delete

*2. Memory Management:*
- Buddy system: O(log n) allocation
- Page replacement algorithms: O(1) LRU with hash table

*3. File System:*
- B-Tree index: O(log n) search
- Directory lookup: O(log n) with balanced tree

=== Database

*1. Indexing:*
- B+ Tree: O(log n) search, insert, delete
- Hash index: O(1) average case

*2. Query Optimization:*
- Join algorithms: O(n log n) - Merge Join
- Sorting: O(n log n) - External Sort

*3. Full-text Search:*
- Inverted index: O(k + log n) k = số kết quả

=== Web Applications

*1. Google Search:*
- PageRank: O(n log n) sorting
- Autocomplete: Trie - O(k) k = độ dài từ khóa

*2. Facebook Newsfeed:*
- Sorting posts: O(n log n)
- Friend suggestions: O(V + E) - Graph algorithms

*3. E-commerce (Shopee, Lazada):*
- Product search: O(log n) with indexing
- Price sorting: O(n log n)
- Recommendation: O(n²) → Optimized to O(n log n)

=== Game Development

*1. Collision Detection:*
- Brute force: O(n²)
- Spatial partitioning (Quadtree): O(n log n)

*2. Pathfinding:*
- Dijkstra: O((V + E) log V)
- A\*: O(b^d) - Heuristic optimization

*3. Rendering:*
- Z-sorting: O(n log n)

=== Machine Learning / AI

*1. Training:*
- Linear Regression: O(n³) - Matrix inversion
- Neural Network: O(n × m × e) n=samples, m=features, e=epochs

*2. Prediction:*
- K-Nearest Neighbors: O(n) per query
- Decision Tree: O(log n) per query

*3. Data Processing:*
- Feature scaling: O(n)
- Sorting features: O(n log n)

#pagebreak()

== Tóm tắt chương

*Những điểm quan trọng nhất cần nhớ:*

1. *Big-O Notation* biểu diễn tốc độ tăng trưởng của hàm khi n → ∞
   - Bỏ hằng số
   - Giữ số hạng lớn nhất

2. *Thứ tự tốc độ* (từ nhanh đến chậm):
   ```
   O(1) < O(log n) < O(n) < O(n log n) < O(n²) < O(2ⁿ) < O(n!)
   ```

3. *Các loại vòng lặp:*
   - Tăng/giảm theo *cộng* (i++, i+=k) → O(n)
   - Tăng/giảm theo *nhân/chia* (i\*2, i/2) → O(log n)
   - Nested loops → Nhân complexity của từng vòng

4. *Ba trường hợp phân tích:*
   - Best case: Tốt nhất
   - Worst case: Xấu nhất (quan trọng nhất!)
   - Average case: Trung bình

5. *Binary Search:*
   - O(log n) - Rất nhanh
   - Yêu cầu mảng đã sắp xếp
   - Chia đôi không gian tìm kiếm mỗi bước

6. *Trong thực tế:*
   - n < 100: Mọi giải thuật đều OK
   - 100 < n < 10,000: Tránh O(n²)
   - n > 10,000: Cần O(n log n) hoặc tốt hơn
   - n > 1,000,000: Cần O(n) hoặc O(log n)

7. *Trade-off:*
   - Time vs Space: Đôi khi tốn thêm bộ nhớ để tăng tốc độ (caching, memoization)
   - Simplicity vs Performance: Code đơn giản vs code tối ưu

8. *P vs NP:*
   - P: Giải được trong thời gian đa thức (polynomial)
   - NP: Kiểm tra lời giải trong thời gian đa thức
   - NP-complete: Bài toán khó nhất trong NP

9. *Thực tế quan trọng hơn lý thuyết:*
   - O(n) với array thường nhanh hơn O(n) với linked list (do cache)
   - Hằng số ẩn trong Big-O cũng quan trọng

10. *Kỹ năng cần rèn luyện:*
    - Nhìn code → Nhận diện Big-O
    - Thiết kế giải thuật → Ước lượng complexity
    - Đọc tài liệu → Hiểu performance của thư viện/API

#pagebreak()
