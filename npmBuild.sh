apt update
apt install npm
ng version
cp -r ./tire3_WebApp/frontend/* /frontend
cd /frontend
npm install -g @angular/cli
npm run build --prod