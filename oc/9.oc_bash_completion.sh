#!/bin/bash

if command -v oc >/dev/null 2>&1; then
        echo "oc command is exists."
else
        echo "oc command is not exists!"
        exit 1
fi


if [ $(id -u) -eq 0 ]; then
	echo "User name is root."
	echo "oc bash completion is added to /etc/bash_completion.d/oc_completion"
	oc completion bash >> /etc/bash_completion.d/oc_completion
	echo "Please run command \". /etc/bash_completion.d/oc_completion \""
else
	echo "User name is not $(id -u)"
	echo "oc bash completion is added to ~/.bashrc"
	oc completion bash >> ~/.bashrc
	echo "Please run command \". ~/.bashrc \""
fi
