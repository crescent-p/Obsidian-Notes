tags [[mysql]]

## **MySQL Transaction**

As a database engineer, you should use MySQL transaction any time you have a critical activity to complete. If any error occurs during the execution of the query, then you can use this technique to restore your database to the original state.

This is a particularly useful technique to consider when writing a series of related queries that must all execute as intended to achieve an expected outcome.

For example, Lucky Shrub have written a series of queries to assist with new orders. When an order is received, the database first checks that there are enough items available in stock to fulfill the order. Once the order has been processed, the database then updates the number of items remaining in stock.

There are a lot of steps in this process. And some of the changes, or required operations, may fail to occur in the database. If so, then Lucky Shrub can use MySQL transaction to cancel the changes and rollback the current transaction if any statements fail to execute as required.

You can use the MySQL BEGIN or BEGIN WORK aliases to start a MySQL transaction. Although the START TRANSACTION command is the standard way to start a transaction process in MySQL.

Then type the required SELECT statements. If all queries execute as expected, then the COMMIT statement is used to commit the current transaction and make the transaction changes permanently.

However, one or more of these statements may fail to execute as required. If so, then you can use the ROLLBACK statement to roll back the current transaction, cancel the changes made to the database and restore it to its original state.

This process is illustrated in the following abstract syntax:
```
START TRANSACTION; 

SQL statements 

ROLLBACK;
```
