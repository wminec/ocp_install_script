#!/bin/bash

WORKDIR=/DATA/ocp
export OCP_RELEASE=4.11.43
export LOCAL_REGISTRY='bastion-happymoney.ocp4.sye.home:5000'
export LOCAL_REPOSITORY='ocp4/4.11.43'
export PRODUCT_REPO='openshift-release-dev'
export LOCAL_SECRET_JSON='/DATA/oc/pull-secret-bundle.json'
export RELEASE_NAME="ocp-release"
export ARCHITECTURE=x86_64
REMOVABLE_MEDIA_PATH=$WORKDIR/mirror
