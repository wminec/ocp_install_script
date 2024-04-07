# ocp_install_script
install OCP with shell script  

# Environment
Platform: BareMetal (for Air gap)
Bastion: RHEL 8.x or Rocky Linux 8.x  
Node: Red Hat CoreOS or Fedora CoreOS  

# Server info
|   host   |         purpose					 |
|:---------|:------------------------------------|
|bastion   | registry, L4, DNS Server			 |
|OCP Nodes | OCP Bootstrap, Master, Worker Nodes |

# description
## bastion
### prerequisite
yum repository should be configured
### scripts
Config bastion server
1. `1.check_packages.sh`: Check if the required package is installed
1. `2.make_registry`: Create docker registry for OCP container image
1. `3.config_dns.sh`: Config dns (bind) for OCP
1. `4.config_haproxy.sh`: Config L4 (haproxy) for OCP
1. `env.sh`: Environments for config

## oc
### scripts
download CLI tools and mirror OCP container image
1. `1.check_ocp_version.sh`: Check OCP version with Channel
1. `2.download-cli.sh`: download CLI tools
1. `3.download-coreos-iso.sh`: download CoreOS ISO
1. `4.mirror-to-file.sh`: mirror OCP container image to file
1. `5.file-to-registry.sh`: push OCP container image to registry
1. `6.create-installconfig.sh`: create install_dir directory and install-config.yaml
1. `7.create-manifests.sh`: create manifests. but you need to modify "install-config.yaml" before run this script
1. `8.create-ignition.sh`: create ignition files
1. `9.upgrade_cluster.sh`: upgrade OCP cluster use oc command
1. `env.sh`: Environments for download CLI and mirror OCP container image