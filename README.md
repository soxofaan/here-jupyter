**Update**: `here-jupyter` has been generalized to `here-this`: https://github.com/soxofaan/here-this


# Here Jupyter

Bash script to launch a Jupyter Notebook server in the background from current working directory.


It leverages (and assumes presence of):

- tmux to launch process in background, while still allowing to reattach if desired
- an anaconda environment (called `jupyter`) with a working jupyter notebook set up

## Installation

Put `here-jupyter.sh` in a location within your `$PATH`.

## Usage

Run from a desired working directory:

    here-jupyter.sh

This will launch a tmux session in the background with a name based on current directory, e.g. "Jupyter-foobardir",
start a `jupyter notebook` session there and show the initial output.

You can reattach to the tmux session (e.g. to kill jupyter or check the access token)
with for example:

    tmux -t Jupyter-foobardir

It is also possible to dump the latest output/logs without attaching:

    tmux capture-pane -p -t Jupyter-foobardir

