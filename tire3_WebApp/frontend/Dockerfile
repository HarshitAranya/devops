# Stage 1: Install dependencies
FROM nginx:alpine AS installer

WORKDIR /myapp

# Copy package.json and install dependencies
COPY ./frontend/package*.json ./
RUN npm install

# Copy the rest of the frontend app and build it
COPY ./frontend ./
RUN npm run build --prod

# Stage 2: Deploy with Nginx
FROM nginx:alpine AS deployer

WORKDIR /usr/share/nginx/html

# Clear the default content served by Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copy built Angular app from the build stage to Nginx's default directory
# angular18 will come from package.json
COPY --from=installer /myapp/dist/angular18 ./

# Expose port 80 for HTTP traffic
EXPOSE 80

# Command to start Nginx
CMD ["nginx", "-g", "daemon off;"]