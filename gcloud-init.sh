#!/bin/bash

# Exit on any error
set -e
# Exit on undefined env var
set -u
echo $GOOGLE_AUTH | base64 -d > ${HOME}/gcloud-service-key.json
/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file ${HOME}/gcloud-service-key.json
/google-cloud-sdk/bin/gcloud config set project $GCLOUD_PROJECT_ID
/google-cloud-sdk/bin/gcloud --quiet config set container/cluster $GCLOUD_CLUSTER_NAME
/google-cloud-sdk/bin/gcloud config set compute/zone ${GCLOUD_COMPUTE_ZONE}
/google-cloud-sdk/bin/gcloud --quiet container clusters get-credentials $GCLOUD_CLUSTER_NAME
