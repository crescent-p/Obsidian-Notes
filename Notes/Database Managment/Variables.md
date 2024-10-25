tags [[mysql]], [[Variables]]

In MySQL, variables can be used to store temporary data that you need for processing within your SQL scripts, stored procedures, or functions. Variables can be session-specific, local, or user-defined. Here's an overview of how to use and declare different types of variables in MySQL:

### Types of Variables

1. **Session Variables**:
   - These are user-defined variables that are available throughout the session.
   - They are prefixed with an `@` symbol.
   - They do not need to be explicitly declared.
   - They can store values of any type.
   - Their scope is limited to the session.

   ```sql
   SET @myVar = 10;
   SELECT @myVar;
   ```

2. **Local Variables**:
   - These are used within stored programs (procedures, functions, triggers).
   - They are declared using the `DECLARE` statement.
   - They have a limited scope, typically within the block where they are declared.
   - Their type must be specified upon declaration.

   ```sql
   DECLARE myVar INT DEFAULT 10;
   SET myVar = 20;
   SELECT myVar;
   ```

### Declaring Local Variables

Local variables are declared in the `DECLARE` section of a stored procedure, function, or block. The declaration must be placed at the beginning of the block, before any other statements.

#### Syntax:

```sql
DECLARE variable_name datatype [DEFAULT default_value];
```

- **variable_name**: The name of the variable.
- **datatype**: The data type of the variable (e.g., INT, VARCHAR, DATE).
- **default_value**: An optional default value for the variable.

### Example of Declaring and Using Local Variables

#### Stored Procedure Example:

```sql
DELIMITER //

CREATE PROCEDURE exampleProcedure()
BEGIN
    DECLARE myVar INT DEFAULT 10; -- Declare an integer variable with a default value of 10
    DECLARE anotherVar VARCHAR(50); -- Declare a VARCHAR variable without a default value

    SET anotherVar = 'Hello, World!'; -- Assign a value to the VARCHAR variable

    -- Use the variables in a SELECT statement
    SELECT myVar, anotherVar;
END //

DELIMITER ;
```

#### Using Variables in a Control Flow:

```sql
DELIMITER //

CREATE PROCEDURE controlFlowExample()
BEGIN
    DECLARE count INT DEFAULT 0;
    DECLARE maxCount INT DEFAULT 5;

    WHILE count < maxCount DO
        SET count = count + 1;
        SELECT count;
    END WHILE;
END //

DELIMITER ;
```

### Using Session Variables in Queries

Session variables can be set and used in SQL queries and are useful for temporary storage across multiple queries within the same session.

#### Example:

```sql
SET @total = 0;

-- Calculate the total of a column and store it in a session variable
SELECT SUM(amount) INTO @total FROM payments;

-- Use the session variable in another query
SELECT @total AS TotalAmount;
```

### Key Points

- **Scope**: Local variables are limited to the block they are declared in, while session variables are available throughout the session.
- **Declaration**: ==Local variables must be declared with `DECLARE`, whereas session variables do not require explicit declaration.==
- **Prefix**: Session variables are prefixed with `@`, whereas local variables are not.

By understanding and using these different types of variables effectively, you can manage data and control flow within your MySQL scripts and stored programs more efficiently.