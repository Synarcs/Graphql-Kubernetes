echo "[x] connecting to remote kubernetes cluster"


kubectl config set-cluster kind-graphql-cluster --server=http://10-222-52-144.ssnc-corp.cloud 
kubectl config use-context kind-graphql-cluster


kubectl cluster-info --context kind-graphql-cluster
kubectl describe nodes

