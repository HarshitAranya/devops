# Stage 1: Build
FROM httpd:alpine

ARG user=appuser

# Copy the Maven project files to the container
COPY ../prod_app /usr/local/apache2/htdocs/

# Ensure the container runs as a non-root user for security
RUN addgroup -S $user && adduser -S $user -G $user \
    && chown -R $user:$user /usr/local/apache2/htdocs/

USER $user

#WORKDIR /home/$user removed or not in use

# Expose the application's port (e.g., 8080)
EXPOSE 80

CMD ["httpd", "-D", "FOREGROUND"]

#ENTRYPOINT ["httpd-foreground"] already in base image

# Set a health check to validate the service
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost/ || exit 1
