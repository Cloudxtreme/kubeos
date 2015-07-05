# KubeOS
#
# VERSION 0.20.2
FROM debian:jessie

MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>

LABEL kubernetes.version="0.20.2"
LABEL etcd.version="2.0.13"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    iptables \
    util-linux

ENV KUBERNETES_ETCD_VERSION 2.0.13
ENV KUBERNETES_VERSION 0.20.2
ENV KUBERNETES_RELEASE_URL https://storage.googleapis.com/kubernetes-release/release/v$KUBERNETES_VERSION/bin/linux/amd64

# Download and install etcd.
RUN curl -o etcd-v${KUBERNETES_ETCD_VERSION}-linux-amd64.tar.gz \
    -L https://github.com/coreos/etcd/releases/download/v${KUBERNETES_ETCD_VERSION}/etcd-v${KUBERNETES_ETCD_VERSION}-linux-amd64.tar.gz \
    && tar -xzvf etcd-v${KUBERNETES_ETCD_VERSION}-linux-amd64.tar.gz \
    && mv etcd-v${KUBERNETES_ETCD_VERSION}-linux-amd64/etcd /usr/bin/etcd \
    && mv etcd-v${KUBERNETES_ETCD_VERSION}-linux-amd64/etcdctl /usr/bin/etcdctl \
    && chmod 755 /usr/bin/etcd* \
    && rm -rf etcd-v${KUBERNETES_ETCD_VERSION}-linux-amd64.tar.gz etcd-v${KUBERNETES_ETCD_VERSION}-linux-amd64

# Download and install Kubernetes.
RUN for b in kube-apiserver kube-proxy kube-scheduler kube-controller-manager kubelet kubectl; do \
      curl -o /usr/bin/${b} -L ${KUBERNETES_RELEASE_URL}/${b}; \
      chmod 755 /usr/bin/${b}; \
    done

# Make nsenter available at / for the kubelet in a container hack.
RUN ln -s /usr/bin/nsenter /nsenter
