# Use the official PostgreSQL image
FROM postgres:latest

# Copy .sql files to the Postgres init directory
COPY ./init/*.sql /docker-entrypoint-initdb.d/

# Expose the default PostgreSQL port
EXPOSE 5432
