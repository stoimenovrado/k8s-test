#!/bin/bash -x

echo "* Install microk8s ..."
apt update
apt install snapd -y
snap install microk8s --classic
usermod -a -G microk8s $USER
chown -f -R $USER ~/.kube
microk8s enable dashboard dns ingress

echo "* Install other ..."
sudo apt install vim -y

echo "* K8S ..."
mkdir -p k8s
cp /vagrant/namespace.yaml /home/vagrant/k8s/
cp /vagrant/web-service.yaml /home/vagrant/k8s/
cp /vagrant/db-service.yaml /home/vagrant/k8s/
cp /vagrant/web-deployment.yaml /home/vagrant/k8s/
cp /vagrant/db-deployment.yaml /home/vagrant/k8s/

echo "* Initiate my K8S cluster ..."
cd k8s
microk8s kubectl apply -f namespace.yaml
microk8s kubectl apply -f web-deployment.yaml --namespace=bgapp
microk8s kubectl apply -f db-deployment.yaml --namespace=bgapp
microk8s kubectl create -f web-service.yaml
microk8s kubectl create -f db-service.yaml