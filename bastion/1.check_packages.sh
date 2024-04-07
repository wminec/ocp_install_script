#!/bin/bash

. ./env.sh

# An array to hold the list of packages not installed
missing_packages=()

# Check if required packages are installed
for package in "${packages[@]}"; do
    if ! rpm -q $package &>/dev/null; then
        echo "Package $package is not installed"
        missing_packages+=("$package")
    fi
done

# Print the list of all packages not installed
if [ ${#missing_packages[@]} -gt 0 ]; then
    echo "Missing packages:"
    printf '%s\n' "${missing_packages[@]}"
    exit 1
fi

echo "All required packages for script execution are installed."
