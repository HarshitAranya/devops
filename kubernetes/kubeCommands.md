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
minikube start
minikube start --driver vmware

minikube delete --profile=minikube
minikube start --profile=minikube

minikube delete --profile=minikube
minikube start --profile=minikube --driver=vmware

minikube status

kubectl get po -A


# Kubernetes commands
kubectl cluster-info

echo -n 'securepassword' | base64
echo -n 'dbuser' | base64

DB_USER=$(cat /etc/secrets/DB_USER)
DB_PASSWORD=$(cat /etc/secrets/DB_PASSWORD)

kubectl apply -f database/config.yaml
kubectl apply -f database/secrets.yaml
kubectl apply -f database/deployment-service.yaml

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



