#!/bin/bash

. env.sh

if command -v oc >/dev/null 2>&1; then
	echo "oc command is exists."
else
	echo "oc command is not exists!"
	exit 1
fi

# if OCP
if [ "$RELEASE_NAME" == "ocp" ]; then
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
	oc adm release mirror -a ${LOCAL_SECRET_JSON}
		--to-dir=${REMOVABLE_MEDIA_PATH}/mirror \
		quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE} 2>&1 | tee mirror-to-file-output_${OCP_RELEASE}.txt
fi
