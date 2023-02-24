# alacritty-utils

*disclaimer: created for personal use, so it ain't my fault if it breaks something ;^)*


## Features

- Isolate your alacritty-specific customizations in a virtual environment (using `pyenv`)
- User-friendly syntax, for example:
  `$ alacritty-utils -s metal -S  # search themes for keyword 'metal' & apply`
- ...


## Author
- Created by: Robbie Capps
- Creation Date: 2023-01-24


## Dependencies:
 - https://github.com/toggle-corp/alacritty-colorscheme
 - https://github.com/aaron-williamson/base16-alacritty (for preconfigured color schemes)
 - pyenv


## Setup:

NOTE: *Ensure all scripts are executable: `chmod ug+x ./...`*

NOTE: *Assumes your alacritty config to be in `~/.config/alacritty`*


## Installation:

NOTE: *Installation will append `$ALACRITTY_UTILS_DIR` (`~/.alacritty-utils` by default) to `$PATH`.*

To install, run:

```console
$ chmod ug+x ./install.sh && ./install.sh
```

NOTE: *You might need to restart your shell... if you still get errors, try:*
```console
$ init-alacritty-utils
```

## Usage:

 - To see help summary:

        $ alacritty-utils --help
