tags [[git]]

==One branch = one pull request.
 Always create new branches when working on new features.==

Branches in Git are a fundamental concept for managing different lines of development. They allow you to work on features, bug fixes, or experiments independently from the main codebase. Here's an overview of how branches work in Git:

### Key Concepts

- **Branch**: A lightweight, movable pointer to a commit. The default branch in a new repository is usually called `main`.
- **HEAD**: A pointer that represents your current working branch.

### Common Commands

#### Viewing Branches

- **List all branches**:
  ```sh
  git branch
  ```
  This shows all local branches. The current branch is highlighted with an asterisk (*).

- **List all remote branches**:
  ```sh
  git branch -r
  ```

- **List all branches (local and remote)**:
  ```sh
  git branch -a
  ```

#### ==Creating and Switching Branches==

- **Create a new branch**:
  ```sh
  git branch <branch-name>
  ```

- **Switch to a different branch**:
  ```sh
  git checkout <branch-name>
  ```

- **Create and switch to a new branch**:
  ```sh
  git checkout -b <branch-name>
  ```

#### [[Merging Branches]]

- **Merge a branch into the current branch**:
  ```sh
  git merge <branch-name>
  ```

- If there are conflicts during the merge, Git will prompt you to resolve them. After resolving the conflicts, you need to stage the resolved files and commit the merge.

#### Deleting Branches

- **Delete a local branch**:
  ```sh
  git branch -d <branch-name>
  ```
  Use `-D` instead of `-d` to force delete a branch that hasn't been merged.

- **Delete a remote branch**:
  ```sh
  git push origin --delete <branch-name>
  ```

### Example Workflow

1. **Create a new branch for a feature**:
   ```sh
   git checkout -b feature-branch
   ```

2. **Work on the feature and commit changes**:
   ```sh
   # Make changes to your files
   git add .
   git commit -m "Add new feature"
   ```

3. **Switch back to the main branch**:
   ```sh
   git checkout main
   ```

4. **Merge the feature branch into the main branch**:
   ```sh
   git merge feature-branch
   ```

5. **Delete the feature branch**:
   ```sh
   git branch -d feature-branch
   ```

### Remote Branches

Remote branches are references to the state of branches on a remote repository. They are prefixed with `remotes/` and help you keep track of what's happening in the remote repository.

- **Fetch remote branches**:
  ```sh
  git fetch
  ```

- **Push a local branch to a remote repository**:
  ```sh
  git push origin <branch-name>
  ```

- **Track a remote branch**:
  ```sh
  git checkout --track origin/<branch-name>
  ```

### Tracking Branches

A tracking branch is a local branch that has a direct relationship to a remote branch. When you push or pull, Git knows which remote branch to interact with.

- **Set up tracking when creating a new branch**:
  ```sh
  git checkout -b <branch-name> origin/<branch-name>
  ```

- **Set up tracking for an existing branch**:
  ```sh
  git branch --set-upstream-to=origin/<branch-name> <branch-name>
  ```

By using branches, you can manage multiple lines of development simultaneously, making it easier to develop new features, fix bugs, and collaborate with others without disrupting the main codebase.