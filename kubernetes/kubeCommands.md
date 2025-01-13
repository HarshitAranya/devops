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



