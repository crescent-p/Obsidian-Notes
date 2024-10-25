tags : [[mysql]], [[Functions in MySql]]
## **Overview of functions and procedures in MySQL**

In many programming languages, functions are called procedures. In some other programming languages such as SQL there are several key differences between these two terms.

However, it is important to realize that both terms represent the same concept of wrapping or encapsulating code together in the body of the function or the procedure. This function or procedure is then called to perform a specific operation by invoking the identifier name.

The main purpose of creating stored procedures and functions is to create reusable code that can be invoked and executed in an efficient way. So, instead of typing the same code repeatedly, you can save your blocks of code in a stored procedure or a function. You can then call these blocks when you need to use your code.

This makes your code more consistent, better organized, reusable and easier to maintain.

For example, the following query can be used to return the names of all clients in the Clients table from the Lucky Shrub database:

```
DELIMITER //

CREATE PROCEDURE GetAllClients()

BEGIN

SELECT * FROM Clients;

END //

DELIMITER;
```


```
DELIMITER //

CREATE FUNCTION GetCostAverage() RETURNS DECIMAL(5,2) DETERMINISTIC 

BEGIN

RETURN (SELECT AVG(Cost) FROM Orders);

END //

DELIMITER;
```

Delimiter helps in compiling the code correctly.

[[variables]], [[set variables]], [[declare variables]]
```
DELIMITER // 

  

CREATE Procedure GetDiscount(OrderIDInput INT) 

     BEGIN 

         DECLARE cost_after_discount DECIMAL(7,2); 

         DECLARE current_cost DECIMAL(7,2); 

         DECLARE order_quantity INT; 

         SELECT Quantity INTO order_quantity FROM Orders WHERE OrderID = OrderIDInput; 

         SELECT Cost INTO current_cost FROM Orders WHERE OrderID = OrderIDInput; 

        IF order_quantity >= 20 THEN

          SET cost_after_discount = current_cost - (current_cost * 0.2);              

        ELSEIF order_quantity >= 10 THEN

          SET cost_after_discount = current_cost - (current_cost * 0.1); 

        ELSE SET cost_after_discount = current_cost;

        END IF;

    SELECT cost_after_discount; 

END//

  

DELIMITER ;
```

