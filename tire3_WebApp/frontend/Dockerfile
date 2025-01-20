# Stage 1: Install dependencies
FROM nginx:alpine AS installer
WORKDIR /myapp
# Copy package.json and install dependencies
COPY ./package*.json ./
RUN npm install
# Not required for Angular 12+
# RUN npx ngcc -properties es2023 browser module main --first-only --create-ivy-entry-points
# Copy the rest of the frontend app and build it
COPY . .
RUN rm /myapp/Dockerfile
RUN npm run build --prod
# Stage 2: Deploy with Nginx
# FROM nginx:stable AS deployer
FROM nginx:alpine AS deployer
#WORKDIR /usr/share/nginx/html
# Clear the default content served by Nginx
RUN rm -rf /usr/share/nginx/html/*
# Copy built Angular app from the build stage to Nginx's default directory
# angular18 will come from package.json
# RUN apt update && apt install -y vim # for atable/latest
# RUN apk add --no-cache vim #for alpine
COPY --from=installer /myapp/default.conf /etc/nginx/conf.d
COPY --from=installer /myapp/dist/angular18/browser/* /usr/share/nginx/html/
# Expose port 80 for HTTP traffic
EXPOSE 80
# Command to start Nginx
CMD ["nginx", "-g", "daemon off;"]