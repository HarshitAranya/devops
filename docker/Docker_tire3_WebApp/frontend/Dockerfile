# Stage 1: Install dependencies
# FROM nginx:alpine AS installer
FROM node:alpine AS installer
WORKDIR /myapp
# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install
# Copy the rest of the frontend app and build it
COPY . .
RUN rm /myapp/Dockerfile
RUN npm run build --prod

# Stage 2: Deploy with Nginx
FROM nginx:alpine AS deployer

# Clear the default content served by Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copy built Angular app from the build stage to Nginx's default directory
COPY --from=installer /myapp/default.conf /etc/nginx/conf.d
COPY --from=installer /myapp/dist/angular18/browser/* /usr/share/nginx/html/
RUN apk add --no-cache curl
# Expose port 80 for HTTP traffic
EXPOSE 80

# Command to start Nginx
CMD ["nginx", "-g", "daemon off;"]

# 192.168.100.101 DB
# 192.168.100.102 BE
# 192.168.100.103 FE