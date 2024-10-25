tags [[git]], [[shell]]

1. **`git reset --soft <commit>`**:
    
    - Moves the HEAD to the specified commit.
    - Leaves the working directory and [[staging]] area (index) unchanged.
    - Changes made after the specified commit remain in the staging area, allowing you to recommit them.
2. **`git reset --mixed <commit>`** (default if no option is specified):
    
    - Moves the HEAD to the specified commit.
    - Leaves the working directory unchanged.
    - Changes made after the specified commit are removed from the staging area, but remain in the working directory as uncommitted changes.
3. **`git reset --hard <commit>`**:
    
    - Moves the HEAD to the specified commit.
    - Discards all changes in the working directory and the staging area.
    - All changes made after the specified commit are lost.
