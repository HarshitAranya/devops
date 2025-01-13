# Stage 1: Install dependencies
FROM nginx:alpine AS installer

WORKDIR /myapp

# Copy package.json and install dependencies
COPY ./frontend/package*.json ./
RUN npm install
RUN npx ngcc -properties es2023 browser module main --first-only --create-ivy-entry-points

# Copy the rest of the frontend app and build it
COPY ./frontend ./
RUN npm run build --prod

# Stage 2: Deploy with Nginx
FROM nginx:stable AS deployer

#COPY default.conf /etc/nginx/conf.d

#WORKDIR /usr/share/nginx/html

# Clear the default content served by Nginx
#RUN rm -rf /usr/share/nginx/html/*

# Copy built Angular app from the build stage to Nginx's default directory
# angular18 will come from package.json
COPY --from=installer /myapp/dist/angular18 /usr/share/nginx/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Command to start Nginx
CMD ["nginx", "-g", "daemon off;"]