#import "../components/template.typ": *

= Cây AVL (AVL Tree)

== Tổng quan chương

=== Nội dung chính

AVL Tree là Binary Search Tree *tự cân bằng* (self-balancing), đảm bảo operations luôn O(log n) ngay cả worst case.

Nội dung:
1. AVL Tree Concepts và Balance Factor
2. 4 trường hợp mất cân bằng
3. Rotations: Left, Right, Left-Right, Right-Left
4. Insert và Delete operations
5. So sánh với BST thường

=== Kiến thức nền

- Binary Search Tree (Chapter 6)
- Recursion
- Tree rotations

#pagebreak()

== Giải thích từng khái niệm

=== AVL Tree

*WHAT - AVL Tree*

*AVL Tree* là Binary Search Tree với điều kiện cân bằng:

- Với mọi node: |Height(left subtree) - Height(right subtree)| ≤ 1
- Left và right subtrees cũng là AVL trees (đệ quy)

Tên gọi: Adelson-Velsky và Landis (1962)

*Balance Factor (BF):*
```
BF = Height(left) - Height(right)

Trong AVL: BF ∈ {-1, 0, 1}
```

*3 trạng thái:*
- BF = -1: Right subtree cao hơn 1 (RH - Right Higher)
- BF = 0: Cân bằng hoàn hảo (EH - Equal Height)
- BF = +1: Left subtree cao hơn 1 (LH - Left Higher)

*Ví dụ AVL hợp lệ:*
```
      8 (BF=0)
     / \
    5   10 (BF=-1)
   / \    \
  3   6    12
```

*Không phải AVL:*
```
      8 (BF=2) ← |2| > 1, Vi phạm!
     /
    5
   /
  3
```

*Tại sao cần AVL?*

*Vấn đề của BST thường:*

Insert data theo thứ tự: 1, 2, 3, 4, 5
```
1
 \
  2
   \
    3
     \
      4  → Degenerate tree!
       \
        5  → Height = 5 = O(n)
```
Search(5) = O(5) = O(n) - Tệ như linked list!

*Giải pháp: AVL Tree*

Insert 1, 2, 3, 4, 5 vào AVL:
```
      2
     / \
    1   4
       / \
      3   5  → Height = 3 = O(log 5)
```
Search(5) = O(log n) - Luôn đảm bảo!

*Lợi ích:*
1. *Guaranteed O(log n):* Worst case vẫn O(log n)
2. *Predictable performance:* Không bị degraded
3. *Tốt cho real-time systems:* Đảm bảo response time

#pagebreak()

=== Rotations (Xoay cây)

*WHAT - Rotation*

*Rotation* là thao tác thay đổi cấu trúc tree bằng cách đổi pointers, *không thay đổi thứ tự inorder*.

Mục đích: Giảm height, cân bằng tree.

*Single Rotations:*

1. *Right Rotation:*
```
      y                x
     / \              / \
    x   C    →       A   y
   / \                  / \
  A   B                B   C

Pseudocode:
temp = y.left
y.left = temp.right
temp.right = y
return temp
```

2. *Left Rotation:*
```
    x                  y
   / \                / \
  A   y      →       x   C
     / \            / \
    B   C          A   B

Pseudocode:
temp = x.right
x.right = temp.left
temp.left = x
return temp
```

*Double Rotations:*

3. *Left-Right Rotation:*
```
      z              z              y
     /              /              / \
    x      →       y      →       x   z
     \            /
      y          x
```
Step 1: Left rotate x
Step 2: Right rotate z

4. *Right-Left Rotation:*
```
    x              x              y
     \              \            / \
      z      →       y    →     x   z
     /                \
    y                  z
```
Step 1: Right rotate z
Step 2: Left rotate x

#pagebreak()

=== 4 Cases Unbalanced

Sau khi insert/delete, AVL có thể mất cân bằng. Có 4 trường hợp:

*Case 1: Left-Left (LL)*
```
      z (BF=2)
     /
    y (BF=1)
   /
  x

→ Right Rotation at z
```

*Case 2: Right-Right (RR)*
```
  x (BF=-2)
   \
    y (BF=-1)
     \
      z

→ Left Rotation at x
```

*Case 3: Left-Right (LR)*
```
    z (BF=2)
   /
  x (BF=-1)
   \
    y

→ Left rotate x, then Right rotate z
```

*Case 4: Right-Left (RL)*
```
  x (BF=-2)
   \
    z (BF=1)
   /
  y

→ Right rotate z, then Left rotate x
```

#pagebreak()

== Bản chất trong máy tính

=== AVL Node Structure

```cpp
struct AVLNode {
    int data;
    AVLNode* left;
    AVLNode* right;
    int height;  // Lưu height để tính BF nhanh
};

// BF calculation
int getBalance(AVLNode* node) {
    if (node == nullptr) return 0;
    return height(node->left) - height(node->right);
}
```

*Memory:*
- BST thường: 2 pointers (8-16 bytes overhead)
- AVL: 2 pointers + 1 int height (12-20 bytes overhead)

Trade-off: Tốn thêm 4 bytes để đảm bảo O(log n)!

=== Rotation Operations

Rotations chỉ thay đổi *pointers*, không di chuyển data:

```
Before Right Rotation:
  y (0x1000)
  ├─ left: 0x2000 (x)
  └─ right: 0x3000 (C)

x (0x2000)
├─ left: 0x4000 (A)
└─ right: 0x5000 (B)

After Right Rotation:
  x (0x2000) ← New root
  ├─ left: 0x4000 (A)
  └─ right: 0x1000 (y)

y (0x1000)
├─ left: 0x5000 (B)
└─ right: 0x3000 (C)
```

→ Chỉ thay đổi 3 pointers → O(1)!

#pagebreak()

== Lịch sử / Nguồn gốc

*1962: AVL Tree được phát minh*
- Georgy Adelson-Velsky và Evgenii Landis (Liên Xô)
- First self-balancing BST!
- Published in "An algorithm for the organization of information"

*Động lực:*
- BST có thể degenerate thành linked list → O(n)
- Cần đảm bảo O(log n) mọi trường hợp
- Quan trọng cho database và information retrieval

*Sau AVL:*
- 1972: Red-Black Trees (more relaxed balancing)
- 1985: Splay Trees
- Modern databases chủ yếu dùng B-Trees (multiway AVL)

*Ngày nay:*
- AVL: Dùng khi cần search nhiều (read-heavy workloads)
- Red-Black: Dùng khi insert/delete nhiều (write-heavy)
- C++ `std::map`, `std::set` dùng Red-Black (not AVL)

#pagebreak()

== Phân tích thuật toán

=== AVL Insert

```
Algorithm AVLInsert(root, value):
    // 1. Normal BST insert
    if root == NULL:
        return createNode(value)
    
    if value < root.data:
        root.left = AVLInsert(root.left, value)
    else:
        root.right = AVLInsert(root.right, value)
    
    // 2. Update height
    root.height = 1 + max(height(root.left), height(root.right))
    
    // 3. Get balance factor
    balance = height(root.left) - height(root.right)
    
    // 4. If unbalanced, 4 cases:
    
    // Left-Left Case
    if balance > 1 and value < root.left.data:
        return rightRotate(root)
    
    // Right-Right Case
    if balance < -1 and value > root.right.data:
        return leftRotate(root)
    
    // Left-Right Case
    if balance > 1 and value > root.left.data:
        root.left = leftRotate(root.left)
        return rightRotate(root)
    
    // Right-Left Case
    if balance < -1 and value < root.right.data:
        root.right = rightRotate(root.right)
        return leftRotate(root)
    
    return root
```

*Complexity:*
- Time: O(log n) - Guaranteed! Height luôn O(log n)
- Space: O(log n) - Recursion stack

=== AVL Delete

Tương tự Insert:
1. Normal BST delete
2. Update heights
3. Check balance factors
4. Rebalance nếu cần (4 cases)

*Complexity:*
- Time: O(log n) - Guaranteed!
- Space: O(log n)

=== Rotations

*Complexity:*
- Time: O(1) - Chỉ thay đổi pointers
- Space: O(1)

#pagebreak()

== Minh họa từng bước

=== AVL Insert với Rotation

Insert: 10, 20, 30 vào AVL tree

```
Step 1: Insert 10
    10 (BF=0)

Step 2: Insert 20
    10 (BF=-1)
      \
       20 (BF=0)

Step 3: Insert 30
    10 (BF=-2) ← Unbalanced! RR case
      \
       20 (BF=-1)
         \
          30

Step 4: Left Rotation at 10
      20 (BF=0)
     /  \
   10    30

Result: Balanced!
```

=== Left-Right Case

Insert: 30, 10, 20

```
Step 1-2:
    30 (BF=1)
   /
  10 (BF=0)

Step 3: Insert 20
    30 (BF=2) ← Unbalanced! LR case
   /
  10 (BF=-1)
    \
     20

Step 4a: Left Rotation at 10
    30
   /
  20
 /
10

Step 4b: Right Rotation at 30
      20
     /  \
   10    30

Result: Balanced!
```

#pagebreak()

== Code minh họa C++

```cpp
#include <iostream>
using namespace std;

struct AVLNode {
    int data;
    AVLNode* left;
    AVLNode* right;
    int height;
    
    AVLNode(int val) : data(val), left(nullptr), right(nullptr), height(1) {}
};

class AVLTree {
private:
    AVLNode* root;
    
    int height(AVLNode* node) {
        return node ? node->height : 0;
    }
    
    int getBalance(AVLNode* node) {
        return node ? height(node->left) - height(node->right) : 0;
    }
    
    void updateHeight(AVLNode* node) {
        if (node) {
            node->height = 1 + max(height(node->left), height(node->right));
        }
    }
    
    AVLNode* rightRotate(AVLNode* y) {
        AVLNode* x = y->left;
        AVLNode* B = x->right;
        
        // Rotation
        x->right = y;
        y->left = B;
        
        // Update heights
        updateHeight(y);
        updateHeight(x);
        
        return x;  // New root
    }
    
    AVLNode* leftRotate(AVLNode* x) {
        AVLNode* y = x->right;
        AVLNode* B = y->left;
        
        // Rotation
        y->left = x;
        x->right = B;
        
        // Update heights
        updateHeight(x);
        updateHeight(y);
        
        return y;  // New root
    }
    
    AVLNode* insertRec(AVLNode* node, int value) {
        // 1. Normal BST insert
        if (node == nullptr) {
            return new AVLNode(value);
        }
        
        if (value < node->data) {
            node->left = insertRec(node->left, value);
        } else if (value > node->data) {
            node->right = insertRec(node->right, value);
        } else {
            return node;  // Duplicates not allowed
        }
        
        // 2. Update height
        updateHeight(node);
        
        // 3. Get balance factor
        int balance = getBalance(node);
        
        // 4. Rebalance if needed (4 cases)
        
        // Left-Left Case
        if (balance > 1 && value < node->left->data) {
            return rightRotate(node);
        }
        
        // Right-Right Case
        if (balance < -1 && value > node->right->data) {
            return leftRotate(node);
        }
        
        // Left-Right Case
        if (balance > 1 && value > node->left->data) {
            node->left = leftRotate(node->left);
            return rightRotate(node);
        }
        
        // Right-Left Case
        if (balance < -1 && value < node->right->data) {
            node->right = rightRotate(node->right);
            return leftRotate(node);
        }
        
        return node;
    }
    
    AVLNode* findMin(AVLNode* node) {
        while (node->left) node = node->left;
        return node;
    }
    
    AVLNode* deleteRec(AVLNode* node, int value) {
        if (node == nullptr) return nullptr;
        
        // 1. Normal BST delete
        if (value < node->data) {
            node->left = deleteRec(node->left, value);
        } else if (value > node->data) {
            node->right = deleteRec(node->right, value);
        } else {
            // Found node to delete
            if (!node->left || !node->right) {
                AVLNode* temp = node->left ? node->left : node->right;
                delete node;
                return temp;
            }
            
            // Two children
            AVLNode* successor = findMin(node->right);
            node->data = successor->data;
            node->right = deleteRec(node->right, successor->data);
        }
        
        if (node == nullptr) return nullptr;
        
        // 2. Update height
        updateHeight(node);
        
        // 3. Rebalance (same 4 cases)
        int balance = getBalance(node);
        
        if (balance > 1 && getBalance(node->left) >= 0)
            return rightRotate(node);
        
        if (balance < -1 && getBalance(node->right) <= 0)
            return leftRotate(node);
        
        if (balance > 1 && getBalance(node->left) < 0) {
            node->left = leftRotate(node->left);
            return rightRotate(node);
        }
        
        if (balance < -1 && getBalance(node->right) > 0) {
            node->right = rightRotate(node->right);
            return leftRotate(node);
        }
        
        return node;
    }
    
    void inorderRec(AVLNode* node) {
        if (!node) return;
        inorderRec(node->left);
        cout << node->data << " ";
        inorderRec(node->right);
    }
    
public:
    AVLTree() : root(nullptr) {}
    
    void insert(int value) {
        root = insertRec(root, value);
    }
    
    void remove(int value) {
        root = deleteRec(root, value);
    }
    
    void inorder() {
        inorderRec(root);
        cout << endl;
    }
    
    int getHeight() {
        return height(root);
    }
};

int main() {
    AVLTree avl;
    
    // Insert in sorted order (worst for normal BST)
    cout << "Inserting 10, 20, 30, 40, 50..." << endl;
    avl.insert(10);
    avl.insert(20);
    avl.insert(30);
    avl.insert(40);
    avl.insert(50);
    
    cout << "Inorder: ";
    avl.inorder();  // 10 20 30 40 50
    
    cout << "Height: " << avl.getHeight() << endl;  // 3 (not 5!)
    
    // Normal BST would have height 5
    // AVL automatically balances to height 3
    
    return 0;
}
```

#pagebreak()

== Lỗi phổ biến

*1. Quên update height sau rotation*
```cpp
// ❌ SAI
AVLNode* rightRotate(AVLNode* y) {
    AVLNode* x = y->left;
    y->left = x->right;
    x->right = y;
    return x;  // Quên update heights!
}

// ✅ ĐÚNG
AVLNode* rightRotate(AVLNode* y) {
    AVLNode* x = y->left;
    AVLNode* B = x->right;
    x->right = y;
    y->left = B;
    
    updateHeight(y);  // Cập nhật y trước
    updateHeight(x);  // Cập nhật x sau
    
    return x;
}
```

*2. Sai thứ tự rotation trong double rotations*
```cpp
// ❌ SAI: Right-Left case - Rotate sai thứ tự
if (balance < -1 && getBalance(node->right) > 0) {
    node = rightRotate(node);          // SAI: Rotate root trước
    node->right = leftRotate(node->right);
    return node;
}

// ✅ ĐÚNG
if (balance < -1 && getBalance(node->right) > 0) {
    node->right = rightRotate(node->right);  // Rotate child trước
    return leftRotate(node);                 // Rotate root sau
}
```

#pagebreak()

== Khi nào dùng AVL vs BST vs Red-Black

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  align: (left, left, left, left),
  [], [*AVL*], [*BST thường*], [*Red-Black*],
  [*Search*], [O(log n) ✓], [O(n) worst], [O(log n) ✓],
  [*Insert*], [O(log n) ✓], [O(n) worst], [O(log n) ✓],
  [*Balance*], [Strict (BF≤1)], [No], [Relaxed],
  [*Rotations*], [Nhiều hơn], [0], [Ít hơn AVL],
  [*Best for*], [Read-heavy], [Static sorted], [Write-heavy],
  [*Ví dụ*], [Database index], [Fixed config], [C++ STL],
)

*Khi nào dùng AVL:*
- Read >> Write (90% search, 10% insert/delete)
- Cần đảm bảo O(log n) worst-case
- Database read replicas

*Khi nào dùng Red-Black:*
- Write nhiều
- C++ `std::map`, `std::set`
- Linux kernel

#pagebreak()

== Ứng dụng thực tế

*1. Database - In-Memory Index:*

```cpp
// Index cho frequent lookups
AVLTree<int, User> userIndex;  // Key: userID

User getUser(int userID) {
    return userIndex.search(userID);  // O(log n) đảm bảo
}
```

- MySQL, PostgreSQL dùng B-Trees (multi-way AVL)
- Redis dùng Skip List (alternative to AVL)

*2. Auto-complete Systems:*

```cpp
AVLTree<string> dictionary;

// Find all words between "app" and "apq"
vector<string> autocomplete(string prefix) {
    return dictionary.rangeQuery(prefix, prefix + "z");
}
```

*3. Memory Allocators:*

```cpp
// Track free memory blocks
AVLTree<size_t, MemoryBlock> freeBlocks;

void* allocate(size_t size) {
    // Find smallest block >= size → O(log n)
    MemoryBlock block = freeBlocks.findSmallest(size);
    return block.address;
}
```

#pagebreak()

== Tóm tắt

*Điểm quan trọng:*

1. *AVL = BST + Self-balancing*
   - Balance Factor: |BF| ≤ 1
   - Đảm bảo height = O(log n)

2. *4 Cases unbalanced:*
   - LL → Right rotation
   - RR → Left rotation
   - LR → Left then Right
   - RL → Right then Left

3. *Complexity:*
   - Search/Insert/Delete: O(log n) *đảm bảo*
   - Space: O(n) + height storage

4. *Trade-offs:*
   - AVL: Strict balance → More rotations → Better search
   - Red-Black: Relaxed → Fewer rotations → Better insert

5. *Khi nào dùng:*
   - Read-heavy workloads
   - Cần guaranteed O(log n)
   - Database, Dictionary, Auto-complete

6. *Lỗi thường gặp:*
   - Quên update height
   - Sai thứ tự rotation (double rotations)
   - Không check balance sau insert/delete

#pagebreak()
