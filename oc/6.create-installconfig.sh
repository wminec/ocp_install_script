#!/bin/bash

. env.sh

if [ -d install_dir ]; then

        echo "install_dir is exists. delete this directory.."
        rm -rf install_dir
fi



# check oc command is exist
if command -v oc >/dev/null 2>&1; then
        echo "oc command is exists."
else
        echo "oc command is not exists!"
        exit 1
fi

# Create install-config.yaml
if [ ! -f install-config.yaml ]; then
        echo "install-config not found.."
        cp template/install-config.yaml_ori ./install-config.yaml
        echo "you must modify install-config.yaml"
        echo "retry this script!!!"

	exit 2
fi

if [ ! -d install_dir ]; then
        mkdir install_dir
fi

cp -v install-config.yaml install_dir/
