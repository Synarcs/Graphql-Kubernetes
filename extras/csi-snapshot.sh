echo "[x] snampshot CRDS for CSI snapshot storage"
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v2.1.5/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v2.1.5/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v2.1.5/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml

echo "[x] snapshot controllers"
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v2.1.5/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v2.1.5/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml

echo "[x] installing CSI hostpath csi provisioners and storage"
git clone https://github.com/kubernetes-csi/csi-driver-host-path && cd csi-driver-host-path
cd deploy/kubernetes-1.20/
bash deploy.sh
cd .. 
cd ..
kubectl apply -f examples/csi-storageclass.yaml

echo "[x] ingress controller"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.0/deploy/static/provider/aws/deploy.yaml

echo "[x] Load Balance"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# ./chectl server:start --platform=k8s  --installer=operator --domain 192.168.34.100.nip.io

echo "get subnet for kind bridge"
lsblk=$(docker network inspect -f '{{.IPAM.Config}}' kind)
defaullt="172.18.255.200" 
dockerdefault="172.19.0.0/16"
echo $lsblk

echo "coniguring metallb loadbalancer over ingresss"
kubectl get svc -n ingress-nginx 

cat << EOF > metallb-config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 127.0.0.1- 
      - 172.17.0.1-172.17.0.255
EOF


kubectl apply -f metallb-config.yaml 
chectl server:deploy --platform k8s --installer operator --multiuser --domain 172.18.255.200.nip.io 
chectl cacert:export 

echo "get auth passward at eclipse identity che web server"
kubectl get secret -n eclipse-che 

