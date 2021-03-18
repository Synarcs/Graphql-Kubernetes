set -o errexit

# create registry container unless it already exists
reg_name='registry'
reg_port='5000'
cluster_name='graphql-cluster'
config_file='ingress-cluster.yaml'
running="$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)"
if [ "${running}" != 'true' ]; then
  docker run \
    -d --restart=always -p "${reg_port}:5000" --name "${reg_name}" \
    registry:2
fi

# create a cluster with the local registry enabled in containerd
kind create cluster --name "${cluster_name}" --config $config_file

docker network connect "kind" "${reg_name}"

# annoate for the local registry pointed by helm
# find the required naes in kubernetes cluster nodes
# configure further the schema registry to point to SS&C artifcat repos

for node in $(kind get nodes --name=${cluster_name}); do
  kubectl annotate node "${node}" "kind.x-k8s.io/registry=localhost:${reg_port}" --context "kind-${cluster_name}" ;
done