https://www.youtube.com/watch?v=QoMaV-m7_bE&ab_channel=TechnonTechTV

Normal forms in database design are guidelines to reduce redundancy and improve data integrity. These forms are a part of database normalization. Here's a brief overview of the most commonly used normal forms:

### 1. First Normal Form (1NF)

- **Definition**: A table is in 1NF if:
  - All columns contain atomic (indivisible) values.
  - Each column contains values of a single type.
  - Each column must have a unique name.
  - The order in which data is stored does not matter.
  
- **Example**: Consider a table with repeating groups:

  | StudentID | Name    | Courses       |
  |-----------|---------|---------------|
  | 1         | John    | Math, Science |
  | 2         | Alice   | Math, English |

  To convert this to 1NF:

  | StudentID | Name  | Course   |
  |-----------|-------|----------|
  | 1         | John  | Math     |
  | 1         | John  | Science  |
  | 2         | Alice | Math     |
  | 2         | Alice | English  |

### 2. Second Normal Form (2NF)

- **Definition**: A table is in 2NF if:
  - It is in 1NF.
  - All non-key attributes are fully functionally dependent on the primary key (no partial dependency).
  
- **Example**: Consider a table where only part of a composite key determines non-key attributes:

  | StudentID | Course   | Instructor |
  |-----------|----------|------------|
  | 1         | Math     | Dr. Smith  |
  | 1         | Science  | Dr. Adams  |
  | 2         | Math     | Dr. Smith  |
  | 2         | English  | Dr. Brown  |

  To convert this to 2NF, we separate the tables:

  - StudentCourses:

    | StudentID | Course   |
    |-----------|----------|
    | 1         | Math     |
    | 1         | Science  |
    | 2         | Math     |
    | 2         | English  |

  - CourseInstructors:

    | Course   | Instructor |
    |----------|------------|
    | Math     | Dr. Smith  |
    | Science  | Dr. Adams  |
    | English  | Dr. Brown  |

### 3. Third Normal Form (3NF)

- **Definition**: A table is in 3NF if:
  - It is in 2NF.
  - There are no transitive dependencies (non-key attributes do not depend on other non-key attributes).

- **Example**: Consider a table where non-key attributes depend on other non-key attributes:

  | StudentID | Course   | Instructor | InstructorOffice |
  |-----------|----------|------------|------------------|
  | 1         | Math     | Dr. Smith  | Room 101         |
  | 1         | Science  | Dr. Adams  | Room 102         |
  | 2         | Math     | Dr. Smith  | Room 101         |
  | 2         | English  | Dr. Brown  | Room 103         |

  To convert this to 3NF, we separate the tables:

  - StudentCourses:

    | StudentID | Course   |
    |-----------|----------|
    | 1         | Math     |
    | 1         | Science  |
    | 2         | Math     |
    | 2         | English  |

  - CourseInstructors:

    | Course   | Instructor |
    |----------|------------|
    | Math     | Dr. Smith  |
    | Science  | Dr. Adams  |
    | English  | Dr. Brown  |

  - InstructorOffices:

    | Instructor | InstructorOffice |
    |------------|------------------|
    | Dr. Smith  | Room 101         |
    | Dr. Adams  | Room 102         |
    | Dr. Brown  | Room 103         |

### Higher Normal Forms

There are higher normal forms like BCNF (Boyce-Codd Normal Form), 4NF, and 5NF, which further refine the criteria for eliminating redundancy and ensuring data integrity. However, 1NF, 2NF, and 3NF are the most commonly used in practical database design.

### Summary

- **1NF**: Ensure all columns contain atomic values and each column has unique data.
- **2NF**: Ensure no partial dependency of any column on the primary key.
- **3NF**: Ensure no transitive dependency between non-key attributes.

Normalization helps in organizing the data efficiently and reducing redundancy, which improves the performance and integrity of the database.