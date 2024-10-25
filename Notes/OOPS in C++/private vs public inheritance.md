In C++, when you inherit from a base class, you can specify how the derived class inherits the members (methods and data) of the base class using different access specifiers: `public`, `protected`, and `private`. Here’s how `public` and `private` inheritance work:

==private by default ==

### Public Inheritance

In public inheritance:
- **Public members** of the base class remain public in the derived class.
- **Protected members** of the base class remain protected in the derived class.
- **Private members** of the base class are not accessible directly in the derived class.

Here’s an example to illustrate public inheritance:

```cpp
#include <iostream>
using namespace std;

// Base class
class Base {
public:
    int publicMember;
protected:
    int protectedMember;
private:
    int privateMember;
};

// Derived class with public inheritance
class DerivedPublic : public Base {
public:
    void display() {
        publicMember = 10; // Accessible
        protectedMember = 20; // Accessible
        // privateMember = 30; // Error: privateMember is not accessible
        cout << "Public Member: " << publicMember << endl;
        cout << "Protected Member: " << protectedMember << endl;
    }
};

int main() {
    DerivedPublic obj;
    obj.display();
    return 0;
}
```

### Private Inheritance

In private inheritance:
- **Public members** of the base class become private in the derived class.
- **Protected members** of the base class become private in the derived class.
- **Private members** of the base class are not accessible directly in the derived class.

Here’s an example to illustrate private inheritance:

```cpp
#include <iostream>
using namespace std;

// Base class
class Base {
public:
    int publicMember;
protected:
    int protectedMember;
private:
    int privateMember;
};

// Derived class with private inheritance
class DerivedPrivate : private Base {
public:
    void display() {
        publicMember = 10; // Accessible (treated as private)
        protectedMember = 20; // Accessible (treated as private)
        // privateMember = 30; // Error: privateMember is not accessible
        cout << "Public Member: " << publicMember << endl;
        cout << "Protected Member: " << protectedMember << endl;
    }
};

int main() {
    DerivedPrivate obj;
    obj.display();
    // obj.publicMember; // Error: publicMember is now private in DerivedPrivate
    return 0;
}
```

### When to Use Public vs Private Inheritance

- **Public Inheritance:** Use when you want the derived class to have an "is-a" relationship with the base class. That is, every derived class object is also a base class object. For example, `DerivedPublic` "is-a" `Base`.
  
- **Private Inheritance:** Use when you want to reuse implementation rather than interface. It is used when you want to implement "has-a" relationship. For example, `DerivedPrivate` "has-a" `Base`.

### Summary

- **Public Inheritance:** Maintains the accessibility of base class members as they are in the derived class, preserving their original access level.
  
- **Private Inheritance:** Changes the accessibility of base class members to private in the derived class, effectively hiding the base class interface and implementing it as part of the derived class implementation.

Understanding these concepts helps in designing classes and hierarchies effectively, ensuring proper encapsulation and reuse of code in object-oriented programming.