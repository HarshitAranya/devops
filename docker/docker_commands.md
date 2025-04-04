# Final code for dockerfile
Start-Process -FilePath "C:\Program Files\Docker\Docker\Docker Desktop.exe"

# Before start 
docker network create \
  --subnet=192.168.100.0/24 \
  --gateway=192.168.100.1 \
  custom-bridge

docker run -d \
  --name my-container \
  --net custom-bridge \
  --ip 192.168.100.100 \
  my-image
  
# 192.168.100.101 DB
# 192.168.100.102 BE
# 192.168.100.103 FE

# Database
cd D:\devops\docker\Docker_tire3_WebApp\database
docker build -t databasedocker:v1 .
docker tag databasedocker:v1 harshitaranya/harshit:databasedocker-v1
docker push harshitaranya/harshit:databasedocker-v1
docker pull harshitaranya/harshit:databasedocker-v1

docker run -d \
  --name databaseapp \
  --env-file .env \
  -p 5432:5432 \
  --hostname databaseapp \
  databasedocker:v1

docker run -d --name databaseapp --env-file .env -p 5432:5432 --hostname databaseapp databasedocker:v1

docker exec -it databaseapp sh
hostname
psql -h databaseapp -p 5432 -U dbuser -d mydatabase
\dt
SELECT * FROM "myuser";

From Host or outside network use localhost:5432 or local host IP:5432
Like this -
$env:PGPASSWORD = "securepassword"
psql -h localhost -p 5432 -U dbuser -d mydatabase
ipconfig | findstr "IPv4"
ping $(hostname) -n 1 -l 0 -4 | findstr "Reply from"
psql -h 172.28.176.1 -p 5432 -U dbuser -d mydatabase

If you dont want to expose, dont use port use network instead of

docker network create \
  --driver bridge \
  --subnet=192.168.100.0/24 \
  --gateway=192.168.100.1 \
  app_net
# Backend
docker build -t backendserver:d1 .
docker tag backendserver:d1 harshitaranya/harshit:backendserver-d1
# Frontend
docker build -t frontendserver:d1 .
docker tag frontendserver:d1 harshitaranya/harshit:frontendserver-d1
========================================================================================
# Docker tag to push it on docker repo
if docker built -t databse:d1 .
the image name will be databse and tag name will be d1
then tag will be as follow where harshitaranya/harshit is docker repo
docker tag database:d1 harshitaranya/harshit:database-latest

=========
# Networking
docker network create --driver bridge app_network
docker network ls
docker network inspect app_net --format= '{{json .Containers}}' | jq
docker network disconnect app_net mydatabase
docker network rm app_network
docker network create \
  --driver bridge \
  --subnet=192.168.100.0/24 \
  --gateway=192.168.100.1 \
  app_net
=================================================================================================
# Volumes
docker volume create my_volume
docker volume ls
docker volume rm my_volume

docker volume create db_volume
=================================================================================================
# Database container creation (Refer local file for user and password)
cd /home/harshit/devops/tire3_WebApp/database/
cp -r ./init/*.sql /var/lib/docker/volumes/db_volume/_data/

docker build -t databasedocker:v1 .

rm -f /home/harshit/devops/tire3_WebApp/database/.env
touch /home/harshit/devops/tire3_WebApp/database/.env

export dbuser="tire3_WebApp_database_dbinfo_txt"
export dbpass="tire3_WebApp_database_dbinfo_txt"
export dbname="tire3_WebApp_database_dbinfo_txt"
export dhport="tire3_WebApp_database_dbinfo_txt"
export dtport="tire3_WebApp_database_dbinfo_txt"

echo "POSTGRES_USER=$dbuser" >> .env
echo "POSTGRES_PASSWORD=$dbpass" >> .env
echo "POSTGRES_DB=$dbname" >> .env

docker run -d \
  --name databaseapp \
  --env-file .env \
  -v db_volume:/docker-entrypoint-initdb.d/ \
  -p $dhport:$dtport \
  --network app_net \
  databasedocker:v1
rm -f /home/harshit/devops/tire3_WebApp/database/.env

docker exec -it databaseapp psql -U postgres -d simpledb -c "SELECT * FROM myuser;"
psql -h localhost -p 4432 -U postgres -d simpledb
=================================================================================================
# Backend container creation and deployment
cd /home/harshit/devops/tire3_WebApp/backend/
docker build -t backendserver:d1 .
docker tag backendserver:d1 harshitaranya/harshit:backendserver-d1
rm -f /home/harshit/devops/tire3_WebApp/backend/.env
touch /home/harshit/devops/tire3_WebApp/backend/.env

export dbuser="tire3_WebApp_backend_dbinfo_txt"
export dbpass="tire3_WebApp_backend_dbinfo_txt"
export dbname="tire3_WebApp_backend_dbinfo_txt"
export dbport="tire3_WebApp_backend_dbinfo_txt"
export dhport="tire3_WebApp_backend_dbinfo_txt"
export dtport="tire3_WebApp_backend_dbinfo_txt"
export apihost="tire3_WebApp_backend_dbinfo_txt"

echo "USERNAME=$dbuser" >> .env
echo "PASSWORD=$dbpass" >> .env
echo "DATABASE=$dbname" >> .env
echo "DB_PORT=$dbport" >> .env
echo "APIHOST=$apihost" >> .env

docker run -d \
  --name backendapp \
  --env-file .env \
  -p $dhport:$dtport \
  --network app_net \
  backendserver:d1 \
  sh -c "cd /app && node index.js"

docker exec -it backendapp curl http://localhost:3001
curl http://localhost:4001

=================================================================================================
# Frontend container creation and deployment
cd /home/harshit/devops/tire3_WebApp/frontend/

docker run -d \
  --name frontendapp \
  --network app_net \
  -p 80:80 \
  frontendserver:d1

=================================================================================================
# RnD -

--mydb
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock

When you run docker compose up from the D:\devops\docker directory, Docker Compose will look for a file named docker-compose.yaml or docker-compose.yml in the current directory

export dbport="simpledb"

docker run -d \
  --name mydb \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=root@123 \
  -e POSTGRES_DB=simpledb \
  -v db_volume:/docker-entrypoint-initdb.d/ \
  -p 4432:5432 \
  --network app_net \
  postgres 

docker pull postgres:latest
docker run -d \
  --name mydb \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_PASSWORD=mypassword \
  -e POSTGRES_DB=mydatabase \
  -p 5432:5432 \
  postgres 
docker cp *.sql mydb:/docker-entrypoint-initdb.d/

or

docker volume create my_volume
cp *.sql /var/lib/docker/volumes/my_volume/_data/

docker pull postgres:latest
docker run -d \
  --name mydb \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=root@123 \
  -e POSTGRES_DB=simpledb \
  -v db_volume:/docker-entrypoint-initdb.d/ \
  -p 4432:5432 \
  --network app_net \
  postgres 
docker run -d --name mydbapp -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=root@123 -e POSTGRES_DB=simpledb -p 5432:5432 harshitaranya/harshit:databasedocker-v1
psql -h localhost -p 5432 -U postgres -d simpledb
docker exec -it mydbapp psql -U postgres -d simpledb -c "SELECT * FROM myuser;"

xxd 01-create-schema-fixed.sql
file -i 03-insert-data.sql
iconv -f UTF-16LE -t UTF-8 01-create-schema.sql -o 01-create-schema-fixed.sql
iconv -f UTF-16LE -t UTF-8 03-insert-data.sql > 03-insert-data-fixed.sql
cat -A 03-insert-data-fixed.sql

apt update
apt install postgresql-client
psql -h hostname -p 4432 -U postgres -d simpledb
psql -h localhost -p 4432 -U postgres -d simpledb
\l
\c simpledb
\dt
SELECT * FROM "myuser";
\q

--secrets
docker swarm init --advertise-addr 192.168.150.128
docker secret ls
echo -n "root@123" | docker secret create dockersecretpassword -
echo -n "postgres" | docker secret create dockersecretusername -
echo -n "simpledb" | docker secret create dockersecretdbname -

# in this case Dockerfile is not reqired
docker service create \
  --name mydb \
  --secret source=dockersecretpassword,target=postgres_password \
  --secret source=dockersecretusername,target=postgres_user \
  --secret source=dockersecretdbname,target=postgres_db \
  -p 4432:5432 \
  --network app_net \
  postgres:latest


--mybackend  
docker pull node:16-alpine
docker run -it node:16-alpine /bin/sh #test images before running Containers

docker run -it --name mybackend -e HOST=localhost -p 3000:3000 --network app_net node:16-alpine /bin/sh
docker run -d --name mybackend -e HOST=localhost -p 3000:3000 --network app_net node:16-alpine

docker service create --name mybackend -e HOST=localhost -p 3000:3000 --network app_net node:16-alpine

OR  
docker run -d \
  --name mybackend \
  -e HOST=localhost \
  -e USER=postgres \
  -e PASSWORD=root@123 \
  -e DATABASE=simpledb \
  -e PORT=5432 \
  -p 3000:3000 \
  --network app_net \
  node:16-alpine
or

docker service create \
  --name mybackend \
  --secret dockersecretpassword \
  --secret dockersecretusername \
  -e HOST=192.168.150.128 \
  -e USER=postgres \
  -e DATABASE=simpledb \
  -e PORT=4432 \
  -p 3001:3001 \
  node:16-alpine

docker cp ./backend/package*.json mybackend:/app/
docker cp ./backend/package*.js mybackend:/app/
docker exec mybackend sh -c "cd /app && npm install --production"

-finaly code 

docker volume create backend_volume
cp /home/harshit/devops/tire3_WebApp/backend/package*.json /var/lib/docker/volumes/backend_volume/_data/
cp /home/harshit/devops/tire3_WebApp/backend/*.js /var/lib/docker/volumes/backend_volume/_data/
cp /home/harshit/devops/tire3_WebApp/backend/index.js /var/lib/docker/volumes/backend_volume/_data/

docker run -it \
  --name mybackend \
  -e HOST=172.18.0.1 \
  -e USER=postgres \
  -e PASSWORD=root@123 \
  -e DATABASE=simpledb \
  -e PORT=4432 \
  -v backend_volume:/app/ \
  -p 3001:3001 \
  --network app_net \
  node:16-alpine /bin/sh

docker run -it \
  --name backend \
  -e HOST=172.18.0.1 \
  -e USERNAME=postgres \
  -e PASSWORD=root@123 \
  -e DATABASE=simpledb \
  -e PORT=4432 \
  -v backend_volume:/app/ \
  -p 3001:3001 \
  --network app_net \
  mybackend-configured18 /bin/sh

cd /app && npm install --production
apk update
apk add postgresql-client
psql -h database-web-app-service -p 5432 -U dbuser -d mydatabase
SELECT * FROM myuser;
exit

docker commit mybackend mybackend-configured
docker rm mybackend


curl http://localhost:3001/
curl http://192.168.150.128:3000/health
docker exec -it mybackend ps aux
docker exec -it mybackend netstat -tuln
docker exec -it mybackend curl http://localhost:3000/health
apk update
apk add postgresql-client
psql -h localhost -p 4432 -U postgres -d simpledb
psql -h $HOST -p 4432 -U postgres -d simpledb

--frontend
cp -r /home/harshit/devops/tire3_WebApp/frontend/* /var/lib/docker/volumes/frontend_volume/_data/
ls /var/lib/docker/volumes/frontend_volume/_data/
rm /var/lib/docker/volumes/frontend_volume/_data/Dockerfile

docker pull nginx:alpine
docker run -d --name myfrontend -v frontend_volume:/myapp/ --network app_net -p 3002:80 nginx:alpine
//docker cp /home/harshit/devops/tire3_WebApp/frontend/angular.json myfrontend:/myapp/
docker exec -it myfrontend sh
apt-get install iputils-ping
apt update && apt install -y vim
or
apk add --no-cache vim
apk/apt update
cd /myapp
apk add npm / apt install npm
npm install -g @angular/cli
npm install
ng version
//npm install
npm run build --prod
rm -rf /usr/share/nginx/html/*
cp -r /myapp/dist/angular18/* /usr/share/nginx/html/
sudo chown -R nginx:nginx /usr/share/nginx/html/
chmod -R 755 /usr/share/nginx/html/
nginx -t
nginx -s reload

systemctl reload nginx

docker run -it \
  --name myfrontend \
  -v frontend_volume:/myapp/ \
  -p 80:80 \
  --network app_net \
  frontend18 /bin/sh

docker run -d \
  --name frontendapp \
  -v frontend_volume:/myapp/ \
  --network app_net \
  -p 80:80 \
  frontend18:v2 \
  nginx -g "daemon off;"