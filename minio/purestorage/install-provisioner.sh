echo "[x] installing pso-orchestrator [CSI] inside cluster "
helm repo add pure https://purestorage.github.io/helm-charts
helm repo update
helm search pure-k8s-plugin

helm repo ls 
helm install --name pure-storage-driver pure/pure-k8s-plugin -f pso-config --dry-run --debug
helm install --name pure-storage-driver pure/pure-k8s-plugin -f pso-config 

# for now kept all in defaullt namesapve
# patching the namespace first install storage class
kubectl apply -f storage-class.yaml
kubectl patch storageclass pure-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl patch storageclass pure-file -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'


