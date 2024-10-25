In C++, an abstract class is a class that cannot be instantiated on its own and is designed to be inherited by other classes. Abstract classes are used to define interfaces or base classes with at least one pure virtual function. A pure virtual function is a function that has no implementation in the base class and must be overridden by derived classes.

### Defining an Abstract Class

An abstract class is defined by including at least one pure virtual function. A pure virtual function is declared by assigning 0 to the function declaration.

### Example of an Abstract Class

```cpp
#include <iostream>
using namespace std;

class Shape {
public:
    // Pure virtual function
    virtual void draw() const = 0;

    // Virtual destructor to ensure proper cleanup of derived class objects
    virtual ~Shape() {}
};

class Circle : public Shape {
public:
    void draw() const override {
        cout << "Drawing Circle" << endl;
    }
};

class Square : public Shape {
public:
    void draw() const override {
        cout << "Drawing Square" << endl;
    }
};

int main() {
    // Shape shape; // Error: Cannot instantiate an abstract class

    Circle circle;
    Square square;

    Shape* shapes[] = {&circle, &square};
    for (Shape* shape : shapes) {
        shape->draw();
    }

    return 0;
}
```

### Explanation

1. **Abstract Class:** `Shape` is an abstract class because it has a pure virtual function `draw()`.
2. **Pure Virtual Function:** The `draw()` function is declared with `= 0`, making it a pure virtual function.
3. **Derived Classes:** `Circle` and `Square` are derived from `Shape` and provide implementations for the `draw()` function.
4. **Instantiation:** You cannot create an instance of the `Shape` class directly because it is abstract.
5. **Polymorphism:** The `draw()` function is called on objects of derived classes through a base class pointer, demonstrating polymorphism.

### Why Use Abstract Classes?

1. **Interface Definition:** Abstract classes allow you to define a common interface for all derived classes.
2. **Polymorphism:** They enable polymorphic behavior, allowing you to write code that works with objects of different classes through a common interface.
3. **Enforcement:** They enforce that derived classes provide specific implementations for certain functions.

### Additional Notes

- **Pure Virtual Destructor:** If a class has a pure virtual destructor, it must provide a definition for it. This is because destructors are always called in the reverse order of construction, and the base class destructor must be callable.
  
  ```cpp
  class Base {
  public:
      virtual ~Base() = 0; // Pure virtual destructor
  };

  Base::~Base() {
      // Destructor definition
  }
  ```

- **Concrete Methods:** An abstract class can have concrete (non-virtual) methods and member variables like any other class. Derived classes inherit these members and can use or override them as needed.

### Example with a Pure Virtual Destructor

```cpp
#include <iostream>
using namespace std;

class AbstractBase {
public:
    // Pure virtual function
    virtual void display() const = 0;

    // Pure virtual destructor
    virtual ~AbstractBase() = 0;
};

// Definition of pure virtual destructor
AbstractBase::~AbstractBase() {
    cout << "AbstractBase destructor called" << endl;
}

class Derived : public AbstractBase {
public:
    void display() const override {
        cout << "Derived display called" << endl;
    }

    ~Derived() {
        cout << "Derived destructor called" << endl;
    }
};

int main() {
    AbstractBase* obj = new Derived();
    obj->display();
    delete obj;

    return 0;
}
```

In this example, the `AbstractBase` class has a pure virtual destructor, which ensures proper cleanup of derived class objects. The `Derived` class implements the `display` method and the destructor, and the program demonstrates polymorphic behavior and proper destructor calls.