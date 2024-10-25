A [[B-tree]] is a self-balancing tree data structure that maintains sorted data and allows for efficient insertion, deletion, and search operations. It's commonly used in databases and file systems to manage large amounts of data that cannot fit into memory. 

### Key Properties of B-trees:
1. **Balanced**: All leaf nodes are at the same depth, ensuring that the tree remains balanced.
2. **Nodes**: Each node contains multiple keys and child pointers.
3. **Order**: The order \(m\) of a B-tree defines the maximum number of children a node can have. A node can have at most \(m - 1\) keys.
4. **Search, Insertion, Deletion**: Operations are performed in logarithmic time, making B-trees efficient for managing large datasets.

### Structure of a B-tree of Order \(m\):
- Each node has between \(\lceil m/2 \rceil\) and \(m\) children (except for the root, which can have fewer).
- Each non-leaf node with \(k\) children has \(k - 1\) keys.
- All leaf nodes are at the same level.

### Example of a B-tree of Order 3 (Ternary B-tree):
- A node can have 1 or 2 keys and 2 or 3 children.
- The keys within a node are sorted.
- Child nodes' keys are separated by the parent node's keys.

### Basic Operations:
1. **Search**: Begin at the root and recursively descend the tree, choosing the child whose range contains the desired key.
2. **Insertion**: Insert a key into a node. If the node overflows (i.e., it has more than \(m - 1\) keys), split the node into two and push the middle key up to the parent node.
3. **Deletion**: Deletion may require borrowing keys from sibling nodes or merging nodes to maintain the B-tree properties.

B-trees are particularly useful in scenarios where data is too large to fit into memory, as they minimize the number of disk reads required during operations.