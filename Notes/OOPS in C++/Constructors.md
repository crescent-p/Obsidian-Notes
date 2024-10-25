Constructors in C++ are special member functions of a class that are executed whenever new objects of the class are created. They initialize the object's properties. Constructors have the same name as the class and do not have a return type, not even `void`.

### Types of Constructors

1. **Default Constructor**
2. **Parameterized Constructor**
3. **Copy Constructor**
4. **Move Constructor** (C++11)

### 1. Default Constructor

A default constructor does not take any arguments. If no constructors are defined in a class, the compiler automatically provides a default constructor.

```cpp
#include <iostream>
using namespace std;

class DefaultConstructorExample {
public:
    int value;

    // Default Constructor
    DefaultConstructorExample() {
        value = 0;
        cout << "Default constructor called, value = " << value << endl;
    }
};

int main() {
    DefaultConstructorExample obj;
    return 0;
}
```

### 2. Parameterized Constructor

A parameterized constructor takes arguments and initializes the object with specific values.

```cpp
#include <iostream>
using namespace std;

class ParameterizedConstructorExample {
public:
    int value;

    // Parameterized Constructor
    ParameterizedConstructorExample(int v) {
        value = v;
        cout << "Parameterized constructor called, value = " << value << endl;
    }
};

int main() {
    ParameterizedConstructorExample obj(10);
    return 0;
}
```

### 3. Copy Constructor

A copy constructor initializes an object using another object of the same class. It is usually invoked when an object is passed by value, returned from a function, or explicitly copied.

```cpp
#include <iostream>
using namespace std;

class CopyConstructorExample {
public:
    int value;

    // Parameterized Constructor
    CopyConstructorExample(int v) {
        value = v;
    }

    // Copy Constructor
    CopyConstructorExample(const CopyConstructorExample &obj) {
        value = obj.value;
        cout << "Copy constructor called, value = " << value << endl;
    }
};

int main() {
    CopyConstructorExample obj1(10);
    CopyConstructorExample obj2 = obj1; // Copy constructor is called
    return 0;
}
```

### 4. Move Constructor (C++11)

A move constructor transfers resources from a temporary object (rvalue) to a new object. This is useful for optimizing the performance of code that involves heavy object copying.

```cpp
#include <iostream>
using namespace std;

class MoveConstructorExample {
public:
    int* value;

    // Parameterized Constructor
    MoveConstructorExample(int v) {
        value = new int(v);
        cout << "Parameterized constructor called, value = " << *value << endl;
    }

    // Move Constructor
    MoveConstructorExample(MoveConstructorExample &&obj) noexcept {
        value = obj.value;
        obj.value = nullptr;
        cout << "Move constructor called" << endl;
    }

    // Destructor
    ~MoveConstructorExample() {
        delete value;
        cout << "Destructor called" << endl;
    }
};

int main() {
    MoveConstructorExample obj1(10);
    MoveConstructorExample obj2 = move(obj1); // Move constructor is called
    return 0;
}
```

### Explicit Keyword

The `explicit` keyword can be used to prevent implicit conversions or copy-initialization. This is useful to avoid unexpected conversions.

```cpp
#include <iostream>
using namespace std;

class ExplicitConstructorExample {
public:
    int value;

    // Explicit Constructor
    explicit ExplicitConstructorExample(int v) {
        value = v;
    }
};

int main() {
    ExplicitConstructorExample obj1(10); // OK
    // ExplicitConstructorExample obj2 = 20; // Error: Conversion from int to ExplicitConstructorExample is not allowed
    return 0;
}
```

### Constructor Initialization List

Constructors can use an initialization list to initialize data members. This is especially useful for initializing const members or members that are classes with no default constructor.

```cpp
#include <iostream>
using namespace std;

class InitializationListExample {
public:
    int x;
    const int y;

    // Constructor Initialization List
    InitializationListExample(int a, int b) : x(a), y(b) {
        cout << "Constructor called, x = " << x << ", y = " << y << endl;
    }
};

int main() {
    InitializationListExample obj(10, 20);
    return 0;
}
```

### Conclusion

Constructors in C++ are fundamental for initializing objects in a controlled manner. Understanding different types of constructors and their usage helps in writing robust and efficient C++ programs.