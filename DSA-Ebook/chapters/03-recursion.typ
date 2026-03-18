#import "../components/template.typ": *

= Đệ quy (Recursion)

== Tổng quan chương

=== Nội dung chính của chương

Đệ quy là một trong những kỹ thuật lập trình mạnh mẽ và thanh lịch nhất. Chương này sẽ giúp bạn:

1. *Khái niệm Đệ quy:*
   - Direct recursion
   - Indirect recursion

2. *Thành phần cơ bản:*
   - Base case (Trường hợp dừng)
   - General case (Trường hợp đệ quy)

3. *Tính chất của Đệ quy*

4. *Thiết kế giải thuật đệ quy*

5. *Các ví dụ kinh điển:*
   - Factorial (Giai thừa)
   - GCD (Ước số chung lớn nhất)
   - Fibonacci
   - Towers of Hanoi (Tháp Hà Nội)
   - Print list in reverse

6. *Recursion và Backtracking:*
   - Eight Queens Problem

7. *So sánh Recursion vs Iteration*

=== Kiến thức nền cần biết trước

- Hàm (functions) trong C++
- Stack (khái niệm cơ bản)
- Hiểu cách hàm được gọi và return

#pagebreak()

== Giải thích từng khái niệm

=== Recursion (Đệ quy)

*WHAT - Đệ quy là gì?*

*Đệ quy* (Recursion) là một quá trình lặp lại trong đó một giải thuật (hàm) *gọi chính nó*.

*Hai loại đệ quy:*

1. *Direct Recursion (Đệ quy trực tiếp):*
   - Hàm A gọi chính hàm A
   - A → A

2. *Indirect Recursion (Đệ quy gián tiếp):*
   - Hàm A gọi hàm B, hàm B gọi lại hàm A
   - A → B → A

*Ví dụ trực quan: Giai thừa*

Định nghĩa toán học:
```
n! = 1                          nếu n = 0
n! = n × (n-1) × (n-2) × ... × 1  nếu n > 0
```

Định nghĩa đệ quy:
```
factorial(n) = 1                      nếu n = 0  (base case)
factorial(n) = n × factorial(n-1)     nếu n > 0  (recursive case)
```

Tại sao cần đệ quy?

1. *Code ngắn gọn, dễ hiểu:*
   - Nhiều bài toán có bản chất đệ quy (tree traversal, graph search)
   - Code đệ quy thường ngắn hơn và dễ đọc hơn nhiều so với iteration

2. *Giải quyết bài toán phức tạp:*
   - Chia bài toán lớn thành các bài toán con nhỏ hơn
   - Mỗi bài toán con có cùng cấu trúc với bài toán gốc

3. *Tự nhiên với một số cấu trúc dữ liệu:*
   - Tree: Mỗi node có các subtree
   - Linked List: Head + phần còn lại (tail)
   - Graph: DFS, BFS

*Ví dụ thực tế:*
- Duyệt cây thư mục trong máy tính
- Tính toán biểu thức toán học
- Game: Minimax algorithm (cờ vua, cờ ca rô)
- Chia để trị: Merge Sort, Quick Sort

*Cách đệ quy hoạt động trong máy tính:*

Khi một hàm đệ quy được gọi:

1. *Push vào Stack:*
   - Tất cả biến local, tham số, địa chỉ return được lưu vào stack

2. *Thực thi hàm:*
   - Nếu đến base case → Return kết quả
   - Nếu chưa → Gọi đệ quy (push stack tiếp)

3. *Pop khỏi Stack:*
   - Khi hàm return, stack frame được giải phóng
   - Quay lại hàm gọi trước đó

*Ví dụ: factorial(3)*

```
Call Stack (từ trên xuống):

factorial(0) → return 1                  Stack: [0]
factorial(1) = 1 × factorial(0) = 1      Stack: [1, 0]
factorial(2) = 2 × factorial(1) = 2      Stack: [2, 1, 0]
factorial(3) = 3 × factorial(2) = 6      Stack: [3, 2, 1, 0]

Return process (từ dưới lên):
factorial(0) returns 1
factorial(1) returns 1 × 1 = 1
factorial(2) returns 2 × 1 = 2
factorial(3) returns 3 × 2 = 6
```

#pagebreak()

=== Thành phần cơ bản của Đệ quy

*WHAT - Hai thành phần bắt buộc*

Mọi giải thuật đệ quy đều phải có 2 thành phần:

1. *Base Case (Trường hợp dừng):*
   - Điều kiện để dừng đệ quy
   - Trường hợp đơn giản nhất, có thể giải trực tiếp
   - KHÔNG gọi đệ quy

2. *General Case (Trường hợp đệ quy):*
   - Chia bài toán thành bài toán con nhỏ hơn
   - Gọi đệ quy với tham số "gần base case hơn"

*Ví dụ: Factorial*

```cpp
int factorial(int n) {
    // Base case: Dừng khi n = 0
    if (n == 0) {
        return 1;
    }
    
    // General case: n! = n × (n-1)!
    return n * factorial(n - 1);
}
```

*Cảnh báo quan trọng:*

1. *Thiếu Base Case:* Đệ quy vô tận → Stack Overflow!
2. *Base Case sai:* Vẫn đệ quy vô tận
3. *Không tiến về Base Case:* Ví dụ factorial(n+1) thay vì factorial(n-1)

*Quy tắc vàng khi thiết kế đệ quy:*

1. Xác định Base Case (Bài toán đơn giản nhất)
2. Xác định General Case (Làm sao chia nhỏ bài toán?)
3. Đảm bảo mỗi lần gọi đệ quy đều *tiến gần hơn* đến Base Case

#pagebreak()

=== Properties of Recursion (Tính chất của Đệ quy)

*Tính chất cơ bản:*

1. *Giải bài toán lớn bằng cách dùng lời giải của bài toán con:*
   - Mỗi lần gọi đệ quy giải quyết một phần nhỏ hơn của bài toán

2. *Cuối cùng bài toán con đủ đơn giản:*
   - Đến Base Case → Không cần đệ quy nữa
   - Bắt đầu return kết quả ngược lên

3. *Mỗi lần gọi đệ quy phải làm giảm kích thước bài toán:*
   - factorial(n) → factorial(n-1): n giảm
   - binarySearch(left, right) → binarySearch(left, mid-1): Giảm một nửa

#pagebreak()

== Bản chất trong máy tính

=== Call Stack trong Đệ quy

*Memory Layout của đệ quy:*

```
Stack (phát triển xuống dưới):

┌─────────────────────┐ ← Top of Stack
│  factorial(0)       │
│  n = 0              │
│  return address     │
├─────────────────────┤
│  factorial(1)       │
│  n = 1              │
│  return address     │
├─────────────────────┤
│  factorial(2)       │
│  n = 2              │
│  return address     │
├─────────────────────┤
│  factorial(3)       │
│  n = 3              │
│  return address     │
├─────────────────────┤
│  main()             │
│  ...                │
└─────────────────────┘ ← Bottom of Stack
```

*Mỗi Stack Frame chứa:*
- Tham số của hàm (n)
- Biến local
- Return address (địa chỉ để quay lại sau khi return)

*Vấn đề: Stack Overflow*

```cpp
int badRecursion(int n) {
    return badRecursion(n);  // ❌ Không có base case!
}
```

→ Stack đầy → Crash!

=== Đệ quy vs Iteration - Hiệu suất

*Time Complexity:*
- Thường giống nhau
- Ví dụ: factorial đệ quy và iteration đều O(n)

*Space Complexity:*
- *Iteration:* O(1) - Chỉ dùng vài biến
- *Recursion:* O(n) - Stack frame cho mỗi lần gọi

*Speed:*
- *Iteration:* Nhanh hơn (không overhead của function call)
- *Recursion:* Chậm hơn một chút (push/pop stack)

*Nhưng:*
- Code đệ quy thường ngắn gọn, dễ hiểu hơn
- Một số bài toán viết đệ quy dễ hơn rất nhiều (tree, graph)

#pagebreak()

== Lịch sử / Nguồn gốc

=== Lịch sử của Đệ quy

*1930s: Lambda Calculus*
- Alonzo Church phát triển λ-calculus
- Nền tảng toán học cho recursion

*1960: LISP (John McCarthy)*
- Ngôn ngữ lập trình đầu tiên hỗ trợ đệ quy mạnh mẽ
- Dùng cho AI research

*1970s-1980s: Functional Programming*
- Haskell, ML, Scheme
- Đệ quy là kỹ thuật lập trình chính

*Ngày nay:*
- Mọi ngôn ngữ lập trình đều hỗ trợ đệ quy
- Quan trọng trong thuật toán: Tree, Graph, Divide & Conquer

=== Towers of Hanoi - Câu chuyện

*Truyền thuyết:*
- Tại một ngôi đền ở Hà Nội, có 3 cây cột và 64 đĩa vàng
- Các nhà sư phải chuyển đĩa từ cột này sang cột khác
- Khi hoàn thành → Thế giới kết thúc

*Thực tế:*
- Bài toán do nhà toán học Pháp Édouard Lucas phát minh (1883)
- Minh họa hoàn hảo cho đệ quy
- Với 64 đĩa: 2⁶⁴ - 1 bước ≈ 500 tỷ năm!

#pagebreak()

== Phân tích thuật toán

=== Factorial (Giai thừa)

*Ý tưởng:*
- n! = n × (n-1)!
- Base case: 0! = 1

*Pseudocode:*
```
Algorithm recursiveFactorial(n)
Pre: n >= 0
Post: n! returned

if n = 0 then
    return 1
else
    return n * recursiveFactorial(n-1)
end
End recursiveFactorial
```

*Phân tích:*
- Mỗi lần gọi giảm n đi 1
- Số lần gọi: n+1 (factorial(n) → factorial(0))
- Mỗi lần: O(1) (một phép nhân)

*Complexity:*
- Time: O(n)
- Space: O(n) - Stack depth

#pagebreak()

=== Fibonacci Numbers

*Định nghĩa:*
```
fib(n) = 0                        nếu n = 0
fib(n) = 1                        nếu n = 1
fib(n) = fib(n-1) + fib(n-2)      nếu n > 1
```

*Cây đệ quy cho fib(4):*

```
                    fib(4)
                   /      \
              fib(3)      fib(2)
             /     \      /     \
        fib(2)  fib(1) fib(1) fib(0)
        /    \
    fib(1) fib(0)
```

*Vấn đề: Tính toán lặp lại!*
- fib(2) được tính 2 lần
- fib(1) được tính 3 lần
- Với n lớn → Cực kỳ chậm!

*Phân tích số lần gọi:*

#table(
  columns: (1fr, 1fr, 1.5fr),
  align: (left, center, left),
  [*n*], [*Số lần gọi*], [*Thời gian*],
  [10], [177], [< 1 giây],
  [20], [21,891], [< 1 giây],
  [30], [2,692,573], [~7 giây],
  [40], [331,160,281], [~13 phút],
  [50], [~12 tỷ], [Vài giờ!],
)

*Complexity:*
- Time: O(2ⁿ) - Exponential!
- Space: O(n) - Stack depth

*Fibonacci đệ quy thuần túy rất chậm!*

Giải pháp:
- *Memoization:* Lưu kết quả đã tính → O(n)
- *Iteration:* Dùng vòng lặp → O(n), space O(1)
- *Matrix exponentiation:* O(log n)

#pagebreak()

=== Towers of Hanoi (Tháp Hà Nội)

*Bài toán:*
- 3 cột: Source (A), Auxiliary (B), Destination (C)
- n đĩa xếp từ nhỏ đến lớn trên cột A
- Mục tiêu: Chuyển tất cả sang cột C
- Quy tắc:
  - Một lần chỉ di chuyển 1 đĩa
  - Đĩa lớn không được đè lên đĩa nhỏ

*Ý tưởng đệ quy:*

Để di chuyển n đĩa từ A → C (dùng B):
1. Di chuyển (n-1) đĩa trên cùng từ A → B (dùng C)
2. Di chuyển đĩa lớn nhất từ A → C
3. Di chuyển (n-1) đĩa từ B → C (dùng A)

*Pseudocode:*
```
Algorithm move(disks, source, destination, auxiliary)
Pre: disks >= 1
Post: steps printed

if disks = 1 then
    print("Move from", source, "to", destination)
else
    move(disks-1, source, auxiliary, destination)
    move(1, source, destination, auxiliary)
    move(disks-1, auxiliary, destination, source)
end
End move
```

*Recurrence Equation:*
```
T(n) = 1 + 2T(n-1)

Giải:
T(n) = 1 + 2T(n-1)
     = 1 + 2[1 + 2T(n-2)]
     = 1 + 2 + 4T(n-2)
     = 1 + 2 + 4 + 8T(n-3)
     = ...
     = 1 + 2 + 4 + ... + 2^(n-1)
     = 2^n - 1
```

*Complexity:*
- Time: O(2ⁿ) - Exponential
- Space: O(n) - Stack depth

*Ý nghĩa:*
- Số bước tối thiểu = 2ⁿ - 1
- Với 64 đĩa: 2⁶⁴ - 1 ≈ 1.8 × 10¹⁹ bước
- Nếu 1 bước/giây → Mất 500 tỷ năm!

#pagebreak()

=== GCD - Euclidean Algorithm (Ước số chung lớn nhất)

*Định nghĩa:*
```
gcd(a, b) = a                  nếu b = 0
gcd(a, b) = b                  nếu a = 0
gcd(a, b) = gcd(b, a mod b)    nếu a, b > 0
```

*Ví dụ: gcd(48, 18)*
```
gcd(48, 18)
= gcd(18, 48 mod 18)
= gcd(18, 12)
= gcd(12, 18 mod 12)
= gcd(12, 6)
= gcd(6, 12 mod 6)
= gcd(6, 0)
= 6
```

*Pseudocode:*
```
Algorithm gcd(a, b)
Pre: a, b >= 0
Post: GCD of a and b returned

if b = 0 then
    return a
end
if a = 0 then
    return b
end
return gcd(b, a mod b)
End gcd
```

*Complexity:*
- Time: O(log n) - n là số nhỏ hơn trong (a, b)
- Space: O(log n) - Stack depth

#pagebreak()

== Minh họa từng bước

=== Factorial(3) - Chi tiết

```
Call: factorial(3)

Step 1: factorial(3) được gọi
        n = 3, không phải base case
        return 3 * factorial(2)
        → Gọi factorial(2)

Step 2: factorial(2) được gọi
        n = 2, không phải base case
        return 2 * factorial(1)
        → Gọi factorial(1)

Step 3: factorial(1) được gọi
        n = 1, không phải base case
        return 1 * factorial(0)
        → Gọi factorial(0)

Step 4: factorial(0) được gọi
        n = 0, BASE CASE!
        return 1

Return process (unwinding):

Step 5: factorial(0) returns 1
        factorial(1) = 1 * 1 = 1

Step 6: factorial(1) returns 1
        factorial(2) = 2 * 1 = 2

Step 7: factorial(2) returns 2
        factorial(3) = 3 * 2 = 6

Final result: 6
```

*Visualization:*

```
factorial(3)              Stack:
    |                     [3]
    ├─> 3 *               [3, 2]
    |       factorial(2)  [3, 2, 1]
    |           |         [3, 2, 1, 0]
    |           ├─> 2 *
    |           |       factorial(1)
    |           |           |
    |           |           ├─> 1 *
    |           |           |       factorial(0)
    |           |           |           |
    |           |           |           └─> return 1
    |           |           └─> return 1
    |           └─> return 2
    └─> return 6
```

#pagebreak()

=== Towers of Hanoi với 3 đĩa

```
Initial:        Goal:
  |               |
 [1]              |
 [2]              |
 [3]             [3]
─────           ─────
  A    B    C     A    B    C

move(3, A, C, B):

1. move(2, A, B, C) - Chuyển 2 đĩa trên từ A → B
   a. move(1, A, C, B) → Move A → C
      A: [2][3]  B: []      C: [1]
   
   b. move(1, A, B, C) → Move A → B
      A: [3]     B: [2]     C: [1]
   
   c. move(1, C, B, A) → Move C → B
      A: [3]     B: [1][2]  C: []

2. move(1, A, C, B) - Chuyển đĩa lớn nhất A → C
   A: []      B: [1][2]  C: [3]

3. move(2, B, C, A) - Chuyển 2 đĩa từ B → C
   a. move(1, B, A, C) → Move B → A
      A: [1]     B: [2]     C: [3]
   
   b. move(1, B, C, A) → Move B → C
      A: [1]     B: []      C: [2][3]
   
   c. move(1, A, C, B) → Move A → C
      A: []      B: []      C: [1][2][3]

Done! Tổng: 2³ - 1 = 7 bước
```

#pagebreak()

== Code minh họa bằng C++

=== Factorial - Đệ quy vs Iteration

*Recursive version:*
```cpp
#include <iostream>
using namespace std;

long recursiveFactorial(int n) {
    // Base case
    if (n == 0) {
        return 1;
    }
    // General case
    return n * recursiveFactorial(n - 1);
}

int main() {
    int n = 5;
    cout << "Factorial of " << n << " = " 
         << recursiveFactorial(n) << endl;
    return 0;
}
```

*Iterative version:*
```cpp
long iterativeFactorial(int n) {
    long result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}
```

*Output:*
```
Factorial of 5 = 120
```

#pagebreak()

=== Fibonacci - Đệ quy (Naive)

```cpp
#include <iostream>
using namespace std;

long fib(int n) {
    // Base cases
    if (n == 0 || n == 1) {
        return n;
    }
    // General case
    return fib(n - 1) + fib(n - 2);
}

int main() {
    int n = 10;
    cout << "Fibonacci(" << n << ") = " << fib(n) << endl;
    
    // Đo thời gian cho các giá trị khác nhau
    for (int i = 1; i <= 40; i++) {
        cout << "fib(" << i << ") = " << fib(i) << endl;
    }
    
    return 0;
}
```

*Vấn đề:* Với n > 40, chương trình chạy rất chậm!

#pagebreak()

=== Fibonacci - Tối ưu với Memoization

```cpp
#include <iostream>
#include <vector>
using namespace std;

vector<long> memo;

long fibMemo(int n) {
    // Đã tính rồi → Trả về luôn
    if (memo[n] != -1) {
        return memo[n];
    }
    
    // Base cases
    if (n == 0 || n == 1) {
        memo[n] = n;
        return n;
    }
    
    // Tính và lưu kết quả
    memo[n] = fibMemo(n - 1) + fibMemo(n - 2);
    return memo[n];
}

int main() {
    int n = 50;
    memo.resize(n + 1, -1);  // Khởi tạo memo với -1
    
    cout << "Fibonacci(" << n << ") = " << fibMemo(n) << endl;
    
    return 0;
}
```

*Kết quả:* Fibonacci(50) chạy gần như tức thì! (thay vì hàng giờ)

#pagebreak()

=== Towers of Hanoi

```cpp
#include <iostream>
using namespace std;

void move(int n, char source, char destination, char auxiliary) {
    static int step = 0;  // Đếm số bước
    
    if (n == 1) {
        // Base case: Chỉ có 1 đĩa → Di chuyển trực tiếp
        cout << "Step " << ++step << ": Move from " 
             << source << " to " << destination << endl;
    } else {
        // General case
        // 1. Chuyển (n-1) đĩa từ source → auxiliary (dùng destination)
        move(n - 1, source, auxiliary, destination);
        
        // 2. Chuyển đĩa lớn nhất từ source → destination
        move(1, source, destination, auxiliary);
        
        // 3. Chuyển (n-1) đĩa từ auxiliary → destination (dùng source)
        move(n - 1, auxiliary, destination, source);
    }
}

int main() {
    int numDisks;
    cout << "Enter number of disks: ";
    cin >> numDisks;
    
    cout << "\nSolving Towers of Hanoi with " << numDisks << " disks:\n";
    move(numDisks, 'A', 'C', 'B');
    
    return 0;
}
```

*Output (với 3 đĩa):*
```
Enter number of disks: 3

Solving Towers of Hanoi with 3 disks:
Step 1: Move from A to C
Step 2: Move from A to B
Step 3: Move from C to B
Step 4: Move from A to C
Step 5: Move from B to A
Step 6: Move from B to C
Step 7: Move from A to C
```

#pagebreak()

=== GCD (Euclidean Algorithm)

```cpp
#include <iostream>
using namespace std;

int gcd(int a, int b) {
    // Base cases
    if (b == 0) return a;
    if (a == 0) return b;
    
    // General case
    return gcd(b, a % b);
}

int main() {
    int a = 48, b = 18;
    cout << "GCD of " << a << " and " << b << " = " 
         << gcd(a, b) << endl;
    
    // Test với các giá trị khác
    cout << "GCD(100, 35) = " << gcd(100, 35) << endl;
    cout << "GCD(17, 19) = " << gcd(17, 19) << endl;  // Số nguyên tố cùng nhau
    
    return 0;
}
```

*Output:*
```
GCD of 48 and 18 = 6
GCD(100, 35) = 5
GCD(17, 19) = 1
```

#pagebreak()

=== Print Linked List in Reverse (Đệ quy)

```cpp
#include <iostream>
using namespace std;

struct Node {
    int data;
    Node* next;
};

void printReverse(Node* head) {
    // Base case: Danh sách rỗng
    if (head == NULL) {
        return;
    }
    
    // General case:
    // 1. In phần còn lại (đệ quy)
    printReverse(head->next);
    
    // 2. In node hiện tại (sau khi đệ quy return)
    cout << head->data << " ";
}

void printForward(Node* head) {
    if (head == NULL) return;
    cout << head->data << " ";
    printForward(head->next);
}

int main() {
    // Tạo linked list: 1 → 2 → 3 → 4
    Node* head = new Node{1, nullptr};
    head->next = new Node{2, nullptr};
    head->next->next = new Node{3, nullptr};
    head->next->next->next = new Node{4, nullptr};
    
    cout << "Forward: ";
    printForward(head);
    cout << endl;
    
    cout << "Reverse: ";
    printReverse(head);
    cout << endl;
    
    return 0;
}
```

*Output:*
```
Forward: 1 2 3 4
Reverse: 4 3 2 1
```

#pagebreak()

== Những lỗi phổ biến khi code

*1. Thiếu Base Case → Stack Overflow:*

```cpp
// ❌ SAI: Không có base case
int factorial(int n) {
    return n * factorial(n - 1);  // Lỗi: Đệ quy vô tận!
}

// ✅ ĐÚNG: Có base case
int factorial(int n) {
    if (n == 0) return 1;  // Base case
    return n * factorial(n - 1);
}
```

*2. Base Case sai:*

```cpp
// ❌ SAI: Base case n == 1, nhưng factorial(0) sẽ lỗi
int factorial(int n) {
    if (n == 1) return 1;  // Thiếu n == 0
    return n * factorial(n - 1);
}

// ✅ ĐÚNG
int factorial(int n) {
    if (n == 0 || n == 1) return 1;
    return n * factorial(n - 1);
}
```

*3. Không tiến về Base Case:*

```cpp
// ❌ SAI: factorial(n) gọi factorial(n+1) → Không bao giờ đến base case
int factorial(int n) {
    if (n == 0) return 1;
    return n * factorial(n + 1);  // Sai: n+1 thay vì n-1!
}

// ✅ ĐÚNG: Giảm n mỗi lần
int factorial(int n) {
    if (n == 0) return 1;
    return n * factorial(n - 1);  // n-1 tiến về 0
}
```

*4. Quên kiểm tra input âm:*

```cpp
// ❌ SAI: Không kiểm tra n < 0
int factorial(int n) {
    if (n == 0) return 1;
    return n * factorial(n - 1);  // n < 0 sẽ lỗi!
}

// ✅ ĐÚNG: Kiểm tra input
int factorial(int n) {
    if (n < 0) return -1;  // Lỗi: factorial không định nghĩa cho số âm
    if (n == 0) return 1;
    return n * factorial(n - 1);
}
```

*5. Stack Overflow với input lớn:*

```cpp
// ❌ VẤN ĐỀ: Với n rất lớn (vd: n = 100000), stack overflow
int sum(int n) {
    if (n == 0) return 0;
    return n + sum(n - 1);
}

// ✅ GIẢI PHÁP: Dùng iteration cho bài toán đơn giản
int sum(int n) {
    int result = 0;
    for (int i = 1; i <= n; i++) {
        result += i;
    }
    return result;  // Hoặc dùng công thức: n * (n + 1) / 2
}
```

*6. Fibonacci không tối ưu:*

```cpp
// ❌ RẤT CHẬM: O(2^n)
long fib(int n) {
    if (n <= 1) return n;
    return fib(n-1) + fib(n-2);  // Tính lại nhiều lần!
}

// ✅ TỐI ƯU: Dùng memoization hoặc iteration
```

#pagebreak()

== Khi nào nên dùng / không nên dùng

=== Khi nào dùng Đệ quy?

#table(
  columns: (2fr, 3fr),
  align: (left, left),
  [*Tình huống*], [*Lý do*],
  [Cấu trúc dữ liệu đệ quy], [Tree, Graph, Linked List có bản chất đệ quy],
  [Divide & Conquer], [Merge Sort, Quick Sort, Binary Search],
  [Backtracking], [N-Queens, Sudoku, Maze solving],
  [Mathematical problems], [Factorial, Fibonacci, GCD, Towers of Hanoi],
  [Code ngắn gọn hơn nhiều], [10 dòng đệ quy vs 50 dòng iteration],
)

*Ví dụ tốt cho đệ quy:*
```cpp
// Tree traversal - Rất tự nhiên với đệ quy
void inorder(Node* root) {
    if (root == NULL) return;
    inorder(root->left);
    cout << root->data << " ";
    inorder(root->right);
}

// Nếu dùng iteration → Phức tạp hơn rất nhiều (cần stack tự quản lý)
```

=== Khi nào KHÔNG nên dùng Đệ quy?

#table(
  columns: (2fr, 3fr),
  align: (left, left),
  [*Tình huống*], [*Lý do*],
  [Bài toán đơn giản], [Iteration nhanh hơn, tiết kiệm bộ nhớ],
  [n rất lớn], [Stack overflow risk (n > 10000)],
  [Performance critical], [Overhead của function call],
  [Tính toán lặp lại nhiều], [Fibonacci thuần túy → O(2ⁿ) quá chậm],
)

*Ví dụ nên dùng Iteration:*
```cpp
// Tính tổng 1 → n: Đơn giản → Iteration tốt hơn
int sum(int n) {
    int result = 0;
    for (int i = 1; i <= n; i++) {
        result += i;
    }
    return result;
}

// Đệ quy: Dài hơn, chậm hơn, tốn bộ nhớ hơn
int sumRecursive(int n) {
    if (n == 0) return 0;
    return n + sumRecursive(n - 1);
}
```

=== So sánh Recursion vs Iteration

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  align: (left, left, left),
  [*Tiêu chí*], [*Recursion*], [*Iteration*],
  [*Code*], [Ngắn gọn, dễ hiểu], [Dài hơn, phức tạp hơn],
  [*Speed*], [Chậm hơn (function call overhead)], [Nhanh hơn],
  [*Memory*], [O(n) stack space], [O(1) - Chỉ vài biến],
  [*Risk*], [Stack overflow với n lớn], [An toàn hơn],
  [*Sử dụng*], [Tree, Graph, Divide & Conquer], [Simple loops, large n],
)

#pagebreak()

== Ứng dụng thực tế

*1. File System (Hệ thống file):*

Duyệt thư mục và tất cả thư mục con:

```cpp
void listFiles(string path) {
    // Base case: path is a file
    if (isFile(path)) {
        cout << path << endl;
        return;
    }
    
    // General case: path is a directory
    for (auto& entry : listDirectory(path)) {
        listFiles(path + "/" + entry);  // Đệ quy
    }
}
```

*Trong Windows Explorer / Mac Finder:*
- Tìm kiếm file đệ quy qua tất cả thư mục con
- Tính tổng dung lượng thư mục

*2. Compiler (Trình biên dịch):*

*Parsing expressions (Phân tích biểu thức):*

```
Expression: 3 + 4 * 2

Parse Tree (đệ quy):
       +
      / \
     3   *
        / \
       4   2
```

*Đánh giá biểu thức:*
```cpp
int evaluate(Node* root) {
    if (root->isNumber()) {
        return root->value;
    }
    int left = evaluate(root->left);
    int right = evaluate(root->right);
    return apply(root->op, left, right);
}
```

*3. Game Development:*

*Minimax Algorithm (Game AI):*

Cờ vua, cờ ca rô: Tìm nước đi tốt nhất

```cpp
int minimax(Board board, int depth, bool isMax) {
    if (depth == 0 || gameOver(board)) {
        return evaluate(board);
    }
    
    if (isMax) {
        int maxEval = -INFINITY;
        for (auto& move : possibleMoves(board)) {
            int eval = minimax(makeMove(board, move), depth-1, false);
            maxEval = max(maxEval, eval);
        }
        return maxEval;
    } else {
        // Similar for MIN player
    }
}
```

*4. Web Crawling:*

Google Bot, Facebook Crawler:

```cpp
void crawl(string url, int depth) {
    if (depth == 0 || visited(url)) return;
    
    markVisited(url);
    processPage(url);
    
    for (auto& link : getLinks(url)) {
        crawl(link, depth - 1);  // Đệ quy crawl các link
    }
}
```

*5. JSON / XML Parsing:*

```json
{
    "name": "John",
    "address": {
        "city": "NYC",
        "zip": {
            "code": "10001"
        }
    }
}
```

Đệ quy để parse nested objects:
```cpp
void parseJSON(JSONObject obj) {
    for (auto& [key, value] : obj) {
        if (value.isObject()) {
            parseJSON(value);  // Đệ quy
        } else {
            cout << key << ": " << value << endl;
        }
    }
}
```

#pagebreak()

== Tóm tắt chương

*Những điểm quan trọng nhất cần nhớ:*

1. *Đệ quy* là hàm gọi chính nó để giải bài toán nhỏ hơn.

2. *Hai thành phần bắt buộc:*
   - *Base Case:* Điều kiện dừng (không đệ quy)
   - *General Case:* Gọi đệ quy với bài toán nhỏ hơn

3. *Quy tắc vàng:*
   - Mỗi lần đệ quy phải tiến gần hơn đến Base Case
   - Nếu không → Stack Overflow!

4. *Recursion vs Iteration:*
   - Recursion: Ngắn gọn, dễ hiểu, tốn bộ nhớ
   - Iteration: Nhanh hơn, tiết kiệm bộ nhớ

5. *Các ví dụ kinh điển:*
   - Factorial: O(n) time, O(n) space
   - Fibonacci (naive): O(2ⁿ) - RẤT CHẬM!
   - Fibonacci (memoization): O(n) - Nhanh!
   - Towers of Hanoi: O(2ⁿ) - Exponential
   - GCD (Euclidean): O(log n) - Rất nhanh
   - Binary Search: O(log n)

6. *Backtracking:*
   - Thử các khả năng, quay lui nếu sai
   - N-Queens, Sudoku, Maze

7. *Khi nào dùng đệ quy:*
   - Tree, Graph traversal
   - Divide & Conquer (Merge Sort, Quick Sort)
   - Backtracking problems
   - Code ngắn gọn hơn nhiều so với iteration

8. *Khi nào KHÔNG dùng:*
   - Bài toán đơn giản (sum, factorial...)
   - n rất lớn (risk stack overflow)
   - Performance critical
   - Tính toán lặp lại (Fibonacci naive)

9. *Tối ưu đệ quy:*
   - *Memoization:* Lưu kết quả đã tính
   - *Tail recursion:* Một số compiler tối ưu thành iteration
   - Chuyển sang iteration nếu cần

10. *Call Stack:*
    - Mỗi lần gọi hàm → Push vào stack
    - Return → Pop khỏi stack
    - Stack có giới hạn → Quá nhiều đệ quy → Stack Overflow

#pagebreak()
