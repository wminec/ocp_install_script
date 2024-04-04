# ocp_install_script
install OCP with shell script  

# Environment
Platform: BareMetal (for Air gap)
Bastion: RHEL 8.x or Rocky Linux 8.x  
Node: Red Hat CoreOS or Fedora CoreOS  

# Server info
|   host   |         purpose         |
|:---------|:------------------------|
|bastion   | registry, L4, DNS Server|

# description
## bastion
### prerequisite
yum repository should be configured
### scripts
Config bastion server
1. `env.sh`: Environments for config
1. `check_packages.sh`: Check if the required package is installed
1. `make_registry`: Create docker registry for OCP container image
1. `config_dns.sh`: Config dns (bind) for OCP
1. `config_haproxy.sh`: Config L4 (haproxy) for OCP

## oc
### scripts
download CLI tools and mirror OCP container image
1. `env.sh`: Environments for download CLI and mirror OCP container image
1. `download-cli.sh`: download CLI tools
1. `mirror-to-file.sh`: mirror OCP container image to file
1. `file-to-registry.sh`: push OCP container image to registry