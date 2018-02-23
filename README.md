
[//]: # ( Copyright 2018 Turbine Labs, Inc.                                   )
[//]: # ( you may not use this file except in compliance with the License.    )
[//]: # ( You may obtain a copy of the License at                             )
[//]: # (                                                                     )
[//]: # (     http://www.apache.org/licenses/LICENSE-2.0                      )
[//]: # (                                                                     )
[//]: # ( Unless required by applicable law or agreed to in writing, software )
[//]: # ( distributed under the License is distributed on an "AS IS" BASIS,   )
[//]: # ( WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or     )
[//]: # ( implied. See the License for the specific language governing        )
[//]: # ( permissions and limitations under the License.                      )

# GCloud SDK Build Image

[![Apache 2.0](https://img.shields.io/badge/license-apache%202.0-blue.svg)](LICENSE)

This is an image intended to be used as a build base image in a CI
environment. It's based on the
[official CloudSDK alpine image](https://github.com/GoogleCloudPlatform/cloud-sdk-docker/blob/master/alpine/Dockerfile),
however it also includes docker and kubectl so you can build and deploy docker
images. It will also automatically configure gcloud to access a specific GKE
cluster based on environment variables.

## Requirements

To build this project you will
need [Docker](https://docs.docker.com/engine/installation/). To deploy a project
to GCloud you'll need a [GCloud Account](https://cloud.google.com/) account.

## Running

This image uses environment variables to configure GCloud authentication,
project ids, compute zones and cluster names. Observed environment variables are

* `GOOGLE_AUTH`: a base64 encoded [service account key](https://cloud.google.com/docs/authentication/getting-started)
* `GCLOUD_PROJECT_ID`: the ID (not name!) of the project you wish to work with
* `GCLOUD_COMPUTE_ZONE`: the compute zone your cluster is located in
* `GCLOUD_CLUSTER_NAME`: the name of the cluster you wish to work with

Given the length of the GOOGLE_AUTH variable we suggest you keep these values in
a file, e.g.

```
GOOGLE_AUTH=<your base64 encoded service account key>
GCLOUD_PROJECT_ID=<your project ID>
GCLOUD_COMPUTE_ZONE=<your compute zone>
GCLOUD_CLUSTER_NAME=<your cluster name>
```

CloudSDK configuration is performed when the run level is changed to "boot". To
use the container to execute builds you can run

```console
docker run --env-file <your settings> -it turbinelabs/gcloud-build:latest /bin/bash

open rc boot
```

## Building

If you want to build your own image you can run the following:

```
docker build -t turbinelabs/gcloud-build:local .
```

By default this will build an Alpine Linux 3.5 image with GCloud SDK version
168.0.0 and docker. You can override the GCloud SDK version by setting the
CLOUD_SDK_VERSION environment variable. You can then use your locally built
image by running:

```console
docker run --env-file <your settings> -it turbinelabs/gcloud-build:latest /bin/bash

open rc boot
```

## Versioning

Please see [Versioning of Turbine Labs Open Source Projects](http://github.com/turbinelabs/developer/blob/master/README.md#versioning).

## Pull Requests

Patches accepted! Please see [Contributing to Turbine Labs Open Source Projects](http://github.com/turbinelabs/developer/blob/master/README.md#contributing).

## Code of Conduct

All Turbine Labs open-sourced projects are released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in our
projects you agree to abide by its terms, which will be carefully enforced.
