#!/bin/bash

. env.sh

# check oc command is exist
if command -v oc >/dev/null 2>&1; then
        echo "oc command is exists."
else
        echo "oc command is not exists!"
        exit 1
fi

# Push OCP Cluster Operator Container Image to Registry
oc image mirror -a ${LOCAL_SECRET_JSON} \
	--from-dir=${REMOVEABLE_MEDIA_PATH}/mirror "file://openshift/release:${OCP_RELEASE}*" \
	${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} 2>&1 | tee file-to-registry-output_${OCP_RELEASE}.txt
