#!/bin/bash

. ./env.sh

commands=(curl jq)

for cmd in "${commands[@]}"; do
        if command -v  >/dev/null 2>&1; then
                echo "$cmd command is exists."
        else
                echo "$cmd command is not exists!"
                exit 1
        fi
done


# CHANNEL.
## if OCP. EX) stable-4.11
## if okd. EX) stable-4
CHANNEL=stable-4

# if OCP
if [ "$RELEASE_NAME" == "ocp-release" ]; then
	
	# print ocp versions
	curl -s https://api.openshift.com/api/upgrades_info/graph?channel=$CHANNEL | jq -r '.nodes[] | "\(.version)"' | sort -V
	
	## print versions with payload (digest)
	#curl -s https://api.openshift.com/api/upgrades_info/graph?channel=$CHANNEL | jq '.nodes[] | {version: .version, payload: .payload}'

# if okd	
elif [ "$RELEASE_NAME" == "okd" ]; then 

	# print stable versions
	curl -s https://origin-release.ci.openshift.org/graph?channel=$CHANNEL | jq -r '.nodes[] | "\(.version)"' | sort -V

	## print versions with payload (digest)
	#curl -s https://api.openshift.com/api/upgrades_info/graph?channel=$CHANNEL | jq '.nodes[] | {version: .version, payload: .payload}'
fi
