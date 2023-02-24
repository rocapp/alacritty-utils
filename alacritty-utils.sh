#!/usr/bin/env bash

# alacritty terminal emulator customization utilities


function init-alacritty-utils() {
    # Run this on first initialization
    $(alacritty-colorscheme &> /dev/null) || (
	echo -e 'Installing alacritty-colorscheme...' &&
	    pyenv shell alacritty &&
	    python -m pip install alacritty-colorscheme &&
	    pyenv shell --unset
    )
}

function alacritty-pyenv-exec () {
    : ${1?"Usage: $0 [command-to-execute]"}
    cmd=$1  # shell command

    # switch, execute, switch back
    pyenv shell alacritty &&
	pyenv exec $cmd &&
	pyenv shell --unset
}

# get alacritty color schemes available...
function alacritty_colors() { alacritty-pyenv-exec 'alacritty-colorscheme list'; }

function list-alacritty-colors() {
    # list colors with line numbers
    alacritty_colors | nl
}
function alacritty-list-colors() { list-alacritty-colors $@; }

#: alias to alacritty-utils-python.py
alias alacritty-utils-python="$ALACRITTY_UTILS_DIR/bin/alacritty-utils-python.py"

function alacritty-get-color() {
    # retrieve a color scheme name randomly or by number
    
    pyenv shell alacritty # ! switch to 'alacritty' environment temporarily
    
    alacritty-utils-python $@

    # ! switch back to previous env
    pyenv shell --unset
    
}

#: alias to alacritty-get-color, defined above
alias alacritty-utils="alacritty-get-color $@"
