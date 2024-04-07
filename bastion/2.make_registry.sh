#!/bin/bash

. ./env.sh

# Check Current Path
echo $CURRENTPATH

# make directories
mkdir -p $SRC_REGISTRY_BASE/{auth,certs,data,tools}


# create cert
openssl req -addext "subjectAltName=DNS:$SRC_REGISTRY" -subj "/C=KO/ST=Seoul/L=Seoul/O=OPENNARU/OU=OPENNARU/CN=$SRC_REGISTRY/emailAddress=support@opennaru.com" -newkey rsa:4096 -nodes -sha256 -keyout $SRC_REGISTRY_BASE/certs/registry.key -x509 -days 3650 -out $SRC_REGISTRY_BASE/certs/registry.crt

# copy cert and update-ca-trust
cp $SRC_REGISTRY_BASE/certs/registry.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust extract

# create htpasswd auth
htpasswd -bBc $SRC_REGISTRY_BASE/auth/htpasswd $SRC_REGISTRY_ID $SRC_REGISTRY_PASS

# load registry image
#podman load -i $CURRENTPATH/registry.tar

# create registry run script
echo -e "podman run --name ocp-registry --rm -d -p ${SRC_REGISTRY_PORT}:5000 \\
-v ${SRC_REGISTRY_BASE}/data:/var/lib/registry:z \\
-v ${SRC_REGISTRY_BASE}/auth:/auth:z \\
-v ${SRC_REGISTRY_BASE}/certs:/certs:z \\
-e REGISTRY_AUTH=htpasswd \\
-e REGISTRY_AUTH_HTPASSWD_REALM=Registry \\
-e REGISTRY_HTTP_SECRET=ALongRandomSecretForRegistry \\
-e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \\
-e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.crt \\
-e REGISTRY_HTTP_TLS_KEY=/certs/registry.key \\
-e REGISTRY_STORAGE_DELETE_ENABLED=true \\
docker.io/library/registry:latest" > $SRC_REGISTRY_BASE/tools/start_registry.sh

# change file permission
chmod +x $SRC_REGISTRY_BASE/tools/start_registry.sh

# run registry
$SRC_REGISTRY_BASE/tools/start_registry.sh

# test tmp_registry
sleep 2
echo -e "\n test registry"
curl -u $SRC_REGISTRY_ID:$SRC_REGISTRY_PASS -k https://$SRC_REGISTRY:$SRC_REGISTRY_PORT/v2/_catalog

