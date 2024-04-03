#!/bin/bash

WORKDIR=/root/test/oc
OCP_RELEASE=4.11.0-0.okd-2023-01-14-152430
LOCAL_REGISTRY='bastion.okd4.sye.home:5000'
LOCAL_REPOSITORY='okd4/release'
PRODUCT_REPO='openshift'
LOCAL_SECRET_JSON='/root/test/oc/pull-secret-private.json'
RELEASE_NAME="okd"
ARCHITECTURE=x86_64
REMOVABLE_MEDIA_PATH=/root/test/mirror
