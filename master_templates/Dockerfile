# =======================
# Stage 1: Builder Stage
# =======================
FROM node:20-alpine AS builder

# Set build arguments
ARG NODE_ENV=production
ARG APP_VERSION=1.0.0

# Set environment variables
ENV NODE_ENV=$NODE_ENV \
    APP_VERSION=$APP_VERSION

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm ci --only=production

# Copy source code
COPY . .

# Build the app
RUN npm run build

# =======================
# Stage 2: Final Image
# =======================
FROM nginx:latest

# Labels for metadata
LABEL maintainer="yourname@example.com" \
      description="A complex Dockerized application" \
      version=$APP_VERSION

# Set environment variables
ENV APP_HOME=/usr/share/nginx/html \
    LOG_LEVEL=info

# Expose a volume for persistent data
VOLUME ["/var/log/app"]

# Copy built application from builder stage
COPY --from=builder /app/dist $APP_HOME

# Set file permissions
RUN chown -R nginx:nginx $APP_HOME
# RUN apk add --no-cache curl

# Expose port
EXPOSE 80

# Define a health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD [ "curl -f http://localhost" ] || exit 1

# Set user for security best practices
USER nginx

# Set the default command
CMD ["nginx", "-g", "daemon off;"]

# docker build -t mwwebapp .
# docker run -d -p 80:80 --name mycont --network bridge -v myvolume:/usr/share/nginx/html mwwebapp
