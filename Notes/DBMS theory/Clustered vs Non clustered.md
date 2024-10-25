Indexes in databases are used to speed up the retrieval of rows. There are two primary types of indexes: clustered and non-clustered. Each type has distinct characteristics and use cases.

### Clustered Index

- **Definition**: A clustered index determines the physical order of data in a table. It reorders the actual data rows in the table to match the index. This means that there can be only one clustered index per table, as the data rows themselves can only be sorted in one order.

- **Key Characteristics**:
  - **Physical Sorting**: The rows are stored on disk in the order of the clustered index keys.
  - **Primary Key**: By default, the primary key of a table is implemented as a clustered index (unless specified otherwise).
  - **One Per Table**: Only one clustered index can exist per table due to the way it sorts the physical data.

- **Use Case**: Clustered indexes are useful when you frequently need to retrieve a range of data. For example, if you often query rows based on a date range, having a clustered index on the date column can significantly speed up these queries.

- **Example**:
  ```sql
  CREATE TABLE Employees (
      EmployeeID INT PRIMARY KEY, -- Primary key, automatically clustered index
      LastName NVARCHAR(50),
      FirstName NVARCHAR(50),
      DepartmentID INT
  );
  ```

### Non-Clustered Index

- **Definition**: A non-clustered index creates a separate structure that contains a sorted list of references to the actual data rows. This index does not affect the physical order of the data in the table. Instead, it maintains pointers to the data.

- **Key Characteristics**:
  - **Logical Sorting**: The index contains sorted key values and pointers to the corresponding data rows.
  - **Multiple Per Table**: A table can have multiple non-clustered indexes.
  - **Includes Pointers**: The index entries include pointers to the data rows, often in the form of row IDs or pointers to the clustered index key if a clustered index exists.

- **Use Case**: Non-clustered indexes are beneficial for columns that are frequently used in searches or joins but where sorting the physical data by this column is not necessary. They are particularly useful for improving the performance of queries that involve specific columns.

- **Example**:
  ```sql
  CREATE INDEX idx_lastname
  ON Employees (LastName);
  ```

### Differences

1. **Physical vs. Logical Order**:
   - **Clustered**: Alters the physical order of data.
   - **Non-Clustered**: Does not change the physical order; only affects the logical order.

2. **Number per Table**:
   - **Clustered**: Only one per table.
   - **Non-Clustered**: Multiple per table.

3. **Storage**:
   - **Clustered**: The actual data rows are stored in the index order.
   - **Non-Clustered**: Stores index keys and pointers to the actual data rows.

4. **Primary Key**:
   - **Clustered**: Often associated with the primary key.
   - **Non-Clustered**: Can be created on any column(s).

5. **Use Case**:
   - **Clustered**: Efficient for range queries and sorting.
   - **Non-Clustered**: Efficient for exact lookups and joins.

### Summary

- **Clustered Index**: Determines the physical order of data, allows only one per table, typically used for primary keys.
- **Non-Clustered Index**: Maintains a logical order, allows multiple per table, used for columns frequently involved in searches and joins.