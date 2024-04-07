#!/bin/bash

. ../bastion/env.sh
. env.sh

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

# if OCP
if [ "$RELEASE_NAME" == "ocp-release" ]; then
	# get manifest
	oc adm release mirror -a ${LOCAL_SECRET_JSON} \
        	--from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} \
        	--to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
        	--to-release-image=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE}-${ARCHITECTURE} \
        	--dry-run 2>&1 | tee mirror-dryrun-output_${OCP_RELEASE}.txt

	# mirror to file
	oc adm release mirror -a ${LOCAL_SECRET_JSON} \
        	--to-dir=${REMOVABLE_MEDIA_PATH}/mirror \
        	quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE}-${ARCHITECTURE} 2>&1 | tee mirror-to-file-output_${OCP_RELEASE}.txt

# if okd	
elif [ "$RELEASE_NAME" == "okd" ]; then 
	# get manifests
	oc adm release mirror -a ${LOCAL_SECRET_JSON} \
		--from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE} \
		--to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
		--to-release-image=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE} \
		--dry-run 2>&1 | tee mirror-dryrun-output_${OCP_RELEASE}.txt
	
	# mirror OCP container image to file
	oc adm release mirror -a ${LOCAL_SECRET_JSON} \
		--to-dir=${REMOVABLE_MEDIA_PATH}/mirror \
		quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE} 2>&1 | tee mirror-to-file-output_${OCP_RELEASE}.txt
fi
