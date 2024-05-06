#!/bin/bash

. ./env.sh

# backup org config with the current timestamp
cp -av "$haproxy_config_file" "$haproxy_backup_file"

# Prepare to write the output file
> "$haproxy_config_file"

# Read the input file line by line and write to the output file until a specific string is found
while IFS= read -r line; do
    echo "$line" >> "$haproxy_config_file"
    # Terminate the loop when a specific string is found
    if [[ "$line" == *"$haproxy_search_string"* ]]; then
        echo "#---------------------------------------------------------------------" >> "$haproxy_config_file"
        echo >> "$haproxy_config_file"
        break
    fi
done < "$haproxy_backup_file"

# Function to add servers to a backend
add_servers_to_backend() {
    local backend_name="$1"
    local ip_array_name="$2[@]"
    local port="$3"

    echo "frontend $backend_name"
    echo "    bind *:$port"
    echo "    default_backend $backend_name"
    echo "    mode tcp"
    echo "    option tcplog"
    echo
    echo "backend $backend_name"
    echo "    balance source"
    echo "    mode tcp"

    local ip_array=("${!ip_array_name}")
    if [[ "$backend_name" == "openshift-api-server" || "$backend_name" == "machine-config-server" ]]; then
        echo "    server bootstrap ${BS_IP}:$port check"
    fi
    for ((i=0; i<${#ip_array[@]}; i++)); do
        if [[ $backend_name == *"ingress"* ]]; then
            echo "    server worker$((i+1)) ${ip_array[$i]}:$port check inter 1s"
        else
            echo "    server master$((i+1)) ${ip_array[$i]}:$port check inter 1s"
        fi
    done

    echo
}

# Add servers for openshift-api-server
add_servers_to_backend "openshift-api-server" "M_IP" 6443 >> $haproxy_config_file

# Add servers for machine-config-server
add_servers_to_backend "machine-config-server" "M_IP" 22623 >> $haproxy_config_file

# Add servers for ingress-http
add_servers_to_backend "ingress-http" "W_IP" 80 >> $haproxy_config_file

# Add servers for ingress-https
add_servers_to_backend "ingress-https" "W_IP" 443 >> $haproxy_config_file
