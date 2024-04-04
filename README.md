# ocp_install_script
install OCP with shell script  

# Environment
Platform: BareMetal
Bastion: RHEL 8.x or Rocky Linux 8.x  
Node: Red Hat CoreOS or Fedora CoreOS  

# Server info
| Purpose | sss | aaaa
|:-----------------------------------|:----------|:--------|
|*bastion(registry, l4, dns)*        | aa        | aaa     |

# description
## bastion
### prerequisite
yum repository should be configured
### scripts
Config bastion server
1. 'env.sh': Environments for config
2. 'check_packages.sh': Check if the required package is installed
3. 'make_registry': Create docker registry for OCP container image
4. 'config_dns.sh': Config dns (bind) for OCP
5. 'config_haproxy.sh': Config L4 (haproxy) for OCP
