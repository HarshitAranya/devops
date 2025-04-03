# Use the official PostgreSQL image
FROM postgres:latest
WORKDIR /tempdata
# Copy .sql files to the Postgres init directory
COPY commands.txt .
COPY ./init/*.sql /docker-entrypoint-initdb.d/
RUN apk update
RUN apk add --no-cache curl
EXPOSE 5432




