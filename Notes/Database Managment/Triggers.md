tags [[mysql]]

## **MySQL triggers and their uses**

A MySQL trigger is a stored program that is associated with a table. A trigger is activated before or after a defined SQL operation is performed on a table.

Triggers can be activated on SQL operations like INSERT, UPDATE and DELETE. MySQL supports Row-Level triggers that are invoked before or after a row is inserted, updated or deleted in a table.

You can specify a set of actions to be performed on a table when the specified operation occurs. This is done within the body of a trigger.

Triggers can be used in MySQL for the following purposes:

- Enforcing business rules
    
- Ensure data integrity (as a replacement to constraints)
    
- Insert records to other tables for audit trail purposes
    
- Query data for reporting purposes
    
- Replicate data to different tables to achieve data consistency

## **Creating and removing MYSQL triggers**

```
CREATE TRIGGER trigger_name

{BEFORE | AFTER} {INSERT | UPDATE| DELETE}

ON table_name FOR EACH ROW

trigger_body;
```

`DROP TRIGGER [IF EXISTS] [schema_name.]trigger_name`

## **Accessing table columns from within a trigger**

You often must access table column values when writing the code in the trigger body. Accessing a table column within the body of the trigger can be done using the OLD and NEW modifiers. OLD is used to access the value of the column before the operation (For example BEFORE INSERT, UPDATE and DELETE). NEW is used to access the value of the column after the operation.

The OLD and NEW modifiers are available for INSERT, UPDATE and DELETE operations as follows:

![[Pasted image 20240703204732.png]]

```
CREATE TRIGGER OrderQtyCheck  

  BEFORE INSERT ON Orders  

  FOR EACH ROW  

BEGIN 

  IF NEW.Quantity < 0 THEN  

    SET NEW.Quantity = 0; 

  END IF; 

END;
```
#### Listing all triggers in a database

```
SHOW TRIGGERS

[{FROM | IN} database_name]

[LIKE 'pattern' | WHERE search_condition];
```
