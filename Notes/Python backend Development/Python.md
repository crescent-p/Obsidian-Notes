## Environments
A Python virtual environment is an isolated environment where you can install Python packages and dependencies specific to a project, without affecting the global Python installation or other projects. This isolation ensures that package versions do not conflict between projects and allows you to manage dependencies more effectively.

### Key Features:
- **Isolation**: Dependencies installed in a virtual environment are not shared with the global Python environment.
- **Different Versions**: You can use different versions of the same package across different projects.
- **Easy Setup**: Virtual environments are easy to create, activate, and manage.

### How to Create and Use a Virtual Environment:

1. **Create a virtual environment**:
   ```bash
   python -m venv myenv
   ```
   This creates a virtual environment in the `myenv` directory.

2. **Activate the virtual environment**:
   - On Windows:
     ```bash
     myenv\Scripts\activate
     ```
   - On macOS/Linux:
     ```bash
     source myenv/bin/activate
     ```

3. **Install packages inside the virtual environment**:
   Once the environment is activated, you can install packages specific to that environment:
   ```bash
   pip install <package>
   ```

4. **Deactivate the virtual environment**:
   To exit the virtual environment, simply run:
   ```bash
   deactivate
   ```

Virtual environments help maintain clean and manageable development environments.


