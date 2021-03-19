## Folder Structure 
   * [x] Dockerfile (Custom Docker Image To build docker image for apolloServer)
   * [x] build.sh (file to push the image to docker hub)
   * [x] .env configuration file stored for apolloserver 
   # Note
        * [x]  Changes can be made in app.js or support files and run dockerFile to build and push the image 


## Note 
    * Currenlty using apolloimage with postgres connection to statefulset  service in single Kubernetest cluster.
    * Can be moved on to a different Cluster or instance just requires postgres connection either to local or a remote Service
    * Added Sample test for cluster check not for Unit Test 
    