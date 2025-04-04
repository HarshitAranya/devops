# Stage 1: Install dependencies
FROM node:16-alpine AS installer
# Set the working directory
WORKDIR /app
# Copy package.json files and install dependencies
COPY package*.json ./
RUN npm install --production
# Stage 2: Deploy the application
FROM node:16-alpine AS deployer
# Set runtime environment variable for the port
# ENV TPORT=3001
# ENV APIHOST="192.168.150.128"
# Set the working directory
WORKDIR /usr/src/app
# Copy the installed dependencies from the installer stage
COPY --from=installer /app/node_modules ./node_modules
# Copy the application code
COPY index.js ./
# COPY ./backend/index.js ./
# RUN apk update
# RUN apk add postgresql-client
# RUN apk add --no-cache curl
RUN apk update && \
    apk add --no-cache postgresql-client curl
# Expose port if you want
EXPOSE 3001
# Command to run the app
CMD ["node", "index.js"]
#http://backendapp:4001/user

# 192.168.100.102 this static ip of this backend server is configured in frontend server
