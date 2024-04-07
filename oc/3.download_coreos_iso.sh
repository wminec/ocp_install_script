#!/bin/bash

commands=(wget)

for cmd in "${commands[@]}"; do
        if command -v  >/dev/null 2>&1; then
                echo "$cmd command is exists."
        else
                echo "$cmd command is not exists!"
                exit 1
        fi
done

# download CoreOS iso for BareMetal
wget $(openshift-install coreos print-stream-json | jq -r '.architectures.x86_64.artifacts.metal.formats.iso.disk.location')
