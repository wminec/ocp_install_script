#!/bin/bash

. ../bastion/env.sh
. env.sh

if command -v oc >/dev/null 2>&1; then
	echo "oc command is exists."
else
	echo "oc command is not exists!"
	exit 1
fi

if [ ! -f redhat-pullsecret.json ]; then
        echo "redhat-pullsecret.json not found.."

	exit 1
fi

yes|cp redhat-pullsecret.json /run/user/$(id -u)/containers/auth.json

podman login -u ${SRC_REGISTRY_ID} -p ${SRC_REGISTRY_PASS} ${SRC_REGISTRY}:${SRC_REGISTRY_PORT}

mkdir ~/.docker
cp /run/user/$(id -u)/containers/auth.json ~/.docker/config.json

cat /run/user/$(id -u)/containers/auth.json |jq -c > pull-secret-private.json


# if OCP
if [ "$RELEASE_NAME" == "ocp-release" ]; then

	oc-mirror --config=./mirror-config.yaml file://mirror

# if okd	
elif [ "$RELEASE_NAME" == "okd" ]; then 

	oc-mirror --config=./mirror-config.yaml file://mirror
fi
