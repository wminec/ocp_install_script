#!/bin/bash

. env.sh

## get OCP release DIGEST
DIGEST=$(oc adm release info -o 'jsonpath={.digest}{"\n"}' quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE} 2> /dev/null)

echo "DIGEST is : $DIGEST"

oc adm upgrade --allow-explicit-upgrade=true --force=true --to-image ${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}@${DIGEST}
