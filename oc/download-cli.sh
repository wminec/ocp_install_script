#!/bin/bash

. ./env.sh

mkdir -p $WORKDIR/$OCP_RELEASE

wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$OCP_RELEASE/openshift-client-linux-$OCP_RELEASE.tar.gz -O $WORKDIR/$OCP_RELEASE/openshift-client-linux-$OCP_RELEASE.tar.gz
tar xfz $WORKDIR/openshift-client-linux-$OCP_RELEASE.tar.gz -C $WORKDIR/$OCP_RELEASE

wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$OCP_RELEASE/openshift-install-linux-$OCP_RELEASE.tar.gz -O $WORKDIR/$OCP_RELEASE/openshift-install-linux-$OCP_RELEASE.tar.gz
tar xfz $WORKDIR/openshift-install-linux-$OCP_RELEASE.tar.gz -C $WORKDIR/$OCP_RELEASE
rm -rf $WORKDIR/$OCP_RELEASE/README.md
