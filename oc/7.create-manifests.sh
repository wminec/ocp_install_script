#!/bin/bash

. env.sh

# check oc command is exist
if command -v oc >/dev/null 2>&1; then
        echo "oc command is exists."
else
        echo "oc command is not exists!"
        exit 1
fi

# Create install-config.yaml

cp template/install-config.yaml_ori ./install-config.yaml



echo "you must modify install-config.yaml"
