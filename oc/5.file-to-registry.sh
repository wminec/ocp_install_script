#!/bin/bash

. ../bastion/env.sh

. env.sh

# check oc command is exist
if command -v oc >/dev/null 2>&1; then
        echo "oc command is exists."
else
        echo "oc command is not exists!"
        exit 1
fi

if [ ! -f pull-secret-private.json ]; then
        echo "pullsecret not found.."
	podman login -u ${SRC_REGISTRY_ID} -p ${SRC_REGISTRY_PASS} ${SRC_REGISTRY}:${SRC_REGISTRY_PORT}
        cat /run/user/$(id -u)/containers/auth.json |jq -c > pull-secret-private.json
fi

# Push OCP Cluster Operator Container Image to Registry

echo "CHANGEME"
# oc-mirror --from mirror_seq1_000000.tar docker://container-registry.kcbcore.com:5000/okd4


#oc-mirror list operators --catalog=registry.redhat.io/redhat/redhat-operator-index:v4.14

echo "CHANGEME"
