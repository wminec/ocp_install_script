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
files=( template/*.bu )

# 배열 순회하며 파일 확장자 변경 및 변환
for file in "${files[@]}"
do
  new_file="${file//template/install_dir\/openshift}"
  new_file="${new_file%.*}.yaml"
  echo $new_file
  $OCP_RELEASE/butane "$file" -o "$new_file"
done

cp -v template/*.yaml install_dir/openshift/
