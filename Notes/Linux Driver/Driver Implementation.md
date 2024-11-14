kernel = schedule / manage hardware

kernel stored in ssd as a file. 
loaded into dram and executed in cpu.

linux kernel are loaded on bootup after ROM and DRAM initialization.

dtb = device tree blob. A data structure that stores all the connected devices.

A **Device Tree Blob** (DTB) is a binary file containing hardware configuration information that the Linux kernel uses to initialize and manage hardware on systems.

**Boot Process**:

- During boot, the bootloader (e.g., U-Boot) loads both the kernel and the DTB file into memory.
- The kernel reads the DTB to configure and interact with the hardware correctly.

**Device Tree Structure**:

- The **Device Tree** is structured hierarchically, similar to a file system, where nodes represent hardware components like CPUs, memory, and peripherals.
- Each node has properties (key-value pairs) describing its configuration, addresses, and other settings.


The memory address of dtb is stored in cpu register, the bootloader loads the dtb and passes the value to cpu register.

User space, Kernel Space, 

**User Space** and **Kernel Space** are two distinct memory areas in a Linux operating system, designed to separate regular applications from critical kernel operations. This division ensures system stability, security, and performance by isolating user applications from core system functions.

### Kernel Space
- **Definition**: A privileged area of memory where the Linux kernel and its core functions operate. It has direct access to all hardware resources and memory addresses.
- **Purpose**: Manages all low-level tasks, including process scheduling, memory management, device drivers, and system calls.
- **Access**: Only the kernel and authorized drivers/modules can access this space. Direct access is restricted to prevent accidental system crashes or security issues.
- **Example Functions**: System calls (such as `open`, `read`, `write`), memory management, I/O control, and handling interrupts.
  
**Common Components in Kernel Space**:
  - **Device Drivers**: Act as interfaces between hardware and software.
  - **Memory Manager**: Controls physical and virtual memory, page swapping, and allocation.
  - **Process Scheduler**: Manages process states, prioritizing CPU access.
  - **File System**: Handles data storage, retrieval, and organization on storage devices.

### User Space
- **Definition**: The non-privileged memory area where all user applications (e.g., browsers, editors, and custom programs) execute.
- **Purpose**: Provides a safe environment for running applications where they cannot interfere with each other or with kernel operations.
- **Access**: Programs in user space can only access their own memory and must use system calls to request kernel services.
- **Example Applications**: Text editors, media players, browsers, and most other user-facing applications.

**How User Space Interacts with Kernel Space**:
- **System Calls**: When a user application needs a low-level service (like file I/O), it makes a system call, which switches the process from user space to kernel space to execute the requested service.
- **Library Calls**: Commonly provided by libraries like `glibc`, allowing applications to make system calls easily.

### Key Differences

| Feature          | Kernel Space                          | User Space                       |
|------------------|--------------------------------------|----------------------------------|
| Access Level     | Full access to hardware and memory   | Limited access (via system calls) |
| Privileges       | Privileged, protected by the OS      | Non-privileged, restricted       |
| Stability Impact | System instability if crashed        | Isolated; app crashes don’t affect the OS |
| Execution Mode   | Kernel mode                          | User mode                        |

### Importance of Separation
- **Security**: Restricts applications from accessing or modifying system-level resources.
- **Stability**: Prevents user applications from crashing the kernel or affecting other applications.
- **Performance**: Kernel-level operations run efficiently and with higher privileges, while applications run safely in user space.



==System calls connects user space to kernel space==

Device drivers implement system calls

Build in kernels and loadable kernel modules
Built in kernels are the ones that are included in your kernel by default.
Loadable ones are the ones you write and inject into your system.


There are constructor and destructor for drivers.


File operations are fundamental functions provided by an operating system that allow programs to interact with the filesystem, enabling reading, writing, and managing files and directories. In Linux, file operations can be performed in both **user space** (through standard I/O libraries) and **kernel space** (in kernel modules or drivers). Here’s an overview of key file operations, with examples where applicable:

### 1. Open/Close Files
   - **`open`**: Opens a file, returning a file descriptor used for other file operations.
   - **`close`**: Closes an open file, freeing up the file descriptor.

   ```c
   int fd = open("file.txt", O_RDWR); // Open file for reading and writing
   close(fd);                         // Close the file
   ```

### 2. Read/Write Files
   - **`read`**: Reads data from a file into a buffer.
   - **`write`**: Writes data from a buffer to a file.
   
   ```c
   char buffer[100];
   int fd = open("file.txt", O_RDONLY);
   read(fd, buffer, sizeof(buffer));  // Read 100 bytes into buffer
   write(fd, "Hello, World!", 13);    // Write "Hello, World!" to file
   close(fd);
   ```

### 3. File Positioning
   - **`lseek`**: Changes the file offset (position in file) for reading or writing operations.
   
   ```c
   lseek(fd, 0, SEEK_SET); // Move to the beginning of the file
   ```

### 4. Stat Functions
   - **`stat`, `fstat`, `lstat`**: Retrieve information about a file, such as size, permissions, and timestamps.
   
   ```c
   struct stat file_stat;
   stat("file.txt", &file_stat);      // Get file information
   ```

### 5. I/O Control (ioctl)
   - **`ioctl`**: A lower-level function primarily used for device files. It provides direct access to hardware through device drivers and is commonly implemented in character drivers.
   
   ```c
   ioctl(fd, SOME_IOCTL_COMMAND, &args);
   ```

### Common File Operation Functions in Linux

| Function  | Description                             |
|-----------|-----------------------------------------|
| `open`    | Opens a file and returns a file descriptor. |
| `close`   | Closes an open file descriptor.            |
| `read`    | Reads data from an open file descriptor.   |
| `write`   | Writes data to an open file descriptor.    |
| `lseek`   | Changes the current read/write position in the file. |
| `stat`    | Retrieves information about a file.        |
| `ioctl`   | Performs low-level I/O operations on a file descriptor, often for device files. |

### File Operations in Kernel Space
In kernel modules, particularly device drivers, file operations are defined using the `file_operations` structure, which implements system calls like `open`, `release` (close), `read`, `write`, and `ioctl`. This structure links the user-space operations with the actual device driver functions in the kernel.

```c
static struct file_operations fops = {
   .open = device_open,
   .release = device_release,
   .read = device_read,
   .write = device_write,
   .unlocked_ioctl = device_ioctl,
};
```

### Example: Basic File I/O in a C Program
The following example reads and writes to a file in user space:

```c
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main() {
    int fd = open("example.txt", O_WRONLY | O_CREAT, 0644);
    if (fd < 0) {
        perror("Failed to open file");
        return 1;
    }

    write(fd, "Hello, World!\n", 14);  // Write to file
    close(fd);                        // Close file

    return 0;
}
```


# Types of drivers

Character drivers
block drivers -> drives
network drivers -> ethernet, wi-fi etc.


