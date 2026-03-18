#import "../components/template.typ": *

= Đồ thị (Graph)

== Tổng quan chương

=== Nội dung chính

Graph là cấu trúc dữ liệu mạnh mẽ nhất, có thể biểu diễn hầu hết mọi quan hệ trong thế giới thực.

Nội dung:
1. Graph Definition (Vertices, Edges)
2. Directed vs Undirected, Weighted vs Unweighted
3. Graph Representations (Adjacency Matrix, Adjacency List)
4. Graph Traversals: DFS, BFS
5. Shortest Path: Dijkstra's Algorithm
6. Minimum Spanning Tree: Prim's, Kruskal's Algorithm
7. Applications

=== Kiến thức nền

- Trees (Graph là tổng quát hóa của Tree)
- Queue (cho BFS)
- Stack/Recursion (cho DFS)
- Priority Queue (cho Dijkstra, Prim)

#pagebreak()

== Giải thích từng khái niệm

=== Graph (Đồ thị)

*WHAT - Graph*

*Graph G = (V, E)* bao gồm:
- *V:* Tập hợp các vertices (đỉnh)
- *E:* Tập hợp các edges (cạnh) nối các vertices

E ⊆ V × V (Tập con của tích Descartes)

*Ví dụ:*
```
Graph G:
V = {A, B, C, D}
E = {(A,B), (A,C), (B,D), (C,D)}

Visualization:
    A ─── B
    │     │
    C ─── D
```

*Các loại Graph:*

1. *Directed Graph (Digraph):*
   - Edges có hướng: A → B ≠ B → A
   ```
   A → B
   ↑   ↓
   C ← D
   ```

2. *Undirected Graph:*
   - Edges không hướng: A─B = B─A
   ```
   A ─ B
   │   │
   C ─ D
   ```

3. *Weighted Graph:*
   - Mỗi edge có weight (trọng số)
   ```
   A ─5─ B
   │3    │2
   C ─4─ D
   ```

4. *Unweighted Graph:*
   - Edges không có weight (hoặc weight = 1)

*Thuật ngữ:*
- *Adjacent:* Hai vertices có edge nối
- *Degree:* Số edges của một vertex
- *Path:* Chuỗi vertices từ u đến v
- *Cycle:* Path bắt đầu và kết thúc ở cùng vertex
- *Connected:* Có path giữa mọi cặp vertices
- *Strongly Connected (Digraph):* Có directed path giữa mọi cặp

*Tại sao cần Graph?*

Graph là cấu trúc *universal* - Biểu diễn được hầu hết mọi thứ:

1. *Social Networks:*
   - Vertices = Users
   - Edges = Friendship

2. *Maps/GPS:*
   - Vertices = Cities/Intersections
   - Edges = Roads
   - Weights = Distance/Time

3. *Web:*
   - Vertices = Webpages
   - Edges = Hyperlinks
   - Google PageRank dùng graph!

4. *Computer Networks:*
   - Vertices = Routers/Computers
   - Edges = Connections
   - Routing algorithms

5. *Dependencies:*
   - Vertices = Tasks/Packages
   - Edges = Dependencies
   - Topological sort

#pagebreak()

=== Graph Representations

*WHAT - Cách lưu Graph*

2 cách chính lưu Graph trong máy tính:

1. *Adjacency Matrix*
2. *Adjacency List*

*1. Adjacency Matrix (Ma trận kề):*

Array 2D: `matrix[i][j] = 1` nếu có edge từ i → j

```
Graph:          Matrix:
  0→1             0  1  2  3
  ↓ ↓           ┌────────────
  3→2         0 │ 0  1  0  1
              1 │ 0  0  1  0
              2 │ 0  0  0  0
              3 │ 0  0  1  0

matrix[0][1] = 1 (edge 0→1)
matrix[0][3] = 1 (edge 0→3)
```

*Ưu/Nhược:*
- ✓ Check edge: O(1)
- ✓ Simple implementation
- ✗ Space: O(V²) - Lãng phí với sparse graph
- ✗ Get neighbors: O(V)

*2. Adjacency List (Danh sách kề):*

Mỗi vertex có list các neighbors:

```
Graph:          List:
  0→1           0: [1, 3]
  ↓ ↓           1: [2]
  3→2           2: []
                3: [2]

vector<vector<int>> adj(V);
adj[0] = {1, 3};
adj[1] = {2};
adj[3] = {2};
```

*Ưu/Nhược:*
- ✓ Space: O(V + E) - Efficient với sparse graph
- ✓ Get neighbors: O(degree(v))
- ✗ Check edge: O(degree(v))

#pagebreak()

=== Depth-First Search (DFS)

*WHAT - DFS*

*DFS* duyệt graph bằng cách đi sâu nhất có thể trước khi backtrack.

Dùng *Stack* (hoặc Recursion).

*Algorithm:*
```
Algorithm DFS(graph, start):
    visited[start] = true
    process(start)
    
    for each neighbor of start:
        if not visited[neighbor]:
            DFS(graph, neighbor)
```

*Ví dụ:*
```
Graph:
    A ─ B
    │   │
    C ─ D

DFS from A:
Visit A → Visit B → Visit D → Visit C

Order: A, B, D, C
```

*Complexity:*
- Time: O(V + E) - Visit mỗi vertex và edge một lần
- Space: O(V) - Stack/Visited array

*Ứng dụng DFS:*
- Tìm path giữa 2 vertices
- Detect cycle
- Topological sort
- Connected components

=== Breadth-First Search (BFS)

*WHAT - BFS*

*BFS* duyệt graph theo level: Visit tất cả neighbors trước khi đi sâu hơn.

Dùng *Queue*.

*Algorithm:*
```
Algorithm BFS(graph, start):
    queue = createQueue()
    visited[start] = true
    enqueue(queue, start)
    
    while not empty(queue):
        current = dequeue(queue)
        process(current)
        
        for each neighbor of current:
            if not visited[neighbor]:
                visited[neighbor] = true
                enqueue(queue, neighbor)
```

*Ví dụ:*
```
Graph:
    A ─ B
    │   │
    C ─ D

BFS from A:
Level 0: A
Level 1: B, C (neighbors of A)
Level 2: D (neighbor of B and C)

Order: A, B, C, D
```

*Complexity:*
- Time: O(V + E)
- Space: O(V) - Queue

*Ứng dụng BFS:*
- Shortest path (unweighted graph)
- Level-order traversal
- Web crawler
- Social network (friends of friends)

#pagebreak()

=== Shortest Path - Dijkstra's Algorithm

*WHAT - Dijkstra*

*Dijkstra's Algorithm* tìm shortest path từ một source vertex đến tất cả vertices khác trong *weighted graph với edges không âm*.

*Ý tưởng:*
- Dùng *Greedy approach*
- Luôn chọn vertex với distance nhỏ nhất chưa được visit
- Dùng Priority Queue (Min Heap)

*Algorithm:*
```
Algorithm Dijkstra(graph, source):
    for each vertex v:
        dist[v] = ∞
        prev[v] = null
    
    dist[source] = 0
    pq = MinPriorityQueue()
    pq.insert((0, source))
    
    while not empty(pq):
        (d, u) = pq.extractMin()
        
        if d > dist[u]: continue  // Already processed
        
        for each neighbor v of u with weight w:
            if dist[u] + w < dist[v]:
                dist[v] = dist[u] + w
                prev[v] = u
                pq.insert((dist[v], v))
    
    return dist
```

*Complexity:*
- Time: O((V + E) log V) với Binary Heap, O(V² + E) với array
- Space: O(V) - dist, prev arrays

*Lưu ý:* Không hoạt động với negative weights! (Dùng Bellman-Ford thay thế)

#pagebreak()

== Bản chất trong máy tính

=== Memory Layout

*Adjacency Matrix:*
```
int matrix[V][V];

Memory: Contiguous 2D array
Size: V × V × sizeof(int) = 100 × 100 × 4 = 40KB (V=100)
```

*Adjacency List:*
```
vector<vector<int>> adj(V);

Memory: Array of vectors (scattered in heap)
Size: V × pointer + E × int
    = 100 × 8 + 500 × 4 = 2.8KB (V=100, E=500)
```

→ Adjacency List tiết kiệm nhiều với sparse graph!

=== DFS vs BFS - Stack vs Queue

*DFS (Stack):*
```
Visit A
Push B, C
Pop C
Visit C
Push D
Pop D
Visit D
Pop B
Visit B
```

*BFS (Queue):*
```
Visit A
Enqueue B, C
Dequeue B
Visit B
Enqueue D
Dequeue C
Visit C
Dequeue D
Visit D
```

#pagebreak()

== Lịch sử / Nguồn gốc

*1736: Seven Bridges of Königsberg*
- Leonhard Euler
- First graph theory problem!
- Bắt đầu của graph theory

*1956: Dijkstra's Algorithm*
- Edsger W. Dijkstra
- Shortest path algorithm

*1957: Prim's Algorithm*
- Robert Prim
- Minimum Spanning Tree

*1959: DFS Algorithm*
- Formalized for computer science

*Ngày nay:*
- Graph algorithms everywhere!
- Google Maps, Facebook, Netflix recommendations
- Network routing, Compilers, AI

#pagebreak()

== Phân tích thuật toán

Đã phân tích ở phần 2. Tóm tắt:

#table(
  columns: (1.5fr, 1.2fr, 1.2fr),
  align: (left, center, left),
  [*Algorithm*], [*Time*], [*Space*],
  [DFS], [O(V+E)], [O(V)],
  [BFS], [O(V+E)], [O(V)],
  [Dijkstra (Binary Heap)], [O((V+E) log V)], [O(V)],
  [Dijkstra (Array)], [O(V²)], [O(V)],
  [Prim (Binary Heap)], [O((V+E) log V)], [O(V)],
  [Kruskal], [O(E log E)], [O(V)],
)

#pagebreak()

== Minh họa từng bước

=== Dijkstra's Algorithm

```
Graph:
    A ─5─ B
    │3    │2
    C ─4─ D

Find shortest path from A to all:

Initial: dist = [0, ∞, ∞, ∞]  (A=0, B=1, C=2, D=3)
         prev = [-, -, -, -]

Step 1: Process A (dist=0)
  Update B: dist[B] = 0 + 5 = 5
  Update C: dist[C] = 0 + 3 = 3
  dist = [0, 5, 3, ∞]
  prev = [-, A, A, -]

Step 2: Process C (smallest dist=3)
  Update D: dist[D] = 3 + 4 = 7
  dist = [0, 5, 3, 7]
  prev = [-, A, A, C]

Step 3: Process B (dist=5)
  Update D: dist[D] = min(7, 5+2) = 7 (no change)

Step 4: Process D (dist=7)
  Done!

Results:
  A→A: 0
  A→B: 5 (path: A→B)
  A→C: 3 (path: A→C)
  A→D: 7 (path: A→C→D)
```

#pagebreak()

== Code minh họa C++

=== Graph Representation

```cpp
#include <iostream>
#include <vector>
#include <queue>
#include <stack>
#include <climits>
using namespace std;

// Adjacency List
class Graph {
private:
    int V;  // Number of vertices
    vector<vector<int>> adj;  // Adjacency list
    
public:
    Graph(int vertices) : V(vertices) {
        adj.resize(V);
    }
    
    void addEdge(int u, int v) {
        adj[u].push_back(v);
    }
    
    void addEdgeUndirected(int u, int v) {
        adj[u].push_back(v);
        adj[v].push_back(u);
    }
    
    // DFS Recursive
    void DFSUtil(int v, vector<bool>& visited) {
        visited[v] = true;
        cout << v << " ";
        
        for (int neighbor : adj[v]) {
            if (!visited[neighbor]) {
                DFSUtil(neighbor, visited);
            }
        }
    }
    
    void DFS(int start) {
        vector<bool> visited(V, false);
        DFSUtil(start, visited);
        cout << endl;
    }
    
    // DFS Iterative (with stack)
    void DFSIterative(int start) {
        vector<bool> visited(V, false);
        stack<int> s;
        
        s.push(start);
        
        while (!s.empty()) {
            int v = s.top();
            s.pop();
            
            if (!visited[v]) {
                visited[v] = true;
                cout << v << " ";
                
                // Push neighbors to stack
                for (auto it = adj[v].rbegin(); it != adj[v].rend(); ++it) {
                    if (!visited[*it]) {
                        s.push(*it);
                    }
                }
            }
        }
        cout << endl;
    }
    
    // BFS
    void BFS(int start) {
        vector<bool> visited(V, false);
        queue<int> q;
        
        visited[start] = true;
        q.push(start);
        
        while (!q.empty()) {
            int v = q.front();
            q.pop();
            cout << v << " ";
            
            for (int neighbor : adj[v]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    q.push(neighbor);
                }
            }
        }
        cout << endl;
    }
};

int main() {
    Graph g(5);
    
    g.addEdgeUndirected(0, 1);
    g.addEdgeUndirected(0, 2);
    g.addEdgeUndirected(1, 3);
    g.addEdgeUndirected(2, 3);
    g.addEdgeUndirected(3, 4);
    
    cout << "DFS from vertex 0: ";
    g.DFS(0);
    
    cout << "BFS from vertex 0: ";
    g.BFS(0);
    
    return 0;
}
```

=== Weighted Graph với Dijkstra

```cpp
class WeightedGraph {
private:
    int V;
    vector<vector<pair<int, int>>> adj;  // {neighbor, weight}
    
public:
    WeightedGraph(int vertices) : V(vertices) {
        adj.resize(V);
    }
    
    void addEdge(int u, int v, int weight) {
        adj[u].push_back({v, weight});
    }
    
    void addEdgeUndirected(int u, int v, int weight) {
        adj[u].push_back({v, weight});
        adj[v].push_back({u, weight});
    }
    
    vector<int> dijkstra(int source) {
        vector<int> dist(V, INT_MAX);
        vector<int> prev(V, -1);
        
        // Min heap: (distance, vertex)
        priority_queue<pair<int, int>, 
                       vector<pair<int, int>>,
                       greater<pair<int, int>>> pq;
        
        dist[source] = 0;
        pq.push({0, source});
        
        while (!pq.empty()) {
            int d = pq.top().first;
            int u = pq.top().second;
            pq.pop();
            
            // Skip if already processed
            if (d > dist[u]) continue;
            
            // Relax edges
            for (auto& [v, weight] : adj[u]) {
                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    prev[v] = u;
                    pq.push({dist[v], v});
                }
            }
        }
        
        return dist;
    }
    
    void printPath(int source, int dest, vector<int>& prev) {
        if (dest == source) {
            cout << source;
            return;
        }
        if (prev[dest] == -1) {
            cout << "No path";
            return;
        }
        
        printPath(source, prev[dest], prev);
        cout << " → " << dest;
    }
};

int main() {
    WeightedGraph g(4);
    
    g.addEdgeUndirected(0, 1, 5);
    g.addEdgeUndirected(0, 2, 3);
    g.addEdgeUndirected(1, 3, 2);
    g.addEdgeUndirected(2, 3, 4);
    
    cout << "Dijkstra from vertex 0:" << endl;
    vector<int> dist = g.dijkstra(0);
    
    for (int i = 0; i < 4; i++) {
        cout << "Distance to " << i << ": " << dist[i] << endl;
    }
    
    return 0;
}
```

*Output:*
```
Dijkstra from vertex 0:
Distance to 0: 0
Distance to 1: 5
Distance to 2: 3
Distance to 3: 7
```

#pagebreak()

== Lỗi phổ biến

*1. DFS - Quên đánh dấu visited*

```cpp
// ❌ SAI: Infinite loop nếu có cycle
void DFS(int v) {
    cout << v << " ";
    for (int neighbor : adj[v]) {
        DFS(neighbor);  // Có thể quay lại v → Vô tận!
    }
}

// ✅ ĐÚNG
void DFS(int v, vector<bool>& visited) {
    visited[v] = true;
    cout << v << " ";
    for (int neighbor : adj[v]) {
        if (!visited[neighbor]) {
            DFS(neighbor, visited);
        }
    }
}
```

*2. Dijkstra - Dùng với negative weights*

```cpp
// ❌ SAI: Dijkstra KHÔNG hoạt động với negative weights!
// Cần dùng Bellman-Ford thay thế
```

*3. BFS - Quên check visited trước enqueue*

```cpp
// ❌ SAI: Enqueue nhiều lần
for (int neighbor : adj[v]) {
    if (!visited[neighbor]) {
        q.push(neighbor);
        // Quên: visited[neighbor] = true;
    }
}

// ✅ ĐÚNG: Mark visited ngay khi enqueue
for (int neighbor : adj[v]) {
    if (!visited[neighbor]) {
        visited[neighbor] = true;  // Mark trước
        q.push(neighbor);
    }
}
```

#pagebreak()

== Khi nào dùng / không dùng

=== Matrix vs List

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  align: (left, left, left),
  [*Tiêu chí*], [*Adjacency Matrix*], [*Adjacency List*],
  [*Space*], [O(V²) - Dense/Sparse], [O(V+E) - Better for sparse],
  [*Check edge*], [O(1)], [O(degree)],
  [*Get neighbors*], [O(V)], [O(degree)],
  [*Add edge*], [O(1)], [O(1)],
  [*Remove edge*], [O(1)], [O(degree)],
  [*Best for*], [Dense graph, E ≈ V²], [Sparse graph, E << V²],
)

*Khi nào dùng Matrix:*
- Dense graph (nhiều edges)
- Cần check edge frequently
- V nhỏ (< 1000)

*Khi nào dùng List:*
- Sparse graph (ít edges) - Phổ biến trong thực tế!
- V lớn
- Cần iterate neighbors

=== DFS vs BFS

#table(
  columns: (1fr, 1.5fr, 1.5fr),
  align: (left, left, left),
  [*Tiêu chí*], [*DFS*], [*BFS*],
  [*Data structure*], [Stack/Recursion], [Queue],
  [*Path found*], [Any path], [Shortest path (unweighted)],
  [*Memory*], [O(h) - h=depth], [O(w) - w=width],
  [*Use cases*], [Topological sort, Cycle detection], [Shortest path, Level-order],
)

#pagebreak()

== Ứng dụng thực tế

*1. Social Networks (Facebook):*

```cpp
// Friend suggestions: BFS
vector<int> suggestFriends(int userID, Graph& network) {
    // Friends of friends (level 2)
    vector<int> suggestions;
    vector<bool> visited(network.V, false);
    queue<pair<int, int>> q;  // (vertex, level)
    
    q.push({userID, 0});
    visited[userID] = true;
    
    while (!q.empty()) {
        auto [v, level] = q.front();
        q.pop();
        
        if (level == 2) {
            suggestions.push_back(v);
        }
        
        if (level < 2) {
            for (int friend : network.adj[v]) {
                if (!visited[friend]) {
                    visited[friend] = true;
                    q.push({friend, level + 1});
                }
            }
        }
    }
    
    return suggestions;
}
```

*2. GPS Navigation (Google Maps):*

```cpp
// Shortest path from home to work
vector<int> path = dijkstra(cityGraph, home, work);

// Alternative routes
vector<vector<int>> alternatives = kShortestPaths(cityGraph, home, work, 3);

// Avoid tolls/highways
Graph filteredGraph = removeEdges(cityGraph, tollRoads);
```

*3. Web Crawler:*

```cpp
void crawlWeb(string startURL) {
    Graph web;
    queue<string> q;
    set<string> visited;
    
    q.push(startURL);
    visited.insert(startURL);
    
    while (!q.empty()) {
        string url = q.front();
        q.pop();
        
        downloadPage(url);
        
        for (string link : extractLinks(url)) {
            if (visited.find(link) == visited.end()) {
                visited.insert(link);
                q.push(link);
                web.addEdge(url, link);
            }
        }
    }
}
```

*4. Compiler - Dependency Resolution:*

```cpp
// Topological sort để compile files theo đúng thứ tự
vector<string> compileOrder = topologicalSort(dependencyGraph);

// file1.cpp depends on file2.h
// file2.h depends on file3.h
// → Compile: file3.h → file2.h → file1.cpp
```

*5. Network Routing:*

```cpp
// Find best route for data packet
vector<int> route = dijkstra(networkGraph, sourceRouter, destRouter);

// Load balancing: Find K shortest paths
// Fault tolerance: Find alternative paths
```

#pagebreak()

== Tóm tắt

*Điểm quan trọng:*

1. *Graph G = (V, E):*
   - Vertices (đỉnh) và Edges (cạnh)
   - Directed/Undirected, Weighted/Unweighted

2. *Representations:*
   - Matrix: O(V²) space, O(1) check edge
   - List: O(V+E) space, O(degree) check edge
   - List tốt hơn cho sparse graph (thực tế)

3. *Traversals:*
   - DFS: Stack/Recursion, O(V+E), deep first
   - BFS: Queue, O(V+E), level-by-level

4. *Shortest Path:*
   - Unweighted: BFS
   - Weighted (positive): Dijkstra O((V+E) log V)
   - Weighted (negative): Bellman-Ford O(VE)

5. *Minimum Spanning Tree:*
   - Prim: O((V+E) log V)
   - Kruskal: O(E log E)

6. *Applications:*
   - Social networks
   - Maps/GPS
   - Web (PageRank)
   - Networks
   - Compilers
   - Games (pathfinding)

7. *Lỗi thường gặp:*
   - Quên visited → Infinite loop
   - Dijkstra với negative weights
   - BFS không mark visited khi enqueue

8. *Graph = Most versatile structure:*
   - Tree là special case của Graph
   - Có thể model hầu hết mọi thứ

9. *Complexity:*
   - Traversals: O(V+E)
   - Shortest path: O((V+E) log V)
   - MST: O(E log V)

10. *C++ Implementation:*
    - `vector<vector<int>>` cho adjacency list
    - `priority_queue` cho Dijkstra
    - `queue` cho BFS, `stack` cho DFS

#pagebreak()
