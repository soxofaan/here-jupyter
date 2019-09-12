#!/bin/bash

# Build tmux session name from current directory
SESSION_NAME=$(pwd)
# Strip non-alphanumeric characters
SESSION_NAME=${SESSION_NAME//[^a-zA-Z0-9]/}
# Only keep trailing part
SESSION_NAME=Jupyter-${SESSION_NAME: -20}

# Build command to run inside tmux session
CONDA_ENV=jupyter
# Anaconda environment activation is based on https://github.com/conda/conda/issues/7980
COMMAND='eval "$(conda shell.bash hook)";'
COMMAND+="conda activate $CONDA_ENV;"
COMMAND+='jupyter notebook;'
# Sleep a bit to allow capturing of error messages if things go wrong
COMMAND+='sleep 2;'

echo "Starting tmux session '$SESSION_NAME' in background with command $COMMAND" 
if tmux new-session -s $SESSION_NAME -d "$COMMAND"; then
    echo "Tmux session launched with initial output:"
    sleep 2
    echo "----------------------------------------------------------------"
    tmux capture-pane -p -t $SESSION_NAME | sed '/^$/d'
    echo "----------------------------------------------------------------"
    echo "To re-attach:"
    echo "    tmux attach -t $SESSION_NAME"
    echo "To dump latest output/logs:"
    echo "    tmux capture-pane -p -t $SESSION_NAME"
else
    echo "Failed to launch tmux"
fi

