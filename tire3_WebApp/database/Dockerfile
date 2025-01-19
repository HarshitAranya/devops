# Use the official PostgreSQL image
FROM postgres:latest

WORKDIR /dbtmp
# Copy .sql files to the Postgres init directory
COPY ./init/*.sql /docker-entrypoint-initdb.d/

COPY ./dbenvs.sh ./
RUN chmod +x /dbtmp/dbenvs.sh
# Expose the default PostgreSQL port
EXPOSE 5432

# Set environment variables
# ENV POSTGRES_USER=postgres
# ENV POSTGRES_PASSWORD=root@123
# ENV POSTGRES_DB=simpledb




