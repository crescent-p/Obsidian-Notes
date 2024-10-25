# File: auto_git_push.ps1
cd "C:\Users\cresc\Documents\Obsidian"  # Change to your repo path

git add .                   # Stages all changes
git commit -m "Auto-commit on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"  # Creates a commit with a timestamp
git push master # Replace 'main' with your branch name
