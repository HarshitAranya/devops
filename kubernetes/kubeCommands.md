# kubectl client Installation and setup on windows
curl.exe -LO "https://dl.k8s.io/release/v1.32.0/bin/windows/amd64/kubectl.exe"
curl.exe -LO "https://dl.k8s.io/v1.32.0/bin/windows/amd64/kubectl.exe.sha256"
CertUtil -hashfile kubectl.exe SHA256
type kubectl.exe.sha256
$(Get-FileHash -Algorithm SHA256 .\kubectl.exe).Hash -eq $(Get-Content .\kubectl.exe.sha256)
Append or prepend the kubectl binary folder to your PATH environment variable
kubectl version --client
cd ~
mkdir .kube
cd .kube
New-Item config -type file
kubectl completion powershell >> $PROFILE

# Install drivers for minikube
Powershell 
Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*VMware*" } | Select-Object Name, Version
VMware Workstation 16.2.3 should be installed
CMD
setx PATH "C:\Program Files (x86)\VMware\VMware Workstation" /M

Download the driver from https://github.com/machine-drivers/docker-machine-driver-vmware/releases.

# Minikube as a server Installation and setup on windows
New-Item -Path 'c:\' -Name 'minikube' -ItemType Directory -Force
Invoke-WebRequest -OutFile 'c:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing


$oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
if ($oldPath.Split(';') -inotcontains 'C:\minikube'){
  [Environment]::SetEnvironmentVariable('Path', $('{0};C:\minikube' -f $oldPath), [EnvironmentVariableTarget]::Machine)
}

minikube version
minikube drivers
minikube update

minikube start
minikube start --driver=hyperv 
minikube start --driver=hyperv --memory 3048
minikube start --driver=hyperv --memory 3048 --insecure-registry
minikube start --driver=hyperv --memory 3048 --image-repository="docker.io"

minikube start --driver vmware
minikube delete --profile=minikube
minikube start --profile=minikube
minikube delete --profile=minikube

kubectl config current-context
minikube status
minikube profile list
minikube start --profile=minikube --driver=vmware
minikube tunnel

kubectl get po -A


# Kubernetes commands
kubectl cluster-info
kubectl config get-clusters 
kubectl get all -A
kubectl version
kubectl version -short
kubectl version -client

kubectl get namespaces
kubectl create namespaces t3webapp
kubectl get all -n t3webapp
kubectl config view
kubectl config view | findstr namespace
kubectl config set-context --current --namespace=t3webapp
kubectl delete all --all -n t3webapp


echo -n 'securepassword' | base64
echo -n 'dbuser' | base64

DB_USER=$(cat /etc/secrets/DB_USER)
DB_PASSWORD=$(cat /etc/secrets/DB_PASSWORD)

kubectl apply -f database/config.yaml
kubectl apply -f database/secrets.yaml
kubectl apply -f database/deployment-service.yaml
kubectl exec -it database-web-app-7487cfcc9f-24ptz -n default -- sh
psql -h database-web-app-7487cfcc9f-nfc2n -p 5432 -U dbuser -d mydatabase
PGPASSWORD=securepassword psql -h database-web-app-service -p 5432 -U dbuser -d mydatabase

nc -zv database-web-app-service 5432
curl http://database-web-app-service:5432

kubectl apply -f backend/config.yaml
kubectl apply -f backend/secrets.yaml
kubectl apply -f backend/deployment-service.yaml

kubectl apply -f frontend/config.yaml
kubectl apply -f frontend/secrets.yaml
kubectl apply -f frontend/deployment-service.yaml

OR

kubectl apply -f database/
kubectl apply -f backend/
kubectl apply -f frontend/

kubectl apply -f .

alias kubectl=k
# v35
k get all -A -o yaml > backup.yaml
cd /etc/kubernetes/manifests/
less etcd.yaml
apt install etcd-client
etcdctl
ETCDCTL_API=3 etcdctl snapshot
export ETCDCTL_API=3
#After backup
etcdctl --write-out=table snapshots /opt/etcd-backup.db
du -sh filename # to check the file size

# v36
k get pod -n=kube-system -w
k get deploy -n=kube-system
k edit nameOfdeployment
k describe deployment nameOfdeployment
k logs nameOfpod
k edit nameOfdeployment -n=kube-system
K get netpol
k gescribe netpol nameOfnetpol
k get po -o wide
k get po --show-labels
k get ep
k get all


crictl ps # same as docker but its docker d - it will show all running pods
crictl ps |grep api
crictl logs containerid
crictl logs -f containerid
cd /etc/kubernetes/manifests/
crictl pull nginx
crictl runp pod-config.json

# to access minikube app on localhost:8080
kubectl port-forward service/frontend-web-app-service 8080:80
kubectl exec -it frontend-web-app-7476698f9d-h72h9 -- curl http://backend-web-app-service:4001
