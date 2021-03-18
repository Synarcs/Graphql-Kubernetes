echo "[x] monitor the main Kubernetes cluster"
kubectl cluster-info --context kind-graphql-cluster
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
kubectl get svc | grep "Kubernetes"
kubectl config get-clusters