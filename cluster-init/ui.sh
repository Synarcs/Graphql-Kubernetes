kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
kubectl get pods
echo "unabling control plane and 4 worker nodes on dashboard"

kubectl proxy