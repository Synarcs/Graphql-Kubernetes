
echo "[x] snampshot CRDS for CSI snapshot storage"
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v2.1.5/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v2.1.5/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v2.1.5/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml


echo "[x] snapshot controllers"
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v2.1.5/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v2.1.5/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml


echo "[x] installing CSI hostpath csi provisioners and storage"


echo "[x] ingress controller"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.0/deploy/static/provider/aws/deploy.yaml

echo "[x] Load Balance"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"


chectl server:deploy --platform=k8s --version=7.28.0 --installer=operator --domain 172.17.250.1.nip.io

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
      - 10.222.62.40-10.222.62.255
EOF

docker inspect bridge | grep -C 5 Subnet
kubectl apply -f metallb-config.yaml 
