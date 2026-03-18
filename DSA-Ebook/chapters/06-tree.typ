#import "../components/template.typ": *

= Cây (Tree)

== Tổng quan chương

=== Nội dung chính của chương

Tree là cấu trúc dữ liệu phi tuyến tính (non-linear), có tính phân cấp (hierarchical), là nền tảng cho nhiều cấu trúc dữ liệu và thuật toán phức tạp.

Chương này sẽ giúp bạn nắm vững:

1. *Basic Tree Concepts:*
   - Định nghĩa Tree
   - Các thuật ngữ: Root, Leaf, Parent, Child, Sibling, Height, Depth
   - Properties của Tree

2. *Binary Tree:*
   - Định nghĩa và tính chất
   - Complete Tree, Balanced Tree
   - Array vs Linked implementation

3. *Tree Traversals:*
   - Depth-First: Preorder, Inorder, Postorder
   - Breadth-First (Level-order)

4. *Expression Trees:*
   - Biểu diễn biểu thức toán học
   - Infix, Prefix, Postfix notation

5. *Binary Search Tree (BST):*
   - Properties
   - Search, Insert, Delete operations
   - Complexity analysis

=== Kiến thức nền cần biết trước

- Recursion (Chapter 3)
- Linked List (Chapter 4)
- Queue (Chapter 5)
- Pointers và Dynamic memory allocation

#pagebreak()

== Giải thích từng khái niệm

=== Tree (Cây)

*WHAT - Cây là gì?*

*Tree* là một tập hợp hữu hạn các *nodes* (đỉnh) được kết nối bởi các *branches* (cạnh), trong đó:

- Có một node đặc biệt gọi là *root* (gốc)
- Mọi node khác đều có đúng một parent (cha)
- Không có chu trình (cycle)

*Minh họa:*
```
          a         ← Root
        / | \
       b  c  d      ← Level 1
      / \     |\  \
     e   f   g h  i ← Level 2 (Leaves)
```

*Các thuật ngữ quan trọng:*

#table(
  columns: (1.2fr, 2fr),
  align: (left, left),
  [*Thuật ngữ*], [*Định nghĩa*],
  [Root], [Node đầu tiên, không có parent. Indegree = 0],
  [Leaf], [Node không có child. Outdegree = 0],
  [Internal node], [Node không phải root hoặc leaf],
  [Parent], [Node có outdegree > 0],
  [Child], [Node có indegree = 1],
  [Siblings], [Các nodes có cùng parent],
  [Ancestors], [Tất cả nodes từ root đến node hiện tại],
  [Descendants], [Tất cả nodes từ node hiện tại đến leaves],
  [Path], [Chuỗi nodes liên tiếp từ node này đến node khác],
  [Level], [Khoảng cách từ root (root ở level 0)],
  [Height], [Level của leaf sâu nhất + 1],
  [Degree], [Số children của một node],
  [Subtree], [Bất kỳ node nào và tất cả descendants của nó],
)

*Ví dụ với tree trên:*
- Root: a
- Leaves: c, e, f, g, h, i
- Internal nodes: b, d
- Siblings: {b, c, d}, {e, f}, {g, h, i}
- Height = 3
- Parent of e: b
- Children of d: g, h, i

*Tại sao cần Tree?*

1. *Biểu diễn dữ liệu phân cấp:*
   - File system: Folders chứa subfolders và files
   - Organization chart: CEO → Managers → Employees
   - DOM tree: HTML elements lồng nhau

2. *Search hiệu quả:*
   - Binary Search Tree: O(log n) search
   - Nhanh hơn nhiều so với linear search O(n)

3. *Lưu trữ sorted data:*
   - BST inorder traversal → sorted list

4. *Routing algorithms:*
   - Network routing
   - Decision trees trong AI

*Tree hoạt động thế nào trong máy tính?*

Có 2 cách triển khai chính:

1. *Linked Representation:*
```
struct Node {
    int data;
    Node* children[];  // Mảng con trỏ tới children
};
```

2. *Array Representation (cho Complete Tree):*
```
array[i] → Node i
Parent of i: (i-1)/2
Left child of i: 2i+1
Right child of i: 2i+2
```

#pagebreak()

=== Binary Tree (Cây nhị phân)

*WHAT - Binary Tree*

*Binary Tree* là tree mà mỗi node có *tối đa 2 children*:
- Left child (con trái)
- Right child (con phải)

Định nghĩa đệ quy:
- Binary tree rỗng, hoặc
- Có root + left subtree (BT) + right subtree (BT)

*Minh họa:*
```
        a
       / \
      b   d
     / \   \
    e   f   g
```

*Properties của Binary Tree:*

Với N nodes, height H:

#table(
  columns: (1.5fr, 1.5fr),
  align: (left, left),
  [*Tính chất*], [*Công thức*],
  [Min height], [$H_"min" = ⌊log_2 N⌋ + 1$],
  [Max height], [$H_"max" = N$],
  [Min nodes (given H)], [$N_"min" = H$],
  [Max nodes (given H)], [$N_"max" = 2^H - 1$],
)

*Các loại Binary Tree đặc biệt:*

1. *Complete Binary Tree:*
   - Tất cả levels đầy, trừ level cuối
   - Level cuối: Nodes fill từ trái sang
   ```
         a
       /   \
      b     c
     / \   /
    d   e f
   ```

2. *Full Binary Tree (Perfect):*
   - Tất cả levels đầy
   - Số nodes: $N = 2^H - 1$
   ```
         a
       /   \
      b     c
     / \   / \
    d   e f   g
   ```

3. *Balanced Binary Tree:*
   - Độ chênh lệch height giữa left và right subtree ≤ 1
   - Balance Factor: BF = Height(left) - Height(right)
   - BF ∈ {-1, 0, 1}

*Implementation:*

1. *Linked Implementation:*
```cpp
struct Node {
    int data;
    Node* left;
    Node* right;
};

struct BinaryTree {
    Node* root;
};
```

2. *Array Implementation (cho Complete Tree):*
```cpp
int tree[MAX_SIZE];
// Parent của i: (i-1)/2
// Left của i: 2i+1
// Right của i: 2i+2
```

#pagebreak()

=== Tree Traversals (Duyệt cây)

*WHAT - Traversal*

*Tree Traversal* là quá trình visit mỗi node trong tree đúng một lần theo một thứ tự nhất định.

2 loại chính:
- *Depth-First Traversal*: Đi sâu trước
- *Breadth-First Traversal*: Đi rộng trước (level-by-level)

*Depth-First Traversals:*

1. *Preorder (NLR - Node-Left-Right):*
   - Process node
   - Traverse left subtree
   - Traverse right subtree
   ```
   Algorithm preorder(root):
       if root ≠ null:
           visit(root)
           preorder(root.left)
           preorder(root.right)
   ```

2. *Inorder (LNR - Left-Node-Right):*
   - Traverse left subtree
   - Process node
   - Traverse right subtree
   ```
   Algorithm inorder(root):
       if root ≠ null:
           inorder(root.left)
           visit(root)
           inorder(root.right)
   ```

3. *Postorder (LRN - Left-Right-Node):*
   - Traverse left subtree
   - Traverse right subtree
   - Process node
   ```
   Algorithm postorder(root):
       if root ≠ null:
           postorder(root.left)
           postorder(root.right)
           visit(root)
   ```

*Ví dụ với tree:*
```
      1
     / \
    2   3
   / \
  4   5
```
- Preorder: 1, 2, 4, 5, 3
- Inorder: 4, 2, 5, 1, 3
- Postorder: 4, 5, 2, 3, 1

*Breadth-First (Level-order):*
- Duyệt từng level từ trái sang phải
- Dùng Queue
```
Algorithm levelorder(root):
    queue = createQueue()
    enqueue(queue, root)
    while not empty(queue):
        node = dequeue(queue)
        visit(node)
        if node.left ≠ null: enqueue(queue, node.left)
        if node.right ≠ null: enqueue(queue, node.right)
```
- Kết quả: 1, 2, 3, 4, 5

#pagebreak()

=== Binary Search Tree (BST)

*WHAT - BST*

*Binary Search Tree* là Binary Tree với tính chất:

1. Tất cả nodes trong *left subtree < root*
2. Tất cả nodes trong *right subtree ≥ root*
3. Mỗi subtree cũng là BST (đệ quy)

*Ví dụ BST:*
```
        23
       /  \
     18    44
    / \    / \
  12  20  35  52
```

*Valid:* 12 < 18 < 20 < 23 < 35 < 44 < 52

*Invalid BST:*
```
      10
     /  \
    5    15
   / \
  2   20  ← SAI: 20 > 10 nhưng ở left subtree!
```

*Tính chất quan trọng:*
- *Inorder traversal của BST → Sorted list!*
- BST kết hợp ưu điểm:
  - Binary search (O(log n) search)
  - Linked list (O(1) insert/delete nếu biết vị trí)

*Tại sao BST quan trọng?*

1. *Fast search:* O(log n) average, O(h) với h = height
2. *Dynamic:* Dễ dàng insert/delete
3. *Sorted order:* Inorder traversal → sorted
4. *Range queries:* Tìm tất cả phần tử trong [x, y] hiệu quả

#pagebreak()

== Bản chất trong máy tính

=== Memory Layout của Binary Tree

*Linked Representation:*

```
Binary Tree:
        10
       /  \
      5    15

Memory:
┌─────────────────────┐
│ Node (root): 10     │ 0x1000
│ left: 0x2000        │
│ right: 0x3000       │
├─────────────────────┤
│ Node: 5             │ 0x2000
│ left: NULL          │
│ right: NULL         │
├─────────────────────┤
│ Node: 15            │ 0x3000
│ left: NULL          │
│ right: NULL         │
└─────────────────────┘
```

Nodes rải rác trong heap, kết nối bởi pointers.

*Array Representation:*

```
Binary Tree:       Array:
      0           [0, 1, 2, 3, 4, 5, 6]
     / \
    1   2
   / \  /
  3  4 5

array[0] = root
array[1] = left(0)
array[2] = right(0)
array[3] = left(1)
array[4] = right(1)
array[5] = left(2)
```

*Space efficiency:*
- Linked: O(n) nodes + O(n) pointers = O(2n) ≈ O(n)
- Array (Complete Tree): O(n) - No pointers!
- Array (Sparse Tree): Lãng phí space cho NULL nodes

#pagebreak()

=== Recursion trong Tree Operations

Tree operations thường dùng recursion vì tree có cấu trúc đệ quy tự nhiên:

```cpp
int height(Node* root) {
    if (root == NULL) return 0;  // Base case
    
    // Recursive case
    int leftHeight = height(root->left);
    int rightHeight = height(root->right);
    
    return 1 + max(leftHeight, rightHeight);
}
```

*Call Stack cho tree:*
```
        1
       / \
      2   3

height(1):
  height(2):
    height(4): return 1
    height(5): return 1
    return 2
  height(3): return 1
  return 3
```

#pagebreak()

== Lịch sử / Nguồn gốc

=== Lịch sử của Tree Structure

*1950s: Khởi đầu*
- Trees được dùng trong compilers (syntax trees)
- Expression trees cho mathematical expressions

*1960: Binary Search Trees*
- P.F. Windley, A.D. Booth đề xuất BST
- Đột phá: Kết hợp binary search và linked list

*1962: AVL Trees*
- Adelson-Velsky và Landis phát minh AVL tree
- First self-balancing BST
- Đảm bảo O(log n) worst-case

*1970: B-Trees*
- Rudolf Bayer và Ed McCreight (Boeing)
- Multi-way search trees cho databases
- Tối ưu cho disk I/O

*1972: Red-Black Trees*
- Rudolf Bayer
- Dùng trong C++ STL `std::map`, `std::set`

*Ngày nay:*
- Trees everywhere: File systems, databases, compilers, AI
- Advanced variants: Splay trees, Treaps, Segment trees

=== Tại sao Trees ra đời?

*Vấn đề với Array và Linked List:*
- Array: Fast search O(log n) nhưng slow insert/delete O(n)
- Linked List: Fast insert/delete O(1) nhưng slow search O(n)

*Giải pháp: Binary Search Tree*
- Search: O(log n) - Gần như array
- Insert/Delete: O(log n) - Tốt hơn array nhiều

*Nhưng còn vấn đề:* BST có thể unbalanced → O(n) worst case

*Giải pháp: Self-balancing trees (AVL, Red-Black)*
- Đảm bảo O(log n) mọi trường hợp

#pagebreak()

== Phân tích thuật toán

=== BST Search

```
Algorithm searchBST(root, target):
    if root == NULL:
        return NULL
    
    if target == root.data:
        return root
    else if target < root.data:
        return searchBST(root.left, target)
    else:
        return searchBST(root.right, target)
```

*Phân tích:*
- Mỗi lần so sánh loại đi một nửa tree (như binary search)
- Số bước tối đa = height của tree

*Time Complexity:* Best: O(1) - target = root, Average: O(log n) - balanced tree, Worst: O(n) - skewed tree (như linked list)

*Space Complexity:* O(h) - recursion stack, h = height

*Skewed Tree (worst case):*
```
1
 \
  2
   \
    3
     \
      4  → height = 4, search = O(4) = O(n)
```

*Balanced Tree (best case):*
```
      2
     / \
    1   3
         \
          4  → height = 3, search = O(log 4) ≈ O(2)
```

=== BST Insert

```
Algorithm insertBST(root, value):
    if root == NULL:
        return createNode(value)
    
    if value < root.data:
        root.left = insertBST(root.left, value)
    else:
        root.right = insertBST(root.right, value)
    
    return root
```

*Complexity:*
- Time: Best: O(log n) - balanced, Worst: O(n) - skewed
- Space: O(h) recursion

*Insert luôn diễn ra ở leaf hoặc near-leaf position!*

=== BST Delete

*3 trường hợp:*

1. *Delete leaf:* Đơn giản, set parent pointer = NULL
2. *Delete node with 1 child:* Replace node bằng child
3. *Delete node with 2 children:* 
   - Tìm inorder predecessor (max của left subtree)
   - Hoặc inorder successor (min của right subtree)
   - Replace data, delete predecessor/successor

*Time Complexity:* O(h) - phải traverse để tìm node và predecessor/successor

*Space Complexity:* O(h) recursion

=== Tree Traversals

*Time Complexity:* O(n) - visit mỗi node đúng 1 lần

*Space Complexity:* Depth-First: O(h) recursion stack, Breadth-First: O(w) queue, w = max width

#pagebreak()

== Minh họa từng bước

=== BST Insert

Insert: 50, 30, 70, 20, 40, 60, 80

```
Step 1: Insert 50
    50

Step 2: Insert 30 (30 < 50 → left)
    50
   /
  30

Step 3: Insert 70 (70 > 50 → right)
    50
   /  \
  30   70

Step 4: Insert 20 (20 < 50 → left, 20 < 30 → left)
      50
     /  \
   30    70
  /
 20

Step 5: Insert 40 (40 < 50 → left, 40 > 30 → right)
      50
     /  \
   30    70
  /  \
 20   40

Steps 6-7: Insert 60, 80
        50
       /  \
     30    70
    / \    / \
  20  40  60  80
```

=== BST Delete node with 2 children

Delete 50 from above tree:

```
Initial:
        50 ← Delete this
       /  \
     30    70
    / \    / \
  20  40  60  80

Step 1: Find inorder predecessor (max of left subtree)
        → 40 is the largest in left subtree

Step 2: Replace 50 with 40
        40
       /  \
     30    70
    / \    / \
  20  ??  60  80

Step 3: Delete original 40 (leaf node)
        40
       /  \
     30    70
    /     / \
  20     60  80
```

=== Traversals

Tree:
```
      1
     / \
    2   3
   / \
  4   5
```

*Preorder (NLR):*
```
Visit 1 → Visit 2 → Visit 4 → Visit 5 → Visit 3
Result: 1, 2, 4, 5, 3
```

*Inorder (LNR):*
```
Visit 4 → Visit 2 → Visit 5 → Visit 1 → Visit 3
Result: 4, 2, 5, 1, 3
```

*Postorder (LRN):*
```
Visit 4 → Visit 5 → Visit 2 → Visit 3 → Visit 1
Result: 4, 5, 2, 3, 1
```

*Level-order:*
```
Level 0: 1
Level 1: 2, 3
Level 2: 4, 5
Result: 1, 2, 3, 4, 5
```

#pagebreak()

== Code minh họa bằng C++

=== Binary Tree Node Structure

```cpp
#include <iostream>
#include <queue>
using namespace std;

struct Node {
    int data;
    Node* left;
    Node* right;
    
    Node(int val) : data(val), left(nullptr), right(nullptr) {}
};
```

=== Binary Search Tree - Complete Implementation

```cpp
class BST {
private:
    Node* root;
    
    // Helper: Insert recursively
    Node* insertRec(Node* node, int value) {
        if (node == nullptr) {
            return new Node(value);
        }
        
        if (value < node->data) {
            node->left = insertRec(node->left, value);
        } else {
            node->right = insertRec(node->right, value);
        }
        
        return node;
    }
    
    // Helper: Search recursively
    Node* searchRec(Node* node, int value) {
        if (node == nullptr || node->data == value) {
            return node;
        }
        
        if (value < node->data) {
            return searchRec(node->left, value);
        } else {
            return searchRec(node->right, value);
        }
    }
    
    // Helper: Find minimum node
    Node* findMin(Node* node) {
        while (node->left != nullptr) {
            node = node->left;
        }
        return node;
    }
    
    // Helper: Delete recursively
    Node* deleteRec(Node* node, int value) {
        if (node == nullptr) return nullptr;
        
        if (value < node->data) {
            node->left = deleteRec(node->left, value);
        } else if (value > node->data) {
            node->right = deleteRec(node->right, value);
        } else {
            // Found node to delete
            
            // Case 1: Leaf node
            if (node->left == nullptr && node->right == nullptr) {
                delete node;
                return nullptr;
            }
            
            // Case 2: One child
            if (node->left == nullptr) {
                Node* temp = node->right;
                delete node;
                return temp;
            }
            if (node->right == nullptr) {
                Node* temp = node->left;
                delete node;
                return temp;
            }
            
            // Case 3: Two children
            // Find inorder successor (min in right subtree)
            Node* successor = findMin(node->right);
            node->data = successor->data;
            node->right = deleteRec(node->right, successor->data);
        }
        
        return node;
    }
    
    // Helper: Inorder traversal
    void inorderRec(Node* node) {
        if (node == nullptr) return;
        inorderRec(node->left);
        cout << node->data << " ";
        inorderRec(node->right);
    }
    
    // Helper: Preorder traversal
    void preorderRec(Node* node) {
        if (node == nullptr) return;
        cout << node->data << " ";
        preorderRec(node->left);
        preorderRec(node->right);
    }
    
    // Helper: Postorder traversal
    void postorderRec(Node* node) {
        if (node == nullptr) return;
        postorderRec(node->left);
        postorderRec(node->right);
        cout << node->data << " ";
    }
    
    // Helper: Height
    int heightRec(Node* node) {
        if (node == nullptr) return 0;
        return 1 + max(heightRec(node->left), heightRec(node->right));
    }
    
public:
    BST() : root(nullptr) {}
    
    void insert(int value) {
        root = insertRec(root, value);
    }
    
    bool search(int value) {
        return searchRec(root, value) != nullptr;
    }
    
    void remove(int value) {
        root = deleteRec(root, value);
    }
    
    void inorder() {
        inorderRec(root);
        cout << endl;
    }
    
    void preorder() {
        preorderRec(root);
        cout << endl;
    }
    
    void postorder() {
        postorderRec(root);
        cout << endl;
    }
    
    // Level-order (Breadth-First)
    void levelOrder() {
        if (root == nullptr) return;
        
        queue<Node*> q;
        q.push(root);
        
        while (!q.empty()) {
            Node* current = q.front();
            q.pop();
            
            cout << current->data << " ";
            
            if (current->left) q.push(current->left);
            if (current->right) q.push(current->right);
        }
        cout << endl;
    }
    
    int height() {
        return heightRec(root);
    }
};

int main() {
    BST tree;
    
    // Insert nodes
    tree.insert(50);
    tree.insert(30);
    tree.insert(70);
    tree.insert(20);
    tree.insert(40);
    tree.insert(60);
    tree.insert(80);
    
    cout << "Inorder (sorted): ";
    tree.inorder();  // 20 30 40 50 60 70 80
    
    cout << "Preorder: ";
    tree.preorder();  // 50 30 20 40 70 60 80
    
    cout << "Postorder: ";
    tree.postorder();  // 20 40 30 60 80 70 50
    
    cout << "Level-order: ";
    tree.levelOrder();  // 50 30 70 20 40 60 80
    
    cout << "Height: " << tree.height() << endl;  // 3
    
    // Search
    cout << "Search 40: " << (tree.search(40) ? "Found" : "Not found") << endl;
    cout << "Search 100: " << (tree.search(100) ? "Found" : "Not found") << endl;
    
    // Delete
    tree.remove(50);
    cout << "After deleting 50: ";
    tree.inorder();  // 20 30 40 60 70 80
    
    return 0;
}
```

*Output:*
```
Inorder (sorted): 20 30 40 50 60 70 80
Preorder: 50 30 20 40 70 60 80
Postorder: 20 40 30 60 80 70 50
Level-order: 50 30 70 20 40 60 80
Height: 3
Search 40: Found
Search 100: Not found
After deleting 50: 20 30 40 60 70 80
```

#pagebreak()

== Những lỗi phổ biến khi code

*1. Memory Leak - Quên delete nodes*

```cpp
// ❌ SAI: Không giải phóng bộ nhớ
void deleteTree(Node* root) {
    if (root == nullptr) return;
    deleteTree(root->left);
    deleteTree(root->right);
    // Quên: delete root;
}

// ✅ ĐÚNG
void deleteTree(Node* root) {
    if (root == nullptr) return;
    deleteTree(root->left);
    deleteTree(root->right);
    delete root;  // Giải phóng node
}
```

*2. NULL Pointer Dereference*

```cpp
// ❌ SAI: Không kiểm tra NULL
int height(Node* root) {
    return 1 + max(height(root->left), height(root->right));
    // Crash khi root == NULL!
}

// ✅ ĐÚNG
int height(Node* root) {
    if (root == nullptr) return 0;  // Base case
    return 1 + max(height(root->left), height(root->right));
}
```

*3. Sai logic Delete với 2 children*

```cpp
// ❌ SAI: Quên delete successor node
Node* deleteNode(Node* root, int value) {
    // ...
    // Case 3: Two children
    Node* successor = findMin(root->right);
    root->data = successor->data;
    // Quên: root->right = deleteRec(root->right, successor->data);
    return root;  // Successor vẫn còn trong tree!
}

// ✅ ĐÚNG: Phải delete successor
root->right = deleteRec(root->right, successor->data);
```

*4. Infinite Recursion*

```cpp
// ❌ SAI: Không có base case
void inorder(Node* root) {
    inorder(root->left);   // Crash khi root == NULL
    cout << root->data;
    inorder(root->right);
}

// ✅ ĐÚNG
void inorder(Node* root) {
    if (root == nullptr) return;  // Base case
    inorder(root->left);
    cout << root->data << " ";
    inorder(root->right);
}
```

*5. Insert sai thứ tự BST*

```cpp
// ❌ SAI: Không maintain BST property
Node* insert(Node* root, int value) {
    if (root == nullptr) return new Node(value);
    root->left = insert(root->left, value);  // Luôn insert vào left!
    return root;
}

// ✅ ĐÚNG: So sánh value
Node* insert(Node* root, int value) {
    if (root == nullptr) return new Node(value);
    if (value < root->data) {
        root->left = insert(root->left, value);
    } else {
        root->right = insert(root->right, value);
    }
    return root;
}
```

#pagebreak()

== Khi nào nên dùng / không nên dùng

=== Khi nào dùng Binary Search Tree?

#table(
  columns: (1fr, 2fr),
  align: (left, left),
  [*Tình huống*], [*Lý do*],
  [Cần search + insert/delete], [O(log n) cho cả 3 operations (balanced)],
  [Dữ liệu động], [Dễ dàng thêm/xóa, không cần resize như array],
  [Cần sorted order], [Inorder traversal → sorted list],
  [Range queries], [Tìm tất cả x trong [a, b] hiệu quả],
  [Priority queue (nâng cao)], [Với some modifications],
)

*Ví dụ ứng dụng:*
```cpp
// Dictionary với fast search
BST<string, string> dictionary;
dictionary.insert("apple", "a fruit");
dictionary.insert("banana", "yellow fruit");
string meaning = dictionary.search("apple");  // O(log n)

// Auto-complete suggestions
BST<string> words;
// Find all words starting with "app"
words.rangeSearch("app", "apq");
```

=== Khi nào KHÔNG nên dùng BST?

#table(
  columns: (1fr, 2fr),
  align: (left, left),
  [*Tình huống*], [*Lý do*],
  [Dữ liệu đã sorted và static], [Dùng sorted array + binary search → O(log n), no overhead],
  [Cần O(1) search], [Dùng Hash Table thay vì BST O(log n)],
  [Dữ liệu insert theo thứ tự], [BST thành skewed → O(n), cần AVL/Red-Black],
  [Memory critical], [BST tốn memory cho pointers],
)

=== So sánh với các cấu trúc khác

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  align: (left, center, center, center),
  [*Operation*], [*BST*], [*Array*], [*Hash Table*],
  [Search], [O(log n)], [O(n) unsorted \\ O(log n) sorted], [O(1)],
  [Insert], [O(log n)], [O(n)], [O(1)],
  [Delete], [O(log n)], [O(n)], [O(1)],
  [Sorted order], [✓ Easy], [✓ Manual sort], [✗ No],
  [Range query], [✓ Efficient], [✓ OK], [✗ Bad],
  [Memory], [O(n) + pointers], [O(n)], [O(n) + overhead],
)

*Kết luận:*
- BST: Balanced solution cho search, insert, delete + sorted order
- Array: Tốt khi static, cần random access
- Hash Table: Tốt nhất cho pure search/insert/delete, không cần order

#pagebreak()

== Ứng dụng thực tế

*1. File System:*

```
Directory Structure:
    /
   /|\
  usr var home
  / |    |
bin lib  john
        / | \
      docs music videos
```

- Mỗi folder = node
- Subfolders = children
- Traversal = list all files
- Operations:
  - Create folder: Insert
  - Delete folder: Delete subtree
  - Find file: Search

*2. Database Indexing:*

B-Tree (multi-way BST) trong MySQL, PostgreSQL:

```cpp
// Simplified B-Tree node
struct BTreeNode {
    int keys[M-1];      // Max M-1 keys
    BTreeNode* children[M];  // Max M children
};
```

- Fast search: O(log n)
- Range queries: Find all records with age between 20-30
- Maintain sorted order for ORDER BY queries

*3. Compiler - Expression Trees:*

Expression: `(a + b) * (c - d)`

```
         *
       /   \
      +     -
     / \   / \
    a   b c   d
```

- Parse expression into tree
- Evaluate: Postorder traversal
- Optimize: Tree transformations
- Generate code: Traversal

*4. Auto-complete / Spell Checker:*

```cpp
class Autocomplete {
    BST<string> dictionary;
    
public:
    void addWord(string word) {
        dictionary.insert(word);
    }
    
    vector<string> getSuggestions(string prefix) {
        // Find all words >= prefix and < prefix+"z"
        return dictionary.rangeSearch(prefix, prefix + "z");
    }
};

// Usage
Autocomplete ac;
ac.addWord("apple");
ac.addWord("application");
ac.addWord("apply");

vector<string> suggestions = ac.getSuggestions("app");
// Returns: ["apple", "application", "apply"]
```

*5. Game Development - Spatial Partitioning:*

Quadtree (2D BST) cho collision detection:

```
Screen divided into 4 quadrants:
        Root
       / |\ \
     NW NE SW SE
```

- Each node represents a region
- Objects stored at appropriate nodes
- Collision check: Only check objects in same/nearby regions
- Much faster than checking all pairs: O(n²) → O(n log n)

*6. Router Tables (Network):*

IP routing table dùng Trie (variant của tree):

```
Routing Table:
192.168.0.0/16
  ├── 192.168.1.0/24 → Interface A
  └── 192.168.2.0/24 → Interface B
```

- Fast longest prefix match
- O(k) lookup, k = IP address length

#pagebreak()

== Tóm tắt chương

*Những điểm quan trọng nhất cần nhớ:*

1. *Tree* = Cấu trúc phân cấp, phi tuyến tính
   - Root, Leaves, Height, Depth
   - Parent-Child relationships

2. *Binary Tree:* Mỗi node ≤ 2 children
   - Complete Tree: All levels full except last
   - Balanced Tree: |Height(left) - Height(right)| ≤ 1

3. *Traversals:*
   - Depth-First: Preorder (NLR), Inorder (LNR), Postorder (LRN)
   - Breadth-First: Level-order (dùng Queue)

4. *Binary Search Tree:*
   - Left < Root < Right (recursively)
   - Inorder traversal → Sorted list
   - Search/Insert/Delete: O(log n) balanced, O(n) skewed

5. *Implementation:*
   - Linked: Flexible, good for general trees
   - Array: Efficient for complete trees (heap)

6. *Operations Complexity:*
   ```
   | Operation | BST (balanced) | BST (skewed) |
   |-----------|----------------|--------------|
   | Search    | O(log n)       | O(n)         |
   | Insert    | O(log n)       | O(n)         |
   | Delete    | O(log n)       | O(n)         |
   | Traversal | O(n)           | O(n)         |
   ```

7. *Khi nào dùng BST:*
   - Cần search + insert/delete nhanh
   - Cần maintain sorted order
   - Range queries

8. *Lỗi thường gặp:*
   - Memory leak (quên delete)
   - NULL pointer dereference
   - Sai logic delete node with 2 children

9. *Ứng dụng:*
   - File systems
   - Database indexing (B-Trees)
   - Compilers (Expression trees, AST)
   - Auto-complete
   - Game development (Quadtrees)

10. *Vấn đề của Basic BST:* Có thể unbalanced
    - Giải pháp: AVL Trees, Red-Black Trees (Chapter 7)
    - Đảm bảo O(log n) worst-case

#pagebreak()
