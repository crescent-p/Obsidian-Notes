Database migration tool.

`pip install alembic`

**Alembic** is a lightweight database migration tool for SQLAlchemy, which is the Python SQL toolkit. It is commonly used in Python web development for managing changes to a relational database schema in a controlled and automated way. Alembic allows developers to track database changes (like creating or altering tables, adding columns, etc.) and apply them incrementally across different environments (development, staging, production).

### Key Concepts of Alembic:

1. **Database Migrations**:
   - Migrations are changes to the database schema (like creating tables, altering columns, adding indexes).
   - Alembic allows you to create migration scripts that can upgrade (apply new schema changes) or downgrade (revert schema changes) your database.

2. **Version Control for Database Schema**:
   - Alembic keeps track of every change made to the database schema with a version history. This makes it easier to apply changes incrementally and ensure consistency across environments.
   
3. **SQLAlchemy Integration**:
   - Alembic is tightly integrated with SQLAlchemy, so it's often used with databases that are managed using SQLAlchemy ORM models. However, it can also work independently for raw SQL migrations.

### Basic Workflow:

1. **Initialize Alembic**:
   - First, you initialize Alembic in your project, which creates the necessary configuration files and a folder for migration scripts.

   ```bash
   alembic init alembic
   ```

   This creates a basic folder structure for Alembic with a `versions` folder to store migration scripts and an `alembic.ini` configuration file.

2. **Configure Alembic**:
-  go to alembic/env.py and import Base from database.py so that alembic has access to the models you created.
	```python
	#inside alembic/env.py
	#while importing Base make sure its from the same file that all the models as declared for me it was 
	from apps.models import Base
	#from apps.database import Base -- Wrong
	target_metadata = Base.mydata
```
	- Go into alembic.ini and change `sqlalchemy.url = driver://user:pass@localhost/dbname` to correct URL. But this is bad method. 
	- Alternatively you can override this variable inside env.py 
	- 

   - In the `alembic.ini` file, you configure the connection to your database (typically using the `SQLALCHEMY_DATABASE_URL` from your app).
   - You also need to link Alembic to your SQLAlchemy models in the `env.py` file, so it can auto-generate migrations based on model changes.
  ``` python
### Example Workflow:
Suppose you have a SQLAlchemy model called `User`, and you want to add a new column, `email`, to the table.

1. **Change SQLAlchemy Model**:
   ```python
   class User(Base):
       __tablename__ = 'users'
       id = Column(Integer, primary_key=True, index=True)
       name = Column(String, index=True)
       email = Column(String)  # New column
   ```

2. **Generate Migration**:
   Run the following command to autogenerate a migration:
   ```bash
   alembic revision --autogenerate -m "Add email column to User"
   ```

3. **Apply the Migration**:
   Apply the migration to update the database schema:
   ```bash
   alembic upgrade head
   ```

Now the `users` table in your database has an `email` column.

### Summary:

- **Alembic** helps manage changes to the database schema through version-controlled migrations.
- It works with **SQLAlchemy** to automatically detect model changes and generate migration scripts.
- Alembic commands like `revision`, `upgrade`, and `downgrade` are used to create, apply, and revert migrations.