echo "[x] installing pso-orchestrator [CSI] inside cluster "
helm repo add pure https://purestorage.github.io/pso-csi
helm repo update
helm search repo pure-pso -l

helm repo ls 
helm install pure-pso pure/pure-pso -f pso-config.yaml -n minio-storage --dry-run --debug
helm install pure-pso pure/pure-pso -f pso-config.yaml -n minio-storage 

# for now kept all in defaullt namesapve
# patching the namespace first install storage class
kubectl apply -f storage-class.yaml
kubectl patch storageclass pure-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl patch storageclass pure-file -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

