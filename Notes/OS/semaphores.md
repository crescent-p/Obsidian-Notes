Semaphores are synchronization tools used in operating systems to control access to shared resources by multiple processes. They help prevent race conditions, where multiple processes or threads attempt to access and modify shared data simultaneously, potentially leading to inconsistent or incorrect results. Semaphores can be categorized into two types: binary semaphores and counting semaphores.

### Types of Semaphores

1. **Binary Semaphores (Mutexes):**
   - **Value:** Can only be 0 or 1.
   - **Purpose:** Often used to manage access to a single resource or a critical section.
   - **Operations:**
     - **wait (P operation):** Decreases the semaphore value. If the value is already 0, the process is blocked until the semaphore value becomes positive.
     - **signal (V operation):** Increases the semaphore value, potentially unblocking a waiting process.

2. **Counting Semaphores:**
   - **Value:** Can be any non-negative integer.
   - **Purpose:** Used to manage access to a pool of resources (e.g., a fixed number of identical resources).
   - **Operations:**
     - **wait (P operation):** Decreases the semaphore value. If the value is 0, the process is blocked until the semaphore value becomes positive.
     - **signal (V operation):** Increases the semaphore value, potentially unblocking a waiting process.

### Basic Operations

1. **wait (P operation):**
   ```cpp
   void wait(Semaphore &s) {
       while (s.value <= 0);  // Busy wait
       s.value--;
   }
   ```

2. **signal (V operation):**
   ```cpp
   void signal(Semaphore &s) {
       s.value++;
   }
   ```

### Usage Example in C++

Here’s a simple example of using semaphores to synchronize two threads:

```cpp
#include <iostream>
#include <thread>
#include <semaphore.h>

sem_t semaphore;

void threadFunction1() {
    sem_wait(&semaphore);  // Wait for semaphore to be non-zero
    std::cout << "Thread 1: Entered critical section\n";
    std::this_thread::sleep_for(std::chrono::seconds(1));
    std::cout << "Thread 1: Exiting critical section\n";
    sem_post(&semaphore);  // Increment semaphore value
}

void threadFunction2() {
    sem_wait(&semaphore);  // Wait for semaphore to be non-zero
    std::cout << "Thread 2: Entered critical section\n";
    std::this_thread::sleep_for(std::chrono::seconds(1));
    std::cout << "Thread 2: Exiting critical section\n";
    sem_post(&semaphore);  // Increment semaphore value
}

int main() {
    sem_init(&semaphore, 0, 1);  // Initialize semaphore with value 1

    std::thread t1(threadFunction1);
    std::thread t2(threadFunction2);

    t1.join();
    t2.join();

    sem_destroy(&semaphore);  // Clean up semaphore
    return 0;
}
```

### Practical Considerations

- **Avoid Busy Waiting:** The example above uses busy waiting in the `wait` function. In practice, semaphores provided by OS libraries handle blocking and waking up processes efficiently.
- **Deadlock:** Careful design is necessary to avoid deadlock, where two or more processes are waiting indefinitely for each other to release resources.
- **Priority Inversion:** This occurs when a lower-priority task holds a semaphore needed by a higher-priority task, potentially causing priority inversion problems. Some systems implement priority inheritance protocols to mitigate this.

Semaphores are a fundamental concept in concurrent programming and operating systems, providing a mechanism to synchronize access to shared resources safely and efficiently.