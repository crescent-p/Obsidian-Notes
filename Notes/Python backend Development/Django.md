Here’s the corrected version of your markdown for setting up a Django project in a virtual environment:

---

# Setting Up Django in a Virtual Environment

### Step 1: Install `virtualenv`
To install `virtualenv` using `pip`, run the following command:

```bash
pip install virtualenv
```

### Step 2: Create a Virtual Environment
To create a new virtual environment, run:

```bash
virtualenv <env_name>
```

Replace `<env_name>` with the name of your virtual environment.

### Step 3: Activate the Virtual Environment
After creating the virtual environment, you need to activate it.

- **On Windows**:
  ```bash
  .\<env_name>\Scripts\activate
  ```

- **On macOS/Linux**:
  ```bash
  source <env_name>/bin/activate
  ```

### Step 4: Install Django
Once the virtual environment is activated, you can install Django:

```bash
pip install django
```

### Step 5: Create a Django Project
Now, you can create a new Django project:

```bash
django-admin startproject <project_name>
```

Replace `<project_name>` with the name of your project.

### Step 6: Run the Django Development Server
To run the Django development server, first ensure you are in the project directory, then run:

```bash
python manage.py runserver
```

This will start the server at `http://127.0.0.1:8000/`.

### Step 7: Deactivate the Virtual Environment
When you are done, you can deactivate the virtual environment with the following command:

```bash
deactivate
```

### Virtual Environment Commands:
- `mkvirtualenv <env_name>`: Create a new virtual environment (if using `virtualenvwrapper`).
- `workon <env_name>`: Activate an existing virtual environment (if using `virtualenvwrapper`).
- `rmvirtualenv <env_name>`: Delete a virtual environment.

---

## Setting up the template Folder

1) Create a folder called templates  
2) Go into setting.py and change the DIRS of template
 ![[Pasted image 20240908180325.png]]

