#!/bin/bash

. env.sh

# check oc command is exist
if command -v oc >/dev/null 2>&1; then
        echo "oc command is exists."
else
        echo "oc command is not exists!"
        exit 1
fi

openshift-install create manifests --dir=$WORKDIR/install_dir/

# Create install-config.yaml
files=( template/*.bu )

# 배열 순회하며 파일 확장자 변경 및 변환
# template/*.bu -> template/*.yaml use butane command
for file in "${files[@]}"
do
  $OCP_RELEASE/butane $file -o "${file%%.*}.yaml"
done

cp -v template/*.yaml install_dir/openshift/
