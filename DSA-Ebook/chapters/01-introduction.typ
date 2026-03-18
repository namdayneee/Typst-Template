#import "../components/template.typ": *

= Giới thiệu về Cấu trúc Dữ liệu và Giải thuật

== Tổng quan chương

=== Nội dung chính của chương

Chương này là nền tảng của toàn bộ môn học Cấu trúc Dữ liệu và Giải thuật. Chúng ta sẽ tìm hiểu:

1. *Các khái niệm cơ bản:*
   - Data (Dữ liệu)
   - Data Type (Kiểu dữ liệu)
   - Data Structure (Cấu trúc dữ liệu)
   - Abstract Data Type (Kiểu dữ liệu trừu tượng)
   - Algorithm (Giải thuật)
   - Pseudocode (Mã giả)

2. *Ôn tập C++ cơ bản:*
   - Structures (Cấu trúc)
   - Classes (Lớp)
   - Pointers (Con trỏ)
   - Arrays (Mảng)
   - Pointers to structures and classes

=== Kiến thức nền cần biết trước

- Lập trình C++ cơ bản
- Hiểu biết về biến, hàm, vòng lặp, điều kiện
- Khái niệm về bộ nhớ máy tính (memory)

#pagebreak()

== Giải thích từng khái niệm

=== Data (Dữ liệu)

*WHAT - Dữ liệu là gì?*

*Dữ liệu* (Data) là thông tin đã được chuyển đổi sang dạng thuận tiện hơn để tính toán và phân tích.

Dữ liệu có thể là:
- *Qualitative data* (Dữ liệu định tính): Thông tin mô tả (ví dụ: tên, màu sắc, địa chỉ)
- *Quantitative data* (Dữ liệu định lượng): Thông tin số học (ví dụ: tuổi, chiều cao, điểm số)
- *Discrete data* (Dữ liệu rời rạc): Chỉ nhận các giá trị nhất định (ví dụ: số nguyên)
- *Continuous data* (Dữ liệu liên tục): Có thể nhận bất kỳ giá trị nào trong một khoảng (ví dụ: số thực)

*WHY*

Trong lập trình, dữ liệu là nguyên liệu thô mà chương trình xử lý. Mọi chương trình đều làm việc với dữ liệu:
- Nhận dữ liệu đầu vào (input)
- Xử lý dữ liệu (processing)
- Trả về kết quả (output)

Ví dụ: Một ứng dụng quản lý sinh viên cần lưu trữ và xử lý dữ liệu như tên, MSSV, điểm số.

*HOW*

Trong máy tính, mọi dữ liệu đều được biểu diễn dưới dạng *bit* (0 hoặc 1):
- Số nguyên: Mã hóa nhị phân (binary encoding)
- Số thực: Định dạng IEEE 754 (floating-point)
- Ký tự: Mã ASCII hoặc Unicode
- Chuỗi: Dãy ký tự liên tiếp trong bộ nhớ

Ví dụ: Số nguyên 5 được lưu dưới dạng `00000101` (8 bit).

#pagebreak()

=== Data Type (Kiểu dữ liệu)

*WHAT - Kiểu dữ liệu là gì?*

*Kiểu dữ liệu* là một lớp các đối tượng dữ liệu có cùng tính chất.

Một kiểu dữ liệu bao gồm:
1. *Tập hợp các giá trị* (set of values)
2. *Tập hợp các phép toán* trên các giá trị đó (set of operations)

Ví dụ về các kiểu dữ liệu cơ bản trong C++:

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  align: (left, left, left),
  [*Kiểu*], [*Tập giá trị*], [*Phép toán*],
  [`int`], [$-∞, ..., -2, -1, 0, 1, 2, ..., ∞$], [`+`, `-`, `*`, `/`, `%`, `++`, `--`],
  [`float`/`double`], [$-∞, ..., 0.0, ..., ∞$], [`+`, `-`, `*`, `/`],
  [`char`], [`'\\0'`, `'A'`, `'B'`, ..., `'a'`, `'b'`, ...], [`<`, `>`, `==`, `!=`],
  [`bool`], [`true`, `false`], [`&&`, `||`, `!`],
)

*WHY*

Kiểu dữ liệu giúp:
1. *Xác định cách lưu trữ* dữ liệu trong bộ nhớ
2. *Đảm bảo tính an toàn* khi thao tác với dữ liệu
3. *Tối ưu hóa* việc sử dụng bộ nhớ
4. *Ngăn chặn lỗi* (type safety): Không thể cộng một số với một chuỗi

Ví dụ: Khi khai báo `int age = 25;`, compiler biết:
- Cấp phát 4 bytes cho biến `age`
- Chỉ cho phép các phép toán số học trên `age`
- Không cho phép gán chuỗi vào `age`

*HOW*

*Trong bộ nhớ:*

- `int` (4 bytes = 32 bits): Lưu giá trị nguyên dạng two's complement
- `float` (4 bytes): Lưu theo chuẩn IEEE 754 (1 bit dấu + 8 bits exponent + 23 bits mantissa)
- `char` (1 byte): Lưu mã ASCII
- `bool` (1 byte): `true` = 1, `false` = 0

*CPU xử lý:*
- Phép toán số nguyên: Sử dụng ALU (Arithmetic Logic Unit)
- Phép toán số thực: Sử dụng FPU (Floating Point Unit)

#pagebreak()

=== Data Structure (Cấu trúc dữ liệu)

*WHAT - Cấu trúc dữ liệu là gì?*

*Cấu trúc dữ liệu* là sự kết hợp của nhiều phần tử, trong đó mỗi phần tử có thể là:
1. Một kiểu dữ liệu cơ bản, hoặc
2. Một cấu trúc dữ liệu khác

Kèm theo đó là một tập hợp các *mối quan hệ* (relationships) hoặc *cấu trúc* (structure) giữ các phần tử lại với nhau.

Ví dụ đơn giản: *Array* (Mảng)

```cpp
int fibonacci[8] = {1, 2, 3, 5, 8, 13, 21, 34};
```

- *Các phần tử:* 8 số nguyên
- *Cấu trúc:* Các phần tử được sắp xếp theo thứ tự, liên tiếp trong bộ nhớ
- *Mối quan hệ:* Phần tử thứ i có chỉ số i (index), liền kề với phần tử i-1 và i+1

*WHY*

Tại sao cần cấu trúc dữ liệu?

1. *Tổ chức dữ liệu hiệu quả:* Giúp lưu trữ và truy xuất dữ liệu nhanh chóng
2. *Giải quyết các bài toán thực tế:*
   - Danh sách sinh viên → Array hoặc Linked List
   - Lịch sử trình duyệt → Stack
   - Hàng đợi in ấn → Queue
   - Cây thư mục → Tree
   - Bản đồ đường đi → Graph

3. *Tối ưu hóa hiệu suất:* Cấu trúc dữ liệu phù hợp giúp thuật toán chạy nhanh hơn

*Ví dụ thực tế:*
- Tìm kiếm trong mảng chưa sắp xếp: O(n)
- Tìm kiếm trong mảng đã sắp xếp (binary search): O(log n)
- Tìm kiếm trong hash table: O(1)

*HOW*

*Trong bộ nhớ:*

Mảng `int arr[5]` được lưu như sau:

```
Memory Address    Value
0x1000           arr[0]
0x1004           arr[1]
0x1008           arr[2]
0x100C           arr[3]
0x1010           arr[4]
```

- Các phần tử nằm liên tiếp nhau
- Khoảng cách giữa 2 phần tử = kích thước kiểu dữ liệu (4 bytes cho `int`)
- Truy xuất `arr[i]` = `*(arr + i)` = địa chỉ đầu + i × sizeof(int)

*CPU xử lý:*
- Tính địa chỉ: `address = base_address + index * element_size`
- Truy xuất giá trị tại địa chỉ đó (1 phép toán, rất nhanh → O(1))

#pagebreak()

=== Abstract Data Type (Kiểu dữ liệu trừu tượng - ADT)

*WHAT - ADT là gì?*

*Abstract Data Type (ADT)* là một kiểu dữ liệu được định nghĩa bởi:
1. *Dữ liệu* (Data) - những gì nó lưu trữ
2. *Các phép toán* (Operations) - những gì có thể làm với nó
3. *Tính đóng gói* (Encapsulation) - ẩn chi tiết triển khai

ADT chỉ mô tả *WHAT* (làm gì), không mô tả *HOW* (làm thế nào).

*Khái niệm Abstraction (Trừu tượng hóa):*
- Người dùng biết ADT *có thể làm gì*
- *Cách thức hoạt động bên trong* được ẩn đi

*Ví dụ: List ADT*

*Interface (Giao diện):*
- *Data:* Một chuỗi các phần tử có cùng kiểu
- *Operations:* 
  - `insert(element, position)` - Chèn phần tử
  - `remove(position)` - Xóa phần tử
  - `get(position)` - Lấy phần tử
  - `size()` - Số lượng phần tử

*Implementation (Triển khai):*
- Cách 1: Dùng *Array* (mảng tĩnh)
- Cách 2: Dùng *Linked List* (danh sách liên kết)

Người dùng chỉ cần biết *có thể insert, remove, get*, không cần biết bên trong dùng array hay linked list.

*WHY*

Tại sao cần ADT?

1. *Tách biệt giao diện và triển khai:*
   - Người dùng không cần biết chi tiết bên trong
   - Có thể thay đổi cách triển khai mà không ảnh hưởng code sử dụng

2. *Tái sử dụng code:*
   - Một ADT có thể có nhiều cách triển khai
   - Chọn cách triển khai phù hợp với bài toán cụ thể

3. *Dễ bảo trì:*
   - Thay đổi bên trong không làm hỏng code bên ngoài
   - Tối ưu hóa dễ dàng hơn

*Ví dụ thực tế:*
- `std::vector` trong C++ STL là một List ADT
- Bạn dùng `push_back()`, `pop_back()` mà không cần biết bên trong quản lý bộ nhớ thế nào

*HOW*

*Cách triển khai ADT trong C++:*

Sử dụng `class` với:
- `private`: Dữ liệu và chi tiết triển khai (ẩn đi)
- `public`: Giao diện (phép toán)

```cpp
class Stack {
private:
    int data[100];  // Chi tiết triển khai (ẩn)
    int top;
    
public:
    void push(int x);  // Giao diện (public)
    int pop();
    bool isEmpty();
};
```

Người dùng chỉ thấy `push()`, `pop()`, `isEmpty()`, không thấy mảng `data[]` bên trong.

#pagebreak()

=== Algorithm (Giải thuật)

*WHAT - Giải thuật là gì?*

*Giải thuật* (Algorithm) là một chuỗi các bước logic để giải quyết một vấn đề.

Theo Niklaus Wirth (nhà khoa học máy tính nổi tiếng):

#align(center)[
  #text(size: 14pt, weight: "bold", fill: rgb("#1976D2"))[
    Program = Data Structures + Algorithms
  ]
]

Chương trình = Cấu trúc dữ liệu + Giải thuật

*Đặc điểm của một giải thuật tốt:*
1. *Input:* Có đầu vào rõ ràng
2. *Output:* Có đầu ra xác định
3. *Definiteness:* Mỗi bước được định nghĩa rõ ràng, không mơ hồ
4. *Finiteness:* Kết thúc sau một số hữu hạn bước
5. *Effectiveness:* Mỗi bước có thể thực hiện được

*WHY*

Tại sao cần giải thuật?

1. *Giải quyết vấn đề một cách có hệ thống*
2. *Tối ưu hóa hiệu suất:* Giải thuật tốt giúp chương trình chạy nhanh hơn
3. *Có thể tái sử dụng:* Giải thuật độc lập với ngôn ngữ lập trình

*Ví dụ:*
- Sắp xếp 1 triệu số:
  - Bubble Sort: ~10 phút
  - Quick Sort: ~1 giây
- Tìm kiếm trong 1 tỷ phần tử:
  - Linear Search: vài phút
  - Binary Search: < 1 giây

*HOW*

*Giải thuật được biểu diễn bằng:*

1. *Ngôn ngữ tự nhiên:* Mô tả bằng lời
2. *Flowchart:* Sơ đồ khối
3. *Pseudocode:* Mã giả (giữa ngôn ngữ tự nhiên và code)
4. *Programming language:* Code thực tế

*Cách CPU thực thi:*
- Fetch (Lấy lệnh từ bộ nhớ)
- Decode (Giải mã lệnh)
- Execute (Thực thi lệnh)
- Lặp lại cho lệnh tiếp theo

#pagebreak()

=== Pseudocode (Mã giả)

*WHAT - Pseudocode là gì?*

*Pseudocode* là cách biểu diễn giải thuật bằng ngôn ngữ gần với tiếng Anh, kết hợp với cấu trúc lập trình.

Pseudocode = English + Code
- Cú pháp thoải mái, dễ đọc
- Sử dụng cấu trúc điều khiển cơ bản (sequential, conditional, iterative)

*Cấu trúc một Pseudocode:*

1. *Algorithm Header:*
   - Tên giải thuật
   - Tham số và kiểu dữ liệu
   - Mục đích (Purpose)
   - Điều kiện tiên quyết (Precondition)
   - Điều kiện sau (Postcondition)
   - Giá trị trả về (Return)

2. *Algorithm Body:*
   - Các câu lệnh
   - Đánh số thập phân để thể hiện mức độ
   - Các biến quan trọng
   - Chú thích giải thích

*Ví dụ về Pseudocode:*

```
Algorithm average
Pre: nothing
Post: the average of the input numbers is printed

1  i = 0
2  sum = 0
3  while all numbers not read do
4      i = i + 1
5      read number
6      sum = sum + number
7  end
8  average = sum / i
9  print average
10 End average
```

*WHY*

Tại sao dùng Pseudocode?

1. *Độc lập với ngôn ngữ:* Không phụ thuộc vào C++, Java, Python...
2. *Dễ hiểu:* Gần với tư duy con người
3. *Tập trung vào logic:* Không lo về cú pháp chi tiết
4. *Dễ chuyển đổi:* Có thể code bằng bất kỳ ngôn ngữ nào
5. *Giao tiếp hiệu quả:* Team dễ thảo luận về giải thuật

#pagebreak()

== Bản chất trong máy tính

=== Cách dữ liệu được lưu trong memory

*Layout bộ nhớ của một chương trình C++:*

```
+------------------+  <- Địa chỉ cao (High Address)
|      Stack       |  Biến local, tham số hàm (tự động quản lý)
|        ↓         |  Phát triển xuống dưới
+------------------+
|        ↑         |
|      Heap        |  Bộ nhớ động (new/delete)
|                  |  Phát triển lên trên
+------------------+
|   BSS Segment    |  Biến global chưa khởi tạo
+------------------+
|   Data Segment   |  Biến global đã khởi tạo
+------------------+
|   Text Segment   |  Code (instructions)
+------------------+  <- Địa chỉ thấp (Low Address)
```

*Ví dụ cụ thể:*

```cpp
int globalVar = 100;        // Data Segment

int main() {
    int localVar = 50;      // Stack
    int* ptr = new int(25); // ptr trên Stack, *ptr trên Heap
    
    return 0;
}
```

*Memory layout:*
```
Stack:
  [localVar = 50]  <- 0x7FFF1234
  [ptr = 0x1A2B]   <- 0x7FFF1230

Heap:
  [25]             <- 0x00001A2B (địa chỉ ptr trỏ tới)

Data Segment:
  [globalVar = 100] <- 0x00400000
```

=== CPU xử lý dữ liệu

*Các bước CPU thực thi một lệnh:*

1. *Fetch:* Lấy instruction từ RAM vào CPU
2. *Decode:* Giải mã instruction (ADD, MOV, JMP...)
3. *Execute:* Thực hiện phép toán
4. *Write-back:* Ghi kết quả vào register hoặc memory

*Ví dụ: `int c = a + b;`*

```
1. LOAD R1, [address_of_a]    // Đọc a từ RAM vào register R1
2. LOAD R2, [address_of_b]    // Đọc b từ RAM vào register R2
3. ADD R3, R1, R2             // R3 = R1 + R2
4. STORE [address_of_c], R3   // Ghi R3 vào địa chỉ của c
```

*Tốc độ truy xuất:*
- Register: < 1 ns (nhanh nhất)
- L1 Cache: ~1 ns
- L2 Cache: ~3-10 ns
- RAM: ~100 ns
- SSD: ~100,000 ns
- HDD: ~10,000,000 ns

→ Cấu trúc dữ liệu tốt giúp tận dụng cache, giảm truy xuất RAM.

#pagebreak()

== Lịch sử / Nguồn gốc

=== Nguồn gốc khái niệm Data Structure

*Thời kỳ đầu (1940s-1950s):*
- Máy tính đầu tiên: ENIAC (1945)
- Lập trình bằng machine code (0 và 1)
- Chưa có khái niệm cấu trúc dữ liệu

*Sự ra đời của Array (1950s):*
- Array là cấu trúc dữ liệu đầu tiên
- Sinh ra từ nhu cầu lưu trữ nhiều giá trị cùng kiểu

*Thời kỳ phát triển (1960s-1970s):*
- *Linked List* (1955): Tony Hoare
- *Tree* (1960s): Cây nhị phân, AVL tree
- *Hash Table* (1953): Hans Peter Luhn
- *Stack & Queue*: Xuất phát từ nhu cầu quản lý bộ nhớ và CPU scheduling

*Ngôn ngữ lập trình ảnh hưởng:*
- *FORTRAN* (1957): Đưa array vào ngôn ngữ lập trình
- *LISP* (1958): Linked list
- *Algol* (1960): Block structure
- *C* (1972): Pointers, structures
- *C++* (1983): Classes, templates, STL

=== Tại sao có ADT?

*Vấn đề trước khi có ADT:*
- Code phụ thuộc vào chi tiết triển khai
- Khó bảo trì và mở rộng
- Không thể tái sử dụng

*Giải pháp: Information Hiding (1972):*
- David Parnas đề xuất ý tưởng ẩn chi tiết triển khai
- Dẫn đến khái niệm ADT và OOP

*Ngày nay:*
- Hầu hết ngôn ngữ đều hỗ trợ ADT
- C++ STL (Standard Template Library) cung cấp các ADT sẵn: `vector`, `list`, `stack`, `queue`, `map`, `set`...

#pagebreak()

== Phân tích thuật toán

Chương này chủ yếu về khái niệm, chưa có thuật toán cụ thể để phân tích. Chúng ta sẽ phân tích các thuật toán cụ thể trong các chương sau.

Tuy nhiên, có thể lấy một ví dụ đơn giản:

*Ví dụ: Thuật toán tính trung bình cộng*

```
Algorithm average
Pre: nothing
Post: the average of the input numbers is printed

1  i = 0
2  sum = 0
3  while all numbers not read do
4      i = i + 1
5      read number
6      sum = sum + number
7  end
8  average = sum / i
9  print average
10 End average
```

*Phân tích:*
- *Input:* n số
- *Output:* Trung bình cộng
- *Time Complexity:* O(n) - phải đọc qua n số
- *Space Complexity:* O(1) - chỉ dùng 3 biến (i, sum, average)

#pagebreak()

== Minh họa từng bước

*Ví dụ: Tính trung bình của 5, 10, 15, 20*

```
Bước 1: i = 0, sum = 0
Bước 2: Đọc 5
        i = 1, sum = 0 + 5 = 5
Bước 3: Đọc 10
        i = 2, sum = 5 + 10 = 15
Bước 4: Đọc 15
        i = 3, sum = 15 + 15 = 30
Bước 5: Đọc 20
        i = 4, sum = 30 + 20 = 50
Bước 6: average = 50 / 4 = 12.5
Bước 7: In ra 12.5
```

#pagebreak()

== Code minh họa bằng C++

=== Struct (Cấu trúc)

```cpp
#include <iostream>
#include <string>
using namespace std;

// Định nghĩa struct
struct Car {
    string brand;
    int year;
};

int main() {
    // Khai báo biến kiểu Car
    Car myCar;
    myCar.brand = "Audi";
    myCar.year = 2011;
    
    // In thông tin
    cout << "My favorite car is: " << endl;
    cout << myCar.brand << " (" << myCar.year << ")" << endl;
    
    return 0;
}
```

*Output:*
```
My favorite car is:
Audi (2011)
```

=== Class với Constructor

```cpp
#include <iostream>
using namespace std;

class Rectangle {
    int width, height;  // Private
    
public:
    // Constructor
    Rectangle(int w, int h) {
        width = w;
        height = h;
    }
    
    // Method
    int area() {
        return width * height;
    }
};

int main() {
    Rectangle rectA(3, 4);
    Rectangle rectB(5, 6);
    
    cout << "rectA area: " << rectA.area() << endl;
    cout << "rectB area: " << rectB.area() << endl;
    
    return 0;
}
```

*Output:*
```
rectA area: 12
rectB area: 30
```

=== Pointers (Con trỏ)

```cpp
#include <iostream>
using namespace std;

int main() {
    int value = 93;
    int* p;
    
    p = &value;        // p lưu địa chỉ của value
    cout << "Address of value: " << p << endl;
    cout << "Value of value: " << *p << endl;
    
    *p = 100;          // Thay đổi value thông qua con trỏ
    cout << "New value: " << value << endl;
    
    return 0;
}
```

*Output:*
```
Address of value: 0x7ffeea8b9a3c
Value of value: 93
New value: 100
```

=== Arrays (Mảng)

```cpp
#include <iostream>
using namespace std;

int main() {
    int fibonacci[8] = {1, 2, 3, 5, 8, 13, 21, 34};
    
    // In các phần tử
    for (int i = 0; i < 8; i++) {
        cout << "fibonacci[" << i << "] = " << fibonacci[i] << endl;
    }
    
    // Array và pointer
    int* p = fibonacci;
    cout << "\nUsing pointer:" << endl;
    cout << "First element: " << *p << endl;
    cout << "Second element: " << *(p + 1) << endl;
    
    return 0;
}
```

=== Pointer to Struct

```cpp
#include <iostream>
#include <string>
using namespace std;

struct Student {
    string name;
    string firstname;
    int age;
};

void printStudent(Student* s) {
    cout << "My name is " << s->name << " " << s->firstname << endl;
    cout << "I am " << s->age << " years old." << endl;
}

int main() {
    Student sv;
    sv.name = "Nguyen";
    sv.firstname = "An";
    sv.age = 20;
    
    // Con trỏ đến struct
    Student* psv = &sv;
    
    // Truy xuất qua con trỏ
    printStudent(psv);
    
    return 0;
}
```

*Output:*
```
My name is Nguyen An
I am 20 years old.
```

=== Pointer to Class

```cpp
#include <iostream>
using namespace std;

class Rectangle {
    int width, height;
    
public:
    Rectangle(int w, int h) : width(w), height(h) {}
    
    int area() {
        return width * height;
    }
};

int main() {
    Rectangle rectA(3, 4);
    Rectangle* rectB = &rectA;              // Con trỏ tới object có sẵn
    Rectangle* rectC = new Rectangle(5, 6); // Con trỏ tới object mới (heap)
    
    cout << "rectA area: " << rectA.area() << endl;
    cout << "rectB area: " << rectB->area() << endl;
    cout << "rectC area: " << rectC->area() << endl;
    
    delete rectC;  // Giải phóng bộ nhớ
    
    return 0;
}
```

*Output:*
```
rectA area: 12
rectB area: 12
rectC area: 30
```

#pagebreak()

== Những lỗi phổ biến khi code

=== Lỗi với Pointers

*1. Dangling Pointer (Con trỏ lơ lửng):*

```cpp
int* p = new int(10);
delete p;
cout << *p << endl;  // ❌ LỖI: p trỏ tới vùng nhớ đã được giải phóng
```

*Cách sửa:*
```cpp
int* p = new int(10);
delete p;
p = nullptr;  // ✅ Gán nullptr sau khi delete
if (p != nullptr) {
    cout << *p << endl;
}
```

*2. Memory Leak (Rò rỉ bộ nhớ):*

```cpp
void func() {
    int* p = new int(10);
    // Quên delete
}  // ❌ Bộ nhớ không được giải phóng
```

*Cách sửa:*
```cpp
void func() {
    int* p = new int(10);
    // ... sử dụng p ...
    delete p;  // ✅ Nhớ giải phóng
}
```

*3. Null Pointer Dereference:*

```cpp
int* p = nullptr;
cout << *p << endl;  // ❌ LỖI: Dereference null pointer
```

*Cách sửa:*
```cpp
int* p = nullptr;
if (p != nullptr) {  // ✅ Kiểm tra trước khi dereference
    cout << *p << endl;
}
```

=== Lỗi với Arrays

*1. Array Out of Bounds:*

```cpp
int arr[5] = {1, 2, 3, 4, 5};
cout << arr[5] << endl;  // ❌ LỖI: Chỉ có index 0-4
```

*Cách sửa:*
```cpp
int arr[5] = {1, 2, 3, 4, 5};
for (int i = 0; i < 5; i++) {  // ✅ i < 5, không phải i <= 5
    cout << arr[i] << endl;
}
```

*2. Array Not Initialized:*

```cpp
int arr[100];
cout << arr[0] << endl;  // ❌ Giá trị rác (garbage value)
```

*Cách sửa:*
```cpp
int arr[100] = {0};  // ✅ Khởi tạo tất cả phần tử = 0
```

=== Lỗi với Struct/Class

*1. Quên khởi tạo:*

```cpp
struct Point {
    int x, y;
};

Point p;
cout << p.x << endl;  // ❌ Giá trị rác
```

*Cách sửa:*
```cpp
Point p = {0, 0};  // ✅ Khởi tạo
// Hoặc dùng constructor
```

#pagebreak()

== Khi nào nên dùng / không nên dùng

=== Struct vs Class

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  align: (left, left, left),
  [*Tiêu chí*], [*Struct*], [*Class*],
  [*Mục đích*], [Nhóm dữ liệu đơn giản], [ADT phức tạp với behavior],
  [*Mặc định*], [Public], [Private],
  [*Khi nào dùng*], [POD (Plain Old Data), không logic phức tạp], [Có methods, invariants cần bảo vệ],
  [*Ví dụ*], [`Point {x, y}`, `Color {r, g, b}`], [`Stack`, `Queue`, `BinaryTree`],
)

*Ví dụ:*
```cpp
// ✅ Dùng struct cho dữ liệu đơn giản
struct Point {
    int x, y;
};

// ✅ Dùng class cho ADT
class Stack {
private:
    int data[100];
    int top;
public:
    void push(int x);
    int pop();
};
```

=== Array vs Pointer

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  align: (left, left, left),
  [*Tiêu chí*], [*Array*], [*Pointer*],
  [*Kích thước*], [Cố định (compile-time)], [Động (runtime)],
  [*Bộ nhớ*], [Stack (local) hoặc Data (global)], [Heap (với `new`)],
  [*An toàn*], [Tự động giải phóng], [Phải `delete` thủ công],
  [*Hiệu suất*], [Nhanh hơn (cache-friendly)], [Chậm hơn một chút],
  [*Khi nào dùng*], [Kích thước biết trước], [Kích thước động, cần resize],
)

*Ví dụ:*
```cpp
// ✅ Dùng array khi biết kích thước
int scores[100];  // Lưu điểm của 100 sinh viên cố định

// ✅ Dùng pointer khi kích thước động
int n;
cin >> n;
int* scores = new int[n];  // Số sinh viên nhập từ user
// ...
delete[] scores;
```

#pagebreak()

== Ứng dụng thực tế

=== Data Structures trong Hệ điều hành

*1. Process Management:*
- *Queue:* Ready queue, waiting queue cho CPU scheduling
- *Stack:* Call stack cho mỗi process/thread
- *Tree:* Process tree (parent-child relationships)

*2. Memory Management:*
- *Linked List:* Free memory blocks
- *Tree:* Page table (virtual memory)
- *Hash Table:* File descriptor table

*3. File System:*
- *Tree:* Directory structure (folder hierarchy)
- *Linked List:* File allocation (linked allocation)

=== Data Structures trong Database

*1. Indexing:*
- *B-Tree / B+ Tree:* Index structure (MySQL, PostgreSQL)
- *Hash Table:* Hash index
- *Trie:* Full-text search

*2. Query Processing:*
- *Stack:* Expression evaluation
- *Queue:* Buffer pool management

*3. Transaction Management:*
- *Graph:* Deadlock detection
- *Queue:* Transaction queue

=== Data Structures trong Compiler

*1. Lexical Analysis:*
- *Hash Table:* Symbol table (lưu biến, hàm)
- *Trie:* Keyword lookup

*2. Syntax Analysis:*
- *Stack:* Parsing stack
- *Tree:* Abstract Syntax Tree (AST)

*3. Code Optimization:*
- *Graph:* Control Flow Graph (CFG), Data Flow Graph

=== Data Structures trong Web

*1. Browser:*
- *Stack:* Back/Forward navigation history
- *Tree:* DOM (Document Object Model)
- *Hash Table:* Cache

*2. Web Server:*
- *Queue:* Request queue
- *Hash Table:* Session storage
- *Tree:* URL routing

*3. Search Engine:*
- *Trie:* Autocomplete
- *Graph:* PageRank
- *Inverted Index:* Document search

=== Data Structures trong Game

*1. Graphics:*
- *Quadtree / Octree:* Spatial partitioning
- *BSP Tree:* 3D rendering

*2. AI:*
- *Graph:* Pathfinding (A\*)
- *Tree:* Decision tree, Behavior tree

*3. Game State:*
- *Stack:* Undo/Redo
- *Queue:* Event queue

#pagebreak()

== Tóm tắt chương

*Những điểm quan trọng nhất cần nhớ:*

1. *Data* là nguyên liệu thô, *Data Type* xác định cách lưu và xử lý, *Data Structure* tổ chức dữ liệu hiệu quả.

2. *Abstract Data Type (ADT)* tách biệt "làm gì" (interface) khỏi "làm thế nào" (implementation).

3. *Algorithm* là các bước logic để giải quyết vấn đề. Chương trình = Data Structures + Algorithms.

4. *Pseudocode* giúp mô tả giải thuật độc lập với ngôn ngữ lập trình.

5. *Trong bộ nhớ:*
   - Stack: Biến local, tự động quản lý
   - Heap: Bộ nhớ động (`new`/`delete`), phải quản lý thủ công
   - Data/BSS: Biến global

6. *Struct* dùng cho dữ liệu đơn giản, *Class* dùng cho ADT phức tạp.

7. *Pointers* mạnh mẽ nhưng dễ lỗi: Nhớ kiểm tra `nullptr`, giải phóng bộ nhớ, tránh dangling pointer.

8. *Arrays* nhanh nhưng cố định kích thước; *Dynamic arrays* (pointer + `new`) linh hoạt hơn.

9. *Ứng dụng thực tế:* DSA xuất hiện ở mọi nơi - OS, database, compiler, web, game...

10. *Tư duy quan trọng:* Luôn hỏi WHAT, WHY, HOW khi học cấu trúc dữ liệu hoặc giải thuật mới.

#pagebreak()
