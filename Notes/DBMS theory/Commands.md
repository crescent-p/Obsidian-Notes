Sure! Here is a summary of the SQL commands based on the categories DDL, DQL, DML, DCL, and TCL:

### SQL Commands Summary

**1. Data Definition Language (DDL)**
   - **Purpose**: Defines the database schema.
   - **Commands**:
     - **CREATE**: Creates new database objects (tables, indexes, views).
     - **ALTER**: Modifies existing database objects.
     - **DROP**: Deletes existing database objects.
     - **TRUNCATE**: Removes all records from a table, but not the table itself.
     - **RENAME**: Renames a database object.

**2. Data Query Language (DQL)**
   - **Purpose**: Retrieves data from the database.
   - **Commands**:
     - **SELECT**: Fetches data from the database.

**3. Data Manipulation Language (DML)**
   - **Purpose**: Manipulates data stored in the database.
   - **Commands**:
     - **INSERT**: Adds new data into a table.
     - **UPDATE**: Modifies existing data in a table.
     - **DELETE**: Removes data from a table.

**4. Data Control Language (DCL)**
   - **Purpose**: Controls access to data in the database.
   - **Commands**:
     - **GRANT**: Gives user access privileges to the database.
     - **REVOKE**: Removes user access privileges to the database.

**5. Transaction Control Language (TCL)**
   - **Purpose**: Manages transactions within the database to ensure data integrity.
   - **Commands**:
     - **COMMIT**: Saves all changes made in the current transaction.
     - **ROLLBACK**: Reverts changes made in the current transaction.
     - **SAVEPOINT**: Sets a point within a transaction to which you can later roll back.
     - **SET TRANSACTION**: Sets the properties of the current transaction (e.g., read/write mode).

### Example Usage

1. **DDL Example**:
   ```sql
   CREATE TABLE Employees (
       EmployeeID int,
       FirstName varchar(255),
       LastName varchar(255)
   );
   ```

2. **DQL Example**:
   ```sql
   SELECT FirstName, LastName FROM Employees;
   ```

3. **DML Example**:
   ```sql
   INSERT INTO Employees (EmployeeID, FirstName, LastName)
   VALUES (1, 'John', 'Doe');
   ```

4. **DCL Example**:
   ```sql
   GRANT SELECT ON Employees TO User1;
   ```

5. **TCL Example**:
   ```sql
   BEGIN;
   UPDATE Employees SET LastName = 'Smith' WHERE EmployeeID = 1;
   COMMIT;
   ```

These categories and commands help structure SQL operations to manage and manipulate relational databases efficiently.