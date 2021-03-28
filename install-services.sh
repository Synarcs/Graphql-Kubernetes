echo "[x] setting up the kubernetes cluster config will upgrade to helm"

#kubectl apply -f storage-class.yaml
#kubectl apply -f psk-volumes.yaml
kubectl apply -f db-config.yaml
kubectl apply -f pass-secret.yaml
kubectl apply -f postgres-config.yaml
kubectl apply -f apollo-server.yaml
kubectl apply -f ingress.yaml

echo "[x] configured ingress,svc,pvc,pv,nginx-ingress controller in kind 4 nodes control plane"
