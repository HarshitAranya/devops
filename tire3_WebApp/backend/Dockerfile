# Stage 1: Install dependencies
FROM node:16-alpine AS installer
# Install rsync and other dependencies
# RUN apk add --no-cache rsync
# Set the working directory
WORKDIR /app

# Copy package.json files and install dependencies
# COPY ./backend/package*.json ./
COPY package*.json ./
RUN npm install --production

# Stage 2: Deploy the application
FROM node:16-alpine AS deployer

# Set runtime environment variable for the port
ENV TPORT=3001
ENV APIHOST="192.168.150.128"

# Set the working directory
WORKDIR /usr/src/app

# Copy the installed dependencies from the installer stage
COPY --from=installer /app/node_modules ./node_modules

# Copy the application code
COPY index.js ./
# COPY ./backend/index.js ./
RUN apk update
RUN apk add postgresql-client
RUN apk add --no-cache curl

# Expose port
EXPOSE 3001

# Command to run the app
CMD ["node", "index.js"]
