# Use CentOS as base image
FROM centos:latest

# Set the maintainer label
LABEL maintainer="your_email@example.com"

# Set environment variables
ENV MY_ENV_VAR=value

# Define build arguments
ARG APP_VERSION=1.0

# Install packages (e.g., vim, wget, curl, git)
RUN yum -y update && \
    yum -y install vim wget curl git && \
    yum clean all

# Set working directory same like cd command
WORKDIR /app

# Create a new user
RUN useradd -m myuser

# Switch to the new user
USER myuser

# Set working directory
WORKDIR /home/myuser

# Set environment variables based on the build argument
ENV VERSION=$APP_VERSION

# Expose a port (e.g., for a web app)
EXPOSE 8080

# Create a volume for MySQL data persistence
VOLUME ["/var/lib/mysql"]

# Define entry point
ENTRYPOINT ["python3", "script.py"]

# Default command (this will be passed as argument to ENTRYPOINT)
# CMD ["arg1", "arg2"]

# Command to run on container start
# CMD ["echo", "Hello, CentOS container!"]
# Default command
# CMD ["./app"]

# Define health check
HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1

CMD ["bash"]