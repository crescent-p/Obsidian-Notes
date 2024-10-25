tags [[git]], [[init]], [[shell]]

change terminal to the folder you want and run
`git init`

`ls .git` to show all hidden folders related with git.

`git status` To check status of files. Committed/Uncommitted etc.

### Committing

`git add .` to all files to stage
`git add {name_of_file}` 

`git commit {filename} -m "message to added"` -> commits all files in stage.

`git restore --staged {name}`
to remove file from stage.

### finding changes

`git log`

### Unstaging aka going back to previous build


1) copy the commit id
2) `git reset {commit id} `

git reset lets you go back to a previous commit. Anything done from that point onwards is lost.

