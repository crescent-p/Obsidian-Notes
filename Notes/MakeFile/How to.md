Let’s dive deeper into these advanced Makefile concepts: **Automatic Variables**, **Pattern Rules**, and **Conditional Execution**.

### 1. Automatic Variables
Automatic variables in Makefiles make it easier to write flexible and reusable rules. Here are some key automatic variables:

- **`$@`**: Represents the **target** name in the rule.
- **`$^`**: Expands to all **dependencies** listed for the target.
- **`$<`**: Refers to the **first dependency** only.

#### Example
```makefile
# Target: my_program
my_program: main.o functions.o
    gcc -o $@ $^   # $@ = my_program, $^ = main.o functions.o

# Object file compilation
%.o: %.c
    gcc -c $<      # $< = first dependency, e.g., main.c
```

This will compile `my_program` using `main.o` and `functions.o`, with `$@` expanding to `my_program`, and `$^` gathering all dependencies (`main.o functions.o`). Similarly, `$<` is used in the pattern rule to represent the first dependency (e.g., `main.c`).

### 2. Pattern Rules
Pattern rules allow you to define rules for **file patterns**, making it easy to handle multiple similar files without writing separate rules for each one.

- **Syntax**: `%` represents a wildcard matching any string. For example, `%.o: %.c` applies to any `.c` file that should be compiled into a corresponding `.o` file.

#### Example
```makefile
# Pattern Rule for Compiling .c to .o
%.o: %.c
    gcc -Wall -g -c $< -o $@
```

This pattern rule automatically compiles any `.c` file into a `.o` file. When `make` encounters a dependency like `main.o`, it knows to use `main.c` to build it, following this rule.

### 3. Conditional Execution
Makefiles also support conditional execution to make builds more flexible. This is useful for:
   - Platform-specific builds (e.g., Linux vs. Windows).
   - Debug vs. release builds.
   - Checking if certain programs or files are available.

- **Syntax**:
  ```makefile
  ifeq (condition, value)
      # Commands for matching condition
  else
      # Commands if condition does not match
  endif
  ```

#### Example
```makefile
# Choose compiler flags based on DEBUG variable
ifeq ($(DEBUG), 1)
    CFLAGS = -Wall -g -DDEBUG
else
    CFLAGS = -Wall -O2
endif

# Apply CFLAGS in pattern rule
%.o: %.c
    gcc $(CFLAGS) -c $< -o $@
```

Running `make DEBUG=1` will use the debug flags (`-g -DDEBUG`), while a standard `make` will use optimization (`-O2`). This can be particularly helpful for large projects that need different compilation settings.

### Putting It All Together

A more complete Makefile might look like this:

```makefile
# Variables
CC = gcc
CFLAGS = -Wall

ifeq ($(DEBUG), 1)
    CFLAGS += -g -DDEBUG
else
    CFLAGS += -O2
endif

# Target for building the program
my_program: main.o functions.o
    $(CC) $(CFLAGS) -o $@ $^

# Pattern rule for object files
%.o: %.c
    $(CC) $(CFLAGS) -c $< -o $@

# Clean up
clean:
    rm -f *.o my_program
```

This Makefile will compile with different flags based on whether `DEBUG=1` is set, use pattern rules to compile `.c` files into `.o` files, and automatically handle file targets and dependencies.