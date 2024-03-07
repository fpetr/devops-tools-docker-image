FROM alpine
RUN apk update --no-cache && apk upgrade --no-cache
RUN apk add --no-cache curl jq yq wget

## Install Helm
ENV HELM_VERSION="3.14.2"
ENV HELM_ARCH="amd64"
RUN curl -o /tmp/helm.tar.gz https://get.helm.sh/helm-v${HELM_VERSION}-linux-${HELM_ARCH}.tar.gz && \
    tar xzf /tmp/helm.tar.gz && mv /linux-${HELM_ARCH}/helm /usr/local/bin/helm && \
    rm -rf linux-${HELM_ARCH} /tmp/helm.tar.gz

## Install Helmfile
ENV HELMFILE_VERSION="0.162.0"
ENV HELMFILE_ARCH="amd64"
RUN cd /tmp && wget https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_${HELMFILE_VERSION}_linux_${HELMFILE_ARCH}.tar.gz && \
    tar xzf helmfile_${HELMFILE_VERSION}_linux_${HELMFILE_ARCH}.tar.gz && mv /tmp/helmfile /usr/local/bin/helmfile && \
    rm -rf ./*

## Install kubectl
ENV KUBECTL_VERSION="1.28.2"
ENV KUBECTL_ARCH="amd64"
RUN curl -o /usr/local/bin/kubectl -LO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/${KUBECTL_ARCH}/kubectl && \
    chmod 755 /usr/local/bin/kubectl
