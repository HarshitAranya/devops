sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock

When you run docker compose up from the D:\devops\docker directory, Docker Compose will look for a file named docker-compose.yaml or docker-compose.yml in the current directory


docker network create --driver bridge app_network
docker network ls
docker network inspect app_net --format= '{{json .Containers}}' | jq
docker network disconnect app_net mydatabase
docker network rm app_network
docker network create \
  --driver bridge \
  --subnet=192.168.100.0/24 \
  --gateway=192.168.0.1 \
  app_net

docker volume create my_volume
docker volume ls
docker volume rm my_volume

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
docker exec -it mydb psql -U postgres -d simpledb -c "SELECT * FROM myuser;"
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
\dt
SELECT * FROM "myuser";
\q

--secrets
docker swarm init --advertise-addr 192.168.150.128
docker secret ls
echo -n "root@123" | docker secret create dockersecretpassword -
echo -n "postgres" | docker secret create dockersecretusername -

--backend
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
  -e HOST=localhost \
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

cd /app && npm install --production
apk update
apk add postgresql-client
exit

docker commit mybackend mybackend-configured
docker rm mybackend
docker run -d --name mybackend -p 3001:3001 -v backend_volume:/app/ --network app_net mybackend-configured sh -c "cd /app && node index.js"
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
docker volume create frontend_volume
cp -r /home/harshit/devops/tire3_WebApp/frontend/* /var/lib/docker/volumes/frontend_volume/_data/
ls /var/lib/docker/volumes/frontend_volume/_data/
rm /var/lib/docker/volumes/frontend_volume/_data/Dockerfile

docker pull nginx:alpine
docker run -d --name myfrontend -v frontend_volume:/myapp/ --network app_net -p 3002:80 nginx:alpine
//docker cp /home/harshit/devops/tire3_WebApp/frontend/angular.json myfrontend:/myapp/
docker exec -it myfrontend sh
apk update
apk add npm
cd /myapp
npm install -g @angular/cli
ng version
//npm install
npm run build --prod
rm -rf /usr/share/nginx/html/*
cp -r /myapp/dist/angular18/* /usr/share/nginx/html/
sudo chown -R nginx:nginx /usr/share/nginx/html/
chmod -R 755 /usr/share/nginx/html/
systemctl reload nginx





