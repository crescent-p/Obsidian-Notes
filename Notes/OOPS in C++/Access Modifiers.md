Access modifiers in C++ are keywords that set the accessibility of class members. They define the level of access control and restrict or allow the use of data members and member functions. The three main access modifiers in C++ are `public`, `protected`, and `private`.

### 1. Public

Members declared as `public` are accessible from anywhere in the program where the object is visible. Both member functions and variables can be accessed.

```cpp
#include <iostream>
using namespace std;

class PublicExample {
public:
    int publicData;

    void display() {
        cout << "Public data: " << publicData << endl;
    }
};

int main() {
    PublicExample obj;
    obj.publicData = 5;
    obj.display();
    return 0;
}
```

### 2. Protected

Members declared as `protected` are accessible within the class itself, by derived classes, but not from outside the class. This is useful for inheritance.

```cpp
#include <iostream>
using namespace std;

class Base {
protected:
    int protectedData;

public:
    void setProtectedData(int data) {
        protectedData = data;
    }
};

class Derived : public Base {
public:
    void display() {
        cout << "Protected data: " << protectedData << endl;
    }
};

int main() {
    Derived obj;
    obj.setProtectedData(10);
    obj.display();
    return 0;
}
```

### 3. Private

Members declared as `private` are accessible only within the class itself. They cannot be accessed directly from outside the class or by derived classes.

```cpp
#include <iostream>
using namespace std;

class PrivateExample {
private:
    int privateData;

public:
    void setPrivateData(int data) {
        privateData = data;
    }

    void display() {
        cout << "Private data: " << privateData << endl;
    }
};

int main() {
    PrivateExample obj;
    obj.setPrivateData(15);
    obj.display();
    return 0;
}
```

### Example of Using All Three Access Modifiers

```cpp
#include <iostream>
using namespace std;

class Example {
public:
    int publicData;

protected:
    int protectedData;

private:
    int privateData;

public:
    // Constructor to initialize all members
    Example(int pub, int prot, int priv) {
        publicData = pub;
        protectedData = prot;
        privateData = priv;
    }

    void display() {
        cout << "Public data: " << publicData << endl;
        cout << "Protected data: " << protectedData << endl;
        cout << "Private data: " << privateData << endl;
    }
};

class DerivedExample : public Example {
public:
    DerivedExample(int pub, int prot, int priv) : Example(pub, prot, priv) {}

    void displayDerived() {
        cout << "Public data: " << publicData << endl;
        cout << "Protected data: " << protectedData << endl;
        // Private data is not accessible here
    }
};

int main() {
    Example obj(1, 2, 3);
    obj.display();

    DerivedExample derivedObj(4, 5, 6);
    derivedObj.displayDerived();
    return 0;
}
```

### Conclusion

Access modifiers in C++ control the visibility and accessibility of class members. Proper use of these modifiers ensures encapsulation, protecting the internal state of an object while allowing controlled access to its behavior and state.