if [ -z "$https_proxy" ];then export https_proxy=http://dstproxy.dstcorp.net:9119;else echo "proxy is set"
if [ -z "$http_proxy" ];then export http_proxy=http://dstproxy.dstcorp.net:9119;else echo "proxy is set"
if [ -z "$no_proxy" ];then export no_proxy=http://dstproxy.dstcorp.net:9119;else echo "proxy is set"

echo $https_proxy 
echo $http_proxy 
echo $no_proxy 

WORKDIR="/home/vagrant"

echo "root dependencies"
sudo yum update && sudo yum install -y curl,wget 
sudo yum install -y git 

echo "installing  docker"
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum update
sudo yum install docker-ce  containerd.io
sudo usermod -aG docker $USER && newgrp docker

echo "configure docker proxies"
cd /etc/systemd/system
sudo mkdir docker.service.d 
chmod -r 777 docker.service.d && cd docker.service.d 
cd /
sudo su 
sudo cat <<EOF > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://dstproxy.dstcorp.net:9119"
Environment="HTTPS_PROXY=http://dstproxy.dstcorp.net:9119"
Environment="NOPROXY=localhost,127.0.0.1, 172.17.0.1, 172.30.1.1, *.dstsystems.com, *.globeop.com, *.ssnc-corp.cloud, *.dstcorp.net, *.bfwebsolutions.com, *.newkirkone.com, 10.138.55.110,GATEWAY=yes"
EOF

echo "minikube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
sudo rpm -ivh minikube-latest.x86_64.rpm

echo "installing kubectl"
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl

echo "install Kind" 
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.10.0/kind-linux-amd64
sudo chmod +x ./kind
cp ./kind /bin 
mv ./kind /usr/local/bin 


path_name="/usr/local/bin"
echo "adding main path"
sudo export PATH="/usr/local/bin:$PATH"
echo "main path added $path_name"
bash <(curl -sL  https://www.eclipse.org/che/chectl/)

echo "getting che"
sudo yum install git sudo yum install -y wget 
wget -v https://github.com/che-incubator/chectl/releases/download/7.28.1/chectl-linux-x64.tar.gz
tar -xvf chectl-linux-x64.tar.gz && rm -rf chectl-linux-x64.tar.gz
cd chectl/bin 

cd /tmp 
rm -rf * 
cd 


# echo "starting minikube with ingress addonsr"
# docker kill $(docker ps -aq) -y 
# minikube start  --addons=ingress


