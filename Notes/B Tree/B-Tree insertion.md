[[B-Tree]]

To implement the insertion process in a B-tree, follow these steps:

1. **Find the appropriate leaf** where the key should be inserted by traversing the tree from the root.
2. **Insert the key** into the node in sorted order.
3. If the node **overflows** (i.e., has more keys than allowed), **split** the node into two:
   - The middle key moves up to the parent.
   - The two halves form two separate nodes.
4. If the parent node also overflows, repeat the split process recursively up to the root.
5. If the root splits, create a new root with the middle key, increasing the tree's height.

Here is a C++ implementation of the B-tree insertion process:

```cpp
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class BTreeNode {
public:
    vector<int> keys;         // Holds keys
    vector<BTreeNode*> children;  // Pointers to child nodes
    int t;                    // Minimum degree (defines the range for number of keys)
    bool leaf;                // Is true when the node is a leaf

    BTreeNode(int _t, bool _leaf);

    void insertNonFull(int k);
    void splitChild(int i, BTreeNode* y);
    void traverse();

    friend class BTree;
};

class BTree {
public:
    BTreeNode* root;
    int t;

    BTree(int _t) {
        root = nullptr;
        t = _t;
    }

    void traverse() {
        if (root != nullptr) root->traverse();
    }

    void insert(int k);
};

BTreeNode::BTreeNode(int _t, bool _leaf) {
    t = _t;
    leaf = _leaf;
}

void BTreeNode::traverse() {
    int i;
    for (i = 0; i < keys.size(); i++) {
        if (!leaf)
            children[i]->traverse();
        cout << " " << keys[i];
    }
    if (!leaf)
        children[i]->traverse();
}

void BTreeNode::insertNonFull(int k) {
    int i = keys.size() - 1;

    if (leaf) {
        keys.push_back(k);
        while (i >= 0 && keys[i] > k) {
            keys[i + 1] = keys[i];
            i--;
        }
        keys[i + 1] = k;
    } else {
        while (i >= 0 && keys[i] > k)
            i--;

        if (children[i + 1]->keys.size() == 2 * t - 1) {
            splitChild(i + 1, children[i + 1]);

            if (keys[i + 1] < k)
                i++;
        }
        children[i + 1]->insertNonFull(k);
    }
}

void BTreeNode::splitChild(int i, BTreeNode* y) {
    BTreeNode* z = new BTreeNode(y->t, y->leaf);
    for (int j = 0; j < t - 1; j++)
        z->keys.push_back(y->keys[j + t]);

    if (!y->leaf) {
        for (int j = 0; j < t; j++)
            z->children.push_back(y->children[j + t]);
    }

    y->keys.resize(t - 1);
    y->children.resize(t);

    children.insert(children.begin() + i + 1, z);
    keys.insert(keys.begin() + i, y->keys[t - 1]);
}

void BTree::insert(int k) {
    if (root == nullptr) {
        root = new BTreeNode(t, true);
        root->keys.push_back(k);
    } else {
        if (root->keys.size() == 2 * t - 1) {
            BTreeNode* s = new BTreeNode(t, false);
            s->children.push_back(root);
            s->splitChild(0, root);
            int i = 0;
            if (s->keys[0] < k)
                i++;
            s->children[i]->insertNonFull(k);
            root = s;
        } else {
            root->insertNonFull(k);
        }
    }
}

int main() {
    BTree t(3);
    t.insert(10);
    t.insert(20);
    t.insert(5);
    t.insert(6);
    t.insert(12);
    t.insert(30);
    t.insert(7);
    t.insert(17);

    cout << "Traversal of the constructed B-tree is: ";
    t.traverse();

    return 0;
}
```

### Explanation:

- **BTreeNode Class**: Represents a node in the B-tree. Contains methods to insert a key into a non-full node and split a child when a node overflows.
- **BTree Class**: Manages the B-tree, handling insertion and traversal.
- **insert()**: Starts the insertion process. If the root is full, it splits the root and creates a new root.
- **insertNonFull()**: Inserts a key into a node that is guaranteed to be non-full.
- **splitChild()**: Splits a full child node and promotes the middle key to the parent node.

This example demonstrates how to build a B-tree and insert keys into it. The tree is traversed at the end to show the keys in order.