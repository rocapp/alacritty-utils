#!/usr/bin/env bash

export ALACRITTY_UTILS_DIR=$HOME/.alacritty-utils

mkdir -p $ALACRITTY_UTILS_DIR/bin
mkdir -p $ALACRITTY_UTILS_DIR/

cp ./alacritty-utils.sh $ALACRITTY_UTILS_DIR/bin/
cp ./alacritty-utils-python.py $ALACRITTY_UTILS_DIR/bin/

chmod ug+x $ALACRITTY_UTILS_DIR/bin/*

set +e
pyenv virtualenv alacritty
set -e

python -c $'''
from pathlib import Path
import os
udir = os.getenv("HOME")
rcpath = Path(udir).joinpath(".bashrc")
title_str = "# alacritty-utils config:"
if title_str in rcpath.read_text():
   pass
else:
   rcpath.open(mode="a+").write("\n".join([
	"",
	title_str, 
	"export ALACRITTY_UTILS_DIR=$HOME/.alacritty-utils",
	"export PATH=$PATH:$ALACRITTY_UTILS_DIR:$ALACRITTY_UTILS_DIR/bin",
	"source $ALACRITTY_UTILS_DIR/bin/alacritty-utils.sh",
	""
   ]))
'''

# /usr/bin/env bash -c 'source $HOME/.bashrc && init-alacritty-utils'

echo -e "\n...done."
