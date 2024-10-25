Classes in C++ are the blueprint for creating objects. A class encapsulates data for the object and methods to manipulate that data. Here's a detailed guide on how to define and use classes in C++.

### 1. Defining a Class

A class definition starts with the keyword `class`, followed by the class name and the class body enclosed in braces `{}`. The class body can contain data members (variables) and member functions (methods).

```cpp
#include <iostream>
using namespace std;

class Person {
private:
    string name;
    int age;

public:
    // Constructor
    Person(string n, int a) {
        name = n;
        age = a;
    }

    // Member function to set the name
    void setName(string n) {
        name = n;
    }

    // Member function to get the name
    string getName() {
        return name;
    }

    // Member function to set the age
    void setAge(int a) {
        age = a;
    }

    // Member function to get the age
    int getAge() {
        return age;
    }

    // Member function to display person details
    void display() {
        cout << "Name: " << name << ", Age: " << age << endl;
    }
};

int main() {
    // Creating an object of the Person class
    Person person1("John", 25);
    person1.display();

    // Modifying object properties
    person1.setName("Doe");
    person1.setAge(30);
    person1.display();

    return 0;
}
```

### 2. Constructors and Destructors

- **Constructor:** A special member function that is called when an object is instantiated. It usually initializes the object's data members.
- **Destructor:** A special member function that is called when an object is destroyed. It usually cleans up resources used by the object.

```cpp
#include <iostream>
using namespace std;

class Sample {
private:
    int data;

public:
    // Constructor
    Sample(int d) : data(d) {
        cout << "Constructor called, data = " << data << endl;
    }

    // Destructor
    ~Sample() {
        cout << "Destructor called, data = " << data << endl;
    }
};

int main() {
    Sample obj1(10); // Constructor is called here
    {
        Sample obj2(20); // Constructor is called here
    } // Destructor for obj2 is called here
    // Destructor for obj1 is called here
    return 0;
}
```

### 3. Member Functions and Access Specifiers

- **Access Specifiers:** Control the access to class members. C++ provides three access specifiers:
  - `public`: Members are accessible from outside the class.
  - `private`: Members are accessible only within the class.
  - `protected`: Members are accessible within the class and by derived classes.

### 4. Inheritance

Inheritance allows a class (derived class) to inherit properties and methods from another class (base class).

```cpp
#include <iostream>
using namespace std;

// Base class
class Animal {
public:
    void eat() {
        cout << "I can eat!" << endl;
    }
};

// Derived class
class Dog : public Animal {
public:
    void bark() {
        cout << "I can bark!" << endl;
    }
};

int main() {
    Dog dog;
    dog.eat(); // Base class method
    dog.bark(); // Derived class method
    return 0;
}
```

### 5. Polymorphism

Polymorphism allows for methods to perform different tasks based on the object that calls them.

```cpp
#include <iostream>
using namespace std;

class Base {
public:
    virtual void show() {
        cout << "Base class show function" << endl;
    }
};

class Derived : public Base {
public:
    void show() override {
        cout << "Derived class show function" << endl;
    }
};

int main() {
    Base* b;
    Derived d;
    b = &d;
    b->show(); // Calls Derived class show function
    return 0;
}
```

### Conclusion

Classes in C++ are a fundamental part of Object-Oriented Programming, providing a way to model real-world entities and their interactions. They encapsulate data and functions, support inheritance, and enable polymorphism, making C++ a powerful language for developing complex applications.