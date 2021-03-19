## Folder Configurtion
    * All Kubernetes Setup config files and scripts in cluster-init folder
        create-cluster,ingress-cluster,kube-config,install-ingress.sh,start.sh,ui.sh,service-monitor.yaml,ingress.yaml
    * Create ApolloServer Build folder in ApolloServer Folder
        move Dockerfile and build.sh app.js .env package.json in it 
    * main Configuration 
        * .gitlab-ci.yaml
        * storage-class.yaml
        * psk-volumes.yaml
        * db-config.yaml
        * pass-secret.yaml
        * postgres-config.yaml
        * apollo-server.yaml

        -- 
            First --> remote-connect.sh 
            Second --> install-service.sh
            health.sh [Move this to Cluster-init Folder]


