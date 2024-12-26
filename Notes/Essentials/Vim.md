	:q to exit
	:q! to force exit without saving

# Modes

## Normal
	: starts a command
	i insert mode
	:set number to activate line number
	:set relativenumber
	:set mouse=a
	ctrl + r redo
	u undo

# Insert mode
	i to insert mode with before the cursor
	a to insert mode after the cursor
	o to insert a new line and enter insert mode (damn!)
		Can also use shift + anyof these


# Visual Mode
	v for visual mode
	d for deletion
	y for yanking aks copying
	p for pasting




https://github.com/junegunn/vim-plug download and run this for plugins

```

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

```
