#import "../components/template.typ": *

= Bảng băm (Hash Table)

== Tổng quan chương

=== Nội dung chính

Hash Table là cấu trúc dữ liệu cho phép search/insert/delete với *O(1) average case* - nhanh nhất có thể!

Nội dung:
1. Basic Concepts (Hash function, Collision)
2. Hash Functions (Modulo, Mid-square, Folding...)
3. Collision Resolution (Open Addressing, Chaining, Bucket)
4. Load Factor và Performance
5. Applications

=== Kiến thức nền

- Arrays
- Linked Lists
- Modulo arithmetic

#pagebreak()

== Giải thích từng khái niệm

=== Hash Table và Hash Function

*WHAT - Hash Table*

*Hash Table* là cấu trúc dữ liệu sử dụng *hash function* để map keys vào array indices:

```
hash(key) → index
table[index] = value
```

*Thuật ngữ:*
- *Hash Function:* h(key) → address
- *Home Address:* Địa chỉ do hash function tạo ra
- *Prime Area:* Vùng nhớ chứa home addresses
- *Collision:* Khi 2 keys map tới cùng address
- *Synonyms:* Tập keys hash ra cùng location

*Ví dụ:*
```
Hash function: h(key) = key % 10

Keys:      Hash values:
23    →    3
45    →    5
13    →    3  ← Collision với 23!
78    →    8

Table: [_, _, _, 23, _, 45, _, _, 78, _]
       Index: 0  1  2   3  4   5  6  7   8  9
```

*Tại sao cần Hash Table?*

*Câu hỏi: Có thuật toán search O(1) không?*

*CÓ! Hash Table!*

So sánh với các cấu trúc khác:

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  align: (left, center, center, center),
  [*n elements*], [*Sequential*], [*Binary*], [*Hash*],
  [1,000], [500], [10], [*1*],
  [1,000,000], [500,000], [20], [*1*],
)

*Lợi ích:*
1. *Cực kỳ nhanh:* O(1) average case!
2. *Không phụ thuộc n:* 10 phần tử hay 1 triệu đều O(1)
3. *Đơn giản:* Dễ implement

*Ứng dụng:*
- Dictionary, Map, Set
- Database index
- Caching
- Symbol table trong compiler

#pagebreak()

=== Hash Functions

*WHAT - Hash Function*

Hash function h(key) biến đổi key thành array index.

*Yêu cầu:*
1. *Deterministic:* Cùng key → cùng hash value
2. *Fast:* Tính toán nhanh (O(1))
3. *Uniform distribution:* Phân bổ đều để giảm collision

*Các loại Hash Functions:*

1. *Direct Hashing:*
   ```
   h(key) = key
   ```
   - Ưu: Không collision
   - Nhược: Lãng phí space (key space = address space)

2. *Modulo Division (phổ biến nhất):*
   ```
   h(key) = key % m
   ```
   - m nên là số nguyên tố để giảm collision
   - Ví dụ: h(121267) = 121267 % 307 = 2

3. *Mid-Square:*
   ```
   h(key) = middle digits of (key²)
   ```
   - Ví dụ: key = 9452
     - 9452² = 89340304
     - Middle: 3403

4. *Digit Extraction:*
   ```
   h(key) = selected digits from key
   ```
   - Ví dụ: 379452 → digits 1,2,4 → 394

5. *Folding:*
   ```
   Chia key thành parts, cộng lại
   ```
   - Key = 123456789
   - Parts: 123 | 456 | 789
   - Fold shift: 123 + 456 + 789 = 1368 → 368

6. *Pseudo-Random:*
   ```
   h(key) = (a × key + c) % m
   ```
   - a, c là số nguyên tố

#pagebreak()

=== Collision (Đụng độ)

*WHAT - Collision*

*Collision* xảy ra khi 2 keys khác nhau hash ra cùng index:

```
h(key1) = h(key2) = i
table[i] đã có key1
→ Làm sao insert key2?
```

*Tại sao có collision?*
- Key space >> Address space
- Ví dụ: 1 triệu employee IDs → Hash table size 1000
- Theo Pigeonhole Principle: Chắc chắn có collisions!

*3 phương pháp giải quyết:*

1. *Open Addressing:* Tìm slot trống khác trong array
2. *Chaining:* Mỗi slot là một linked list
3. *Bucket Hashing:* Mỗi slot chứa nhiều phần tử

#pagebreak()

=== Open Addressing

*Open Addressing:* Khi collision, tìm slot trống tiếp theo theo một quy luật probe.

Probe function: `hp(key, i) = (h(key) + p(i)) % m`

*3 phương pháp probe:*

1. *Linear Probing:*
   ```
   p(i) = i
   hp(key, i) = (h(key) + i) % m
   ```
   - Thử index: h(key), h(key)+1, h(key)+2, ...
   - Vấn đề: *Primary Clustering* (tạo cụm dài)

2. *Quadratic Probing:*
   ```
   p(i) = i²
   hp(key, i) = (h(key) + i²) % m
   ```
   - Thử: h(key), h(key)+1, h(key)+4, h(key)+9, ...
   - Giảm clustering nhưng vẫn có *Secondary Clustering*

3. *Double Hashing:*
   ```
   hp(key, i) = (h₁(key) + i × h₂(key)) % m
   ```
   - Dùng 2 hash functions
   - Ít clustering nhất

*Ví dụ Linear Probing:*
```
h(key) = key % 10
Insert: 23, 45, 13, 78, 33

23: h(23) = 3 → table[3] = 23
45: h(45) = 5 → table[5] = 45
13: h(13) = 3 → Collision! Try 4 → table[4] = 13
78: h(78) = 8 → table[8] = 78
33: h(33) = 3 → Collision! Try 4 (full), 5 (full), 6 → table[6] = 33

Table: [_, _, _, 23, 13, 45, 33, _, 78, _]
```

=== Chaining (Separate Chaining)

*Chaining:* Mỗi slot trong hash table là một linked list.

Collision → Thêm vào linked list tại slot đó.

```
Table: array of linked lists

h(key) = key % 5

Keys: 23, 45, 13, 78, 33, 18

0: NULL
1: NULL
2: NULL
3: 23 → 13 → 33 → 18 → NULL
4: 78 → NULL
```

*Ưu/Nhược:*
- Ưu: Đơn giản, không bao giờ "full"
- Nhược: Tốn memory cho pointers, cache-unfriendly

#pagebreak()

=== Load Factor

*Load Factor (α):* Tỷ lệ lấp đầy hash table

```
α = n / m
```

n = số elements, m = table size

*Ảnh hưởng đến performance:*

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  align: (left, left, left),
  [*Load Factor*], [*Open Addressing*], [*Chaining*],
  [α < 0.5], [Ít collision, nhanh], [List ngắn, nhanh],
  [α ≈ 0.7], [OK], [Tốt],
  [α > 0.9], [Nhiều collision, chậm], [List dài, chậm hơn],
  [α > 1.0], [Không thể (full table)], [OK nhưng chậm],
)

*Khi nào resize?*
- Thường resize khi α > 0.75
- Tạo table mới (2× size)
- Rehash tất cả elements → O(n)

#pagebreak()

== Bản chất trong máy tính

=== Memory Layout

*Hash Table with Chaining:*
```
Table Array (Stack/Data segment):
[0]: 0x2000 → [23|0x2100] → [13|NULL]
[1]: NULL
[2]: 0x3000 → [45|NULL]
[3]: 0x4000 → [78|0x4100] → [33|NULL]

Linked List Nodes (Heap):
0x2000, 0x2100: Chain for slot 0
0x3000: Chain for slot 2
0x4000, 0x4100: Chain for slot 3
```

*Hash Table with Open Addressing:*
```
Simple array:
[0]: empty
[1]: empty
[2]: 45
[3]: 23
[4]: 13  ← Probed from slot 3
[5]: 78
[6]: 33  ← Probed from slot 3
```

→ Open Addressing tiết kiệm memory hơn (no pointers)!

=== Cache Performance

*Chaining:* Cache-unfriendly (pointers jump around memory)

*Open Addressing:* Cache-friendly (sequential probing trong array)

→ Trong thực tế, Open Addressing thường nhanh hơn với α < 0.7!

#pagebreak()

== Lịch sử / Nguồn gốc

*1953: Hash Table*
- Hans Peter Luhn (IBM) phát minh hashing
- Mục đích: Internal memory lookup

*1954: Open Addressing*
- A.D. Linh
- Linear probing

*1963: Chaining*
- Arnold Dumey
- Separate chaining with linked lists

*1970s: Advanced Hash Functions*
- Universal hashing
- Perfect hashing
- Cryptographic hash (MD5, SHA)

*Ngày nay:*
- Hash tables everywhere!
- C++ `unordered_map`, `unordered_set`
- Java `HashMap`, `HashSet`
- Python `dict`, `set`
- JavaScript objects

*Modern applications:*
- Blockchain (SHA-256 hashing)
- Password storage (bcrypt, scrypt)
- Data deduplication
- Distributed systems (Consistent hashing)

#pagebreak()

== Phân tích thuật toán

=== Hash Function

*Complexity:*
- Time: O(1) - Constant time calculation
- Space: O(1)

=== Search/Insert/Delete

*With Chaining:*

*Time Complexity:* 
- Best: O(1) - no collision
- Average: O(1 + α) ≈ O(1) if α small
- Worst: O(n) - all keys in same slot

*Space Complexity:* O(n + m) - n elements + m slots

*With Open Addressing:*

*Time Complexity:*
- Best: O(1)
- Average: O(1/(1-α)) if α < 0.7
- Worst: O(n) - full table

*Space Complexity:* O(m) - fixed array size

*Phân tích chi tiết:*

Với α = 0.5:
- Chaining: Average chain length = 0.5 → ~1-2 comparisons
- Linear Probing: ~1.5 probes
- Quadratic/Double Hashing: ~1.4 probes

Với α = 0.9:
- Chaining: ~1-2 comparisons (still OK)
- Linear Probing: ~5-10 probes (degraded!)

#pagebreak()

== Minh họa từng bước

=== Chaining Example

```
h(key) = key % 7
Insert: 23, 45, 13, 78, 33, 18, 51

Step 1: Insert 23
  h(23) = 2
  table[2] = [23] → NULL

Step 2: Insert 45
  h(45) = 3
  table[3] = [45] → NULL

Step 3: Insert 13
  h(13) = 6
  table[6] = [13] → NULL

Step 4: Insert 78
  h(78) = 1
  table[1] = [78] → NULL

Step 5: Insert 33
  h(33) = 5
  table[5] = [33] → NULL

Step 6: Insert 18
  h(18) = 4
  table[4] = [18] → NULL

Step 7: Insert 51
  h(51) = 2  ← Collision với 23!
  table[2] = [23] → [51] → NULL

Final:
[0]: NULL
[1]: [78] → NULL
[2]: [23] → [51] → NULL
[3]: [45] → NULL
[4]: [18] → NULL
[5]: [33] → NULL
[6]: [13] → NULL
```

=== Linear Probing Example

```
Same keys, same h(key) = key % 7
Insert: 23, 45, 13, 78, 33, 18, 51

Insert 23: h(23) = 2 → table[2] = 23
Insert 45: h(45) = 3 → table[3] = 45
Insert 13: h(13) = 6 → table[6] = 13
Insert 78: h(78) = 1 → table[1] = 78
Insert 33: h(33) = 5 → table[5] = 33
Insert 18: h(18) = 4 → table[4] = 18

Insert 51: h(51) = 2 → Collision!
  Try (2+0)%7 = 2 → Full (23)
  Try (2+1)%7 = 3 → Full (45)
  Try (2+2)%7 = 4 → Full (18)
  Try (2+3)%7 = 5 → Full (33)
  Try (2+4)%7 = 6 → Full (13)
  Try (2+5)%7 = 0 → Empty! → table[0] = 51

Final:
[51, 78, 23, 45, 18, 33, 13]
  0   1   2   3   4   5   6
```

#pagebreak()

== Code minh họa C++

=== Hash Table with Chaining

```cpp
#include <iostream>
#include <vector>
#include <list>
using namespace std;

class HashTableChaining {
private:
    vector<list<int>> table;
    int tableSize;
    int numElements;
    
    int hashFunction(int key) {
        return key % tableSize;
    }
    
public:
    HashTableChaining(int size = 10) : tableSize(size), numElements(0) {
        table.resize(tableSize);
    }
    
    void insert(int key) {
        int index = hashFunction(key);
        
        // Check if already exists
        for (int k : table[index]) {
            if (k == key) return;  // Duplicate
        }
        
        table[index].push_back(key);
        numElements++;
    }
    
    bool search(int key) {
        int index = hashFunction(key);
        
        for (int k : table[index]) {
            if (k == key) return true;
        }
        
        return false;
    }
    
    bool remove(int key) {
        int index = hashFunction(key);
        
        for (auto it = table[index].begin(); it != table[index].end(); ++it) {
            if (*it == key) {
                table[index].erase(it);
                numElements--;
                return true;
            }
        }
        
        return false;
    }
    
    double loadFactor() {
        return (double)numElements / tableSize;
    }
    
    void print() {
        for (int i = 0; i < tableSize; i++) {
            cout << "[" << i << "]: ";
            for (int key : table[i]) {
                cout << key << " → ";
            }
            cout << "NULL" << endl;
        }
    }
};

int main() {
    HashTableChaining ht(7);
    
    ht.insert(23);
    ht.insert(45);
    ht.insert(13);
    ht.insert(78);
    ht.insert(33);
    ht.insert(18);
    ht.insert(51);  // Collision with 23
    
    ht.print();
    
    cout << "\nSearch 51: " << (ht.search(51) ? "Found" : "Not found") << endl;
    cout << "Search 100: " << (ht.search(100) ? "Found" : "Not found") << endl;
    
    cout << "Load Factor: " << ht.loadFactor() << endl;
    
    ht.remove(51);
    cout << "\nAfter removing 51:" << endl;
    ht.print();
    
    return 0;
}
```

=== Hash Table with Linear Probing

```cpp
class HashTableLinearProbing {
private:
    vector<int> table;
    vector<bool> occupied;
    int tableSize;
    int numElements;
    
    int hashFunction(int key) {
        return key % tableSize;
    }
    
    int probe(int key, int i) {
        return (hashFunction(key) + i) % tableSize;
    }
    
public:
    HashTableLinearProbing(int size = 10) : tableSize(size), numElements(0) {
        table.resize(tableSize);
        occupied.resize(tableSize, false);
    }
    
    bool insert(int key) {
        if (numElements >= tableSize) {
            cout << "Table full!" << endl;
            return false;
        }
        
        int i = 0;
        while (i < tableSize) {
            int index = probe(key, i);
            
            if (!occupied[index]) {
                table[index] = key;
                occupied[index] = true;
                numElements++;
                return true;
            }
            
            if (table[index] == key) {
                return false;  // Duplicate
            }
            
            i++;  // Probe next
        }
        
        return false;  // Should not reach here
    }
    
    bool search(int key) {
        int i = 0;
        while (i < tableSize) {
            int index = probe(key, i);
            
            if (!occupied[index]) {
                return false;  // Empty slot → not found
            }
            
            if (table[index] == key) {
                return true;  // Found
            }
            
            i++;  // Probe next
        }
        
        return false;
    }
    
    void print() {
        for (int i = 0; i < tableSize; i++) {
            if (occupied[i]) {
                cout << "[" << i << "]: " << table[i] << endl;
            } else {
                cout << "[" << i << "]: empty" << endl;
            }
        }
    }
    
    double loadFactor() {
        return (double)numElements / tableSize;
    }
};
```

#pagebreak()

== Lỗi phổ biến

*1. Hash function không uniform*

```cpp
// ❌ SAI: Collision nhiều
int hash(int key) {
    return key % 100;  // Nếu keys đều chẵn → Chỉ dùng 50 slots!
}

// ✅ TốT HƠN: Dùng số nguyên tố
int hash(int key) {
    return key % 101;  // Prime number
}
```

*2. Không handle collision*

```cpp
// ❌ SAI: Overwrite data khi collision
void insert(int key) {
    int index = hash(key);
    table[index] = key;  // Nếu collision → mất data cũ!
}

// ✅ ĐÚNG: Resolve collision
```

*3. Linear Probing - Quên modulo*

```cpp
// ❌ SAI: Index out of bounds
int probe(int key, int i) {
    return hash(key) + i;  // Có thể > tableSize!
}

// ✅ ĐÚNG
int probe(int key, int i) {
    return (hash(key) + i) % tableSize;
}
```

#pagebreak()

== Khi nào dùng / không dùng

=== Khi nào dùng Hash Table?

- Cần search/insert/delete *cực nhanh* O(1)
- Không cần maintain sorted order
- Không cần range queries
- Key space không quá lớn

*Ví dụ:*
- Dictionary: word → definition
- Cache: URL → cached page
- Database: Primary key index
- Set operations (membership test)

=== Khi nào KHÔNG dùng Hash Table?

#table(
  columns: (1.5fr, 2fr),
  align: (left, left),
  [*Tình huống*], [*Dùng gì thay thế*],
  [Cần sorted order], [BST, AVL Tree],
  [Cần range queries], [BST (find all x in [a,b])],
  [Cần min/max frequently], [Heap],
  [Memory critical], [BST (no wasted slots)],
  [Worst-case guarantee], [AVL Tree O(log n) guaranteed],
)

#pagebreak()

== Ứng dụng thực tế

*1. Database Indexing:*

```cpp
// Hash index cho primary key
HashTable<int, Record> employeeTable;

void insertEmployee(int id, Record rec) {
    employeeTable.insert(id, rec);  // O(1)
}

Record getEmployee(int id) {
    return employeeTable.search(id);  // O(1)!
}
```

MySQL, PostgreSQL dùng hash index cho equality searches (không dùng cho range).

*2. Caching (Redis, Memcached):*

```cpp
class Cache {
    HashTable<string, string> cache;
    
public:
    string get(string url) {
        if (cache.contains(url)) {
            return cache.get(url);  // O(1) - Cache hit!
        } else {
            string content = fetchFromNetwork(url);
            cache.insert(url, content);
            return content;
        }
    }
};
```

*3. Compiler - Symbol Table:*

```cpp
// Lưu biến, hàm trong compiler
HashTable<string, SymbolInfo> symbolTable;

void declareVariable(string name, Type type) {
    if (symbolTable.contains(name)) {
        error("Variable already declared!");
    }
    symbolTable.insert(name, {type, address});
}

Type getVariableType(string name) {
    return symbolTable.get(name).type;  // O(1)
}
```

*4. Web - Session Management:*

```cpp
HashTable<string, Session> sessions;

void createSession(User user) {
    string sessionID = generateRandomID();
    sessions.insert(sessionID, {user, timestamp});
    setCookie("sessionID", sessionID);
}

User getUser(string sessionID) {
    if (sessions.contains(sessionID)) {
        return sessions.get(sessionID).user;  // O(1)
    }
    return null;  // Not logged in
}
```

*5. Blockchain - Transaction Verification:*

```cpp
// Bitcoin transaction pool
HashTable<string, Transaction> mempool;

bool isTransactionValid(string txHash) {
    // Check if transaction already in blockchain
    return mempool.contains(txHash);  // O(1)
}
```

#pagebreak()

== Tóm tắt

*Điểm quan trọng:*

1. *Hash Table = O(1) search/insert/delete!*
   - Nhanh nhất có thể
   - Dùng hash function: key → index

2. *Hash Functions:*
   - Modulo Division (phổ biến): h(k) = k % m, m là prime
   - Mid-Square, Folding, Pseudo-random
   - Yêu cầu: Fast, Uniform distribution

3. *Collision Resolution:*
   - *Chaining:* Linked list tại mỗi slot (đơn giản, no "full")
   - *Open Addressing:* Linear/Quadratic/Double hashing probing
   - *Bucket:* Mỗi slot chứa nhiều elements

4. *Load Factor α = n/m:*
   - α < 0.7: Good performance
   - α > 0.9: Degrade → Cần resize

5. *Complexity:*
   - Average: O(1) - Amazing!
   - Worst: O(n) - Khi all collision
   - Với good hash function + α < 0.7 → Gần O(1)

6. *Trade-offs:*
   - Chaining: Flexible, extra memory for pointers
   - Open Addressing: Cache-friendly, có thể "full"

7. *Hash vs BST vs Heap:*
   - Hash: Fast search, no order
   - BST: Moderate search, sorted order, range queries
   - Heap: Fast max/min, no search

8. *Lỗi thường gặp:*
   - Bad hash function → Nhiều collision
   - Không handle collision
   - Load factor quá cao

9. *Ứng dụng:*
   - Database index
   - Caching systems
   - Compiler symbol tables
   - Session management
   - Blockchain

10. *C++ STL:*
    - `std::unordered_map<K, V>` - Hash table
    - `std::unordered_set<T>`
    - `std::map` - BST (Red-Black Tree)

#pagebreak()
