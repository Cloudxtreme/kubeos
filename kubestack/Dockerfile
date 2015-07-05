FROM kelseyhightower/kubeos:0.20.2
MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>

COPY pod.json /etc/kubernetes/manifests/pod.json 

VOLUME /var/lib/etcd
VOLUME /var/lib/kubelet
VOLUME /var/lib/kubernetes

CMD ["/usr/bin/kubelet", "--containerized", "--api-servers=http://127.0.0.1:8080", "--v=2", "--address=0.0.0.0", "--enable-server", "--hostname-override=127.0.0.1", "--config=/etc/kubernetes/manifests/pod.json", "--machine-id-file=/rootfs/etc/machine-id", "--allow-privileged"]
