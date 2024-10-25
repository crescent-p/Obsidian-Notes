Getters and setters in C++ are member functions that provide controlled access to an object's data members. Getters retrieve the value of private members, while setters modify the value. Using getters and setters promotes encapsulation, a core principle of Object-Oriented Programming (OOP).

### Example of Getters and Setters

Let's create a simple `Rectangle` class with private data members `length` and `width` and provide public getter and setter methods for these members.

```cpp
#include <iostream>
using namespace std;

class Rectangle {
private:
    double length;
    double width;

public:
    // Setter for length
    void setLength(double len) {
        if (len > 0) {
            length = len;
        } else {
            cout << "Length should be positive." << endl;
        }
    }

    // Getter for length
    double getLength() const {
        return length;
    }

    // Setter for width
    void setWidth(double wid) {
        if (wid > 0) {
            width = wid;
        } else {
            cout << "Width should be positive." << endl;
        }
    }

    // Getter for width
    double getWidth() const {
        return width;
    }

    // Function to calculate area
    double area() const {
        return length * width;
    }
};

int main() {
    Rectangle rect;
    
    // Setting values using setters
    rect.setLength(10.0);
    rect.setWidth(5.0);

    // Getting values using getters
    cout << "Length: " << rect.getLength() << endl;
    cout << "Width: " << rect.getWidth() << endl;

    // Calculating area
    cout << "Area: " << rect.area() << endl;

    return 0;
}
```

### Why Use Getters and Setters?

1. **Encapsulation:** They allow you to hide the internal state of an object and control how the internal data is accessed or modified.
2. **Validation:** Setters can include validation logic to ensure the integrity of the data.
3. **Read-Only Access:** Getters can provide read-only access to private data members.
4. **Maintainability:** Changing the internal representation of a class doesn't affect the code that uses the class if you use getters and setters.

### Read-Only and Write-Only Properties

You can create read-only or write-only properties by providing only a getter or a setter, respectively.

**Read-Only Property Example:**

```cpp
#include <iostream>
using namespace std;

class Circle {
private:
    double radius;

public:
    // Constructor
    Circle(double r) : radius(r) {}

    // Getter for radius (read-only)
    double getRadius() const {
        return radius;
    }

    // Function to calculate area
    double area() const {
        return 3.14159 * radius * radius;
    }
};

int main() {
    Circle circ(5.0);
    cout << "Radius: " << circ.getRadius() << endl;
    cout << "Area: " << circ.area() << endl;

    // circ.setRadius(10.0); // Error: No setter available
    return 0;
}
```

**Write-Only Property Example:**

```cpp
#include <iostream>
using namespace std;

class Password {
private:
    string password;

public:
    // Setter for password (write-only)
    void setPassword(const string& pwd) {
        if (pwd.length() >= 8) {
            password = pwd;
        } else {
            cout << "Password must be at least 8 characters long." << endl;
        }
    }

    // Function to check password (just for demonstration)
    bool checkPassword(const string& pwd) const {
        return password == pwd;
    }
};

int main() {
    Password pwdManager;
    pwdManager.setPassword("securepassword");

    // cout << "Password: " << pwdManager.getPassword(); // Error: No getter available

    if (pwdManager.checkPassword("securepassword")) {
        cout << "Password match" << endl;
    } else {
        cout << "Password does not match" << endl;
    }

    return 0;
}
```

### Conclusion

Getters and setters are essential tools in C++ for managing access to the private data members of a class. They provide a way to encapsulate the internal state, enforce validation rules, and enhance maintainability. By using getters and setters, you can ensure that your class's internal state is always valid and consistent.