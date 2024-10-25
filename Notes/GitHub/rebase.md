tags [[git]], [[bash]]

Rebasing in Git is a powerful tool that allows you to change the base of your branch from one commit to another, effectively rewriting the commit history. Rebasing can be used to maintain a clean, linear commit history, making it easier to follow and understand.

### Basic Concept

Rebasing works by moving the base of your branch to a new commit and then replaying your branch commits on top of that new base. This can be useful for integrating changes from another branch (often the main branch) into your current branch.

### Common Uses of Rebase

1. **Integrating Changes**: Instead of merging, you can rebase to integrate changes from the main branch into your feature branch.
2. **Cleaning Up Commits**: You can use interactive rebase to modify commit messages, squash commits, or reorder them for a cleaner history.

### Rebase vs. Merge

- **Merge**: Combines branches while preserving the history of both branches. It creates a new commit to join the branches.
- **Rebase**: Reapplies commits from your branch onto another base commit, creating a linear history without a merge commit.

### Basic Rebase Example

Suppose you have the following commit history:

```
main: A -- B -- C
             \
feature:      D -- E
```

To rebase `feature` onto `main`, you would use:

```bash
git checkout feature
git rebase main
```

After rebasing, the history will look like:

```
main: A -- B -- C -- D' -- E'
```

Commits `D` and `E` are reapplied onto `main` as `D'` and `E'`.

### Steps to Rebase

1. **Checkout the Branch to Rebase**:
    ```bash
    git checkout feature
    ```

2. **Rebase Onto the Target Branch**:
    ```bash
    git rebase main
    ```

3. **Resolve Conflicts (if any)**:
   If there are conflicts, Git will pause and allow you to resolve them. After resolving, continue the rebase:
    ```bash
    git add <resolved-files>
    git rebase --continue
    ```

4. **Abort Rebase (if needed)**:
   If you want to stop the rebase process, you can abort it:
    ```bash
    git rebase --abort
    ```

### Interactive Rebase

Interactive rebase allows you to modify commits in various ways, such as squashing, editing, or reordering. Start an interactive rebase with:

```bash
git rebase -i <base-commit>
```

This will open an editor with a list of commits to be rebased:

```
pick <commit-hash> Commit message 1
pick <commit-hash> Commit message 2
pick <commit-hash> Commit message 3
```

You can replace `pick` with:

- `squash` (or `s`): Combine this commit with the previous one.
- `edit` (or `e`): Edit the commit message or the content.
- `reword` (or `r`): Edit only the commit message.
- `drop` (or `d`): Remove the commit.

### Example: Squashing Commits

To squash the last two commits into one:

1. Start interactive rebase:
    ```bash
    git rebase -i HEAD~2
    ```

2. Change the second `pick` to `squash`:
    ```
    pick <commit-hash> Commit message 1
    squash <commit-hash> Commit message 2
    ```

3. Save and close the editor. Git will prompt you to edit the commit message for the squashed commit.

### Important Notes

- **Rewriting History**: Rebasing changes the commit history, which can cause problems if done on shared branches. Avoid rebasing commits that have been pushed to a shared repository.
- **Preserve Commits**: Use `git reflog` to recover commits if something goes wrong during the rebase.

Rebasing is a powerful tool for managing your commit history, but it should be used with care to avoid complications in collaborative environments.