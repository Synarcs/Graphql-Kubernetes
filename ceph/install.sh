echo "[x] creatng dynamic volumes "

yum install -y ceph-common

modprobe rbd  # enable kernel module of redHat rbd block storage
sudo ceph-authtool --create-keyring /etc/ceph/ceph.client.client.keyring


ceph osd pool create kube 1024
