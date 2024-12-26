# Stage 1: Install dependencies
FROM node:16-alpine AS installer

# Install rsync and other dependencies
# RUN apk add --no-cache rsync

# Set the working directory
WORKDIR /app

# Copy package.json files and install dependencies
COPY ./backend/package*.json ./
RUN npm install --production

# Stage 2: Deploy the application
FROM node:16-alpine AS deployer

# Set the working directory
WORKDIR /usr/src/app

# Copy the installed dependencies from the installer stage
COPY --from=installer /app/node_modules ./node_modules

# Copy the application code
COPY ./backend/index.js ./

# Expose port
EXPOSE 3000

# Command to run the app
CMD ["node", "index.js"]
