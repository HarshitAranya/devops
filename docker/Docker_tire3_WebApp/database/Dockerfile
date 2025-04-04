# Use the official PostgreSQL image
FROM postgres:latest
WORKDIR /tempdata
# Copy .sql files to the Postgres init directory
COPY commands.txt .
COPY ./init/*.sql /docker-entrypoint-initdb.d/
RUN apt-get update && apt-get install -y curl
# Remove EXPOSE if you dont want to expose it 
# EXPOSE 5432





