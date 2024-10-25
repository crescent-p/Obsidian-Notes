tags [[git]], [[shell]]

==You are at a node. You can create new changes to the file.But you don't want to save it. you need to go back to the last commit and start writing new code without deleting the present changes. You can stash after 
`git add .`==

`git stash` is a command in Git that allows you to temporarily save (stash) changes you've made to your working directory so that you can work on something else, and then reapply those changes later. This is particularly useful when you need to switch branches but have uncommitted changes that you don't want to commit yet.

Here's a basic overview of how to use `git stash`:

1. **Stashing Changes**:
   - Save your changes with `git stash`. This will save the changes and revert your working directory to the state of the last commit.
     ```sh
     git stash
     ```

2. **Listing Stashed Changes**:
   - See a list of stashed changes with `git stash list`.
     ```sh
     git stash list
     ```

3. **Applying Stashed Changes**:
   - Reapply the most recent stashed changes with `git stash apply`. The changes remain in the stash list.
     ```sh
     git stash apply
     ```
   - Reapply and remove the most recent stash with `git stash pop`.
     ```sh
     git stash pop
     ```

4. **Applying a Specific Stash**:
   - If you have multiple stashes, you can apply a specific one using `git stash apply <stash@{n}>`.
     ```sh
     git stash apply stash@{1}
     ```

5. **Dropping a Stash**:
   - Remove a specific stash with `git stash drop <stash@{n}>`.
     ```sh
     git stash drop stash@{0}
     ```
   - Remove all stashes with `git stash clear`.
     ```sh
     git stash clear
     ```

6. **Creating a Named Stash**:
   - You can give a name to your stash for better identification.
     ```sh
     git stash push -m "meaningful message"
     ```

Here is a simple workflow using `git stash`:

1. You have uncommitted changes in your working directory:
   ```sh
   git status
   ```

2. Stash your changes:
   ```sh
   git stash
   ```

3. Switch to another branch and work on something else:
   ```sh
   git checkout <other-branch>
   ```

4. When you're ready to go back to your original branch and reapply your stashed changes:
   ```sh
   git checkout <original-branch>
   git stash pop
   ```

Using `git stash` effectively can help you manage your workflow and switch contexts without losing your uncommitted work.