tags: [[mysql]], [[Database Managment/Functions in MySql|Functions in MySql]]
## **Key differences between functions and procedures**

A function in MySQL is also called a stored function. A procedure is called a stored procedure. Basic stored procedures and functions typically represent operations that contain empty parameters, or simple input parameters, and a single SQL statement.

More complex procedures and functions require the use of additional features like complex parameters, variables, changing delimiters and the use of BEGIN-END keywords. They also often require the use of multiple SQL statements in the body of the procedure.

In this context, key differences between functions and procedures are as follows:

- A function returns a single value, whereas a procedure may return a single value, multiple values or no value.
    
- Typically, functions encapsulate common formulas or generic business rules that are reusable among SQL statements and stored procedures. Procedures, on the other hand, are used mainly to process, manipulate and modify data in the database.
    
- Functions only accept input parameters, while stored procedures can accept IN, OUT and INOUT parameters.
    
- Functions can be invoked from anywhere, including SELECT statements and stored procedures. Stored procedures are invoked using the CALL statement only.   
    
- A stored function is created using the CREATE FUNCTION statement. A stored procedure is created using the CREATE PROCEDURE statement.
    
- To build a function, you should specify if it is a DETERMINISTIC function or not. This means that you need to decide if the function always returns the same result for the same input parameters. If you don't use DETERMINISTIC, then MySQL uses the NOT DETERMINISTIC option by default.  
    
- To build functions you must specify the data type of the return value in the RETURNS statement. This can be any valid MySQL data type. However, there’s no need to do this with stored procedures.
    

The following table provides a summary of the key differences between stored procedures and stored functions.
![[Pasted image 20240703135459.png]]