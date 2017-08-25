# Cloud SDK Build Image

This is an image intended to be used as a build base image in a CI
environment. It's based on the (official CloudSDK alpine
image)[https://github.com/GoogleCloudPlatform/cloud-sdk-docker/blob/master/alpine/Dockerfile],
however it also includes docker and kubectl so you can build and
deploy docker images. It will also automatically configure gcloud to
access a specific GKE cluster based on environment variables. Observed
environment variables are

* CLOUD_SDK_VERSION - the version of CloudSDK you want to install
(defaults to 168.0.0)
* GOOGLE_AUTH - an base64 encoded (service account key)[https://cloud.google.com/docs/authentication/getting-started]
* GCLOUD_PROJECT_ID - the ID (not name!) of the project you wish to
  work with
* GCLOUD_COMPUTE_ZONE - the compute zone your cluster is located in
* GCLOUD_CLUSTER_NAME - the name of the cluster you wish to work with

Note that CloudSDK configuration is performed when the run level is
changed to "boot". If you want to use the container to execute builds
you can run

```console
docker run --env-file <your settings> -it turbinelabs/gcloud-build:latest /bin/bash

open rc boot
```
