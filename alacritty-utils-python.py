#!/usr/bin/env python
import logging
logging.basicConfig(format="%(message)s", level=logging.INFO)
import os, sys
import argparse
import pydoc
import random
import difflib


if __name__ == '__main__':
    parser = argparse.ArgumentParser(prog="alacritty-get-color")
    parser.add_argument(
        "-i", "--color-id",
        type=int, help="The integer ID corresponding to the desired colorscheme, as listed in: `list-alacritty-colors` (or a random number if -1 [default])",
        default=-1,
    )
    parser.add_argument(
        "-l", "--list",
        action="store_true", default=False,
        help="List the available colorschemes with numbered IDs (calls `list-alacritty-colors`)",
    )
    print_group = parser.add_mutually_exclusive_group()
    print_group.add_argument(
        "-n", "--print-color-id",
        action="store_true", dest="print_color_id", default=False,
        help="Flag: print the colorscheme ID number in addition to the scheme name itself."
    )
    print_group.add_argument(
        "--no-print-color-id",
        action="store_false", dest="print_color_id",
        help="Flag: don't print the ID number.",
    )
    parser.add_argument("-s", "--search", type=str, default=None,
                        help="fuzzy search for the specified color scheme name, return possible matches."
    )
    args = parser.parse_args()

    # ! get the specified color ID (could be replaced if fuzzy matching is specified)
    cid = int(args.color_id)

    #: numbered color list
    with os.popen("ls $HOME/.config/alacritty/colors/ | nl") as pipe:
       colors_list = [c for c in pipe.readlines()]
    colors = colors_list

    # choose subset of colors via fuzzy matching if -s is given
    if args.search is not None:
        tgt = ("*" + str(args.search) + "*").replace("**", "*")
        if ".y" not in tgt: tgt = tgt + ".y*"
        colors = difflib.get_close_matches(tgt, colors, n=20, cutoff=0.05)
        cid = 0
        if len(colors) == 0:
           raise RuntimeError("No matching colors found!")

    if args.list is True:  # list colors in interactive pager
        pydoc.pipepager("".join(colors), "less -R")  # ! starts an interactive pager
        sys.exit(0)

    # ! choose random integer if -1
    if cid == -1:
       cid = random.randint(0, len(colors)-1)

    cid = cid if cid < len(colors) else cid - len(colors)
    cid = 1 if cid == 0 else cid
    color_name = colors[cid - 1]
    color_name = color_name if args.print_color_id is True else color_name.split(" ")[-1]
    logging.info(color_name)
