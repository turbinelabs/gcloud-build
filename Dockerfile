FROM alpine:3.5
ENV CLOUD_SDK_VERSION 168.0.0

ENV PATH /google-cloud-sdk/bin:$PATH

ADD gcloud-init.sh /etc/local.d/gcloud-init.start
RUN chmod 700 /etc/local.d/gcloud-init.start

RUN apk --no-cache add \
        curl \
        python \
        py-crcmod \
        bash \
        libc6-compat \
        openrc \
        openssh-client \
        git \
        docker \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --quiet components install kubectl && \
    rc-update add docker boot && \
    rc-update add local boot && \
    echo 'rc_env_allow="GOOGLE_AUTH GCLOUD_PROJECT_ID GCLOUD_COMPUTE_ZONE GCLOUD_CLUSTER_NAME HOME"' >> /etc/rc.conf && \
    echo 'rc_verbose=yes' >> /etc/conf.d/local
