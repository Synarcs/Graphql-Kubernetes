# Graphql-Kubernetes
Production Ready Kubernetes cluster with statefulset and ingress controller enabled further upgrade to Min.io hybrid S3 storage


# Kubernetes Cluster
## Cluster Specification
    * [x] 2 Worker Nodes 1 Master Control Plane
    * [x] Prometheus and Grifana Monitoring 
    * [x] Kubernetes DashBoard 
    * [x] Postgres StatefulSet 
    * [x] Custom Apollo-Server Graphql Image push to Docker Hub 
    * [x] Nginx Ingress Controller With Kube-proxy configured for Google DNS
    * [x] Gitlab CI/CD pipeline for automated Installing in Kubernets Cluster
    * [x] Automated Scripts for starting and creating ingress enabled Kubernetes Cluster
 
 
## Folder Overview
    * apolloServer 
       * [x] Sample Apollo Server Template with Docker image pushed to Docker Hub 
    * clusterInit
       * [x] Ingress Enabled Worker Plane for Inititalizing Kubernetes Cluster 
    * [x] All Configuration files for Kubernetes Cluster
    

## Future Project Improvements
   * [x] Adding Helm Charts and deploying to Artifactory Repository
   * [x] Adding Min.io as volume for remote S3 storage for Kubernetes Cluster
   
