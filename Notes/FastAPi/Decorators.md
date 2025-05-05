[[Python backend Development/Python]]

In Python, **decorators** are a powerful and flexible tool that allow you to modify or enhance the behavior of functions or methods without changing their actual code. They are essentially functions that take another function as an argument, extend or alter its behavior, and then return a new function.

### Syntax
A decorator is applied to a function using the `@decorator_name` syntax, which is placed just above the function definition.

Here’s a basic example:

```python
def my_decorator(func):
    def wrapper():
        print("Something is happening before the function is called.")
        func()  # Call the original function
        print("Something is happening after the function is called.")
    return wrapper

@my_decorator
def say_hello():
    print("Hello!")

say_hello()
```

### Output:
```
Something is happening before the function is called.
Hello!
Something is happening after the function is called.
```

### Explanation:
1. **`my_decorator(func)`** is the decorator function. It takes a function (`say_hello` in this case) as an argument.
2. Inside the decorator, we define a **`wrapper`** function that adds functionality before and after the original function is called.
3. The `@my_decorator` syntax is shorthand for `say_hello = my_decorator(say_hello)`, applying the decorator to the function.

### Common Use Cases:
1. **Logging**: Automatically log when a function is called.
2. **Access Control/Authorization**: Check user permissions before allowing a function to execute.
3. **Memoization**: Cache results of expensive function calls.
4. **Timing Functions**: Measure the execution time of a function.
5. **Validation**: Check the inputs or outputs of a function.

Here's a more practical example, a **timing decorator**:

```python
import time

def timer_decorator(func):
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        print(f"{func.__name__} took {end_time - start_time:.4f} seconds to execute.")
        return result
    return wrapper

@timer_decorator
def slow_function():
    time.sleep(2)  # Simulate a time-consuming task
    print("Function complete!")

slow_function()
```

### Output:
```
Function complete!
slow_function took 2.0004 seconds to execute.
```

This decorator calculates the time taken to execute the function it decorates.