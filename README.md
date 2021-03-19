## Folder Structure 
    * ApolloServer 
        [x] Development folder with deployment scripts to deploy apollo-server image to Docker Hub 
        [x] Deployement to dockerhub can be modified to any private or public artifactory 
    * cluster-init 
        [x] Inititalize the Kubernetes Cluster 
        [x] Inittialize Ingress Capable Nodes with Nginx ingress controller 
        [x] Starts Kubernetes Dashboard for cluster service 
        [x] Configured and manipulated Kube-Dns for public namespace server
    * Root Folder 
        [x] apollo-server.yaml --> Pulls ApolloServer custom image and create Deployment with Apollo-service
        [x] ingress.yaml --> ingress configuration for nginx controller to point to apollo-service
        [x] pass-secret.yaml --> File storing secrets for Kubernetes
        [x] psk-volume.yaml --> PSVC,PSV for postgres pods for a storage class
        [x] postgres-config.yaml --> file to start postgres pod and services refers uses PSVC inside a storage class
        [x] storage-class.yaml --> file for starting the storage class used by PSVC,PSV 
        [x] remote-connect.sh --> connect to remote cluster for private cloud instance
        [x] install-service --> Apply all configuration to the cluster