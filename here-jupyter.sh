#!/bin/bash

# Build session name from current dir
SESSION_NAME=$(pwd)
SESSION_NAME=${SESSION_NAME//[^a-zA-Z0-9]/}
SESSION_NAME=Jupiter-${SESSION_NAME: -20}

# Command to run inside tmux session
# based on https://github.com/conda/conda/issues/7980
COMMAND='eval "$(conda shell.bash hook)"; conda activate jupyter; jupyter notebook; sleep 5'

echo "Starting tmux session '$SESSION_NAME' in background with command $COMMAND" 
if tmux new-session -s $SESSION_NAME -d "$COMMAND"; then
	echo "tmux launched with initial output:"
	sleep 1
	tmux capture-pane -p -t $SESSION_NAME
	echo "to re-attach:"
	echo "    tmux attach -t $SESSION_NAME"
else
	echo "Failed to launch tmux"
fi
