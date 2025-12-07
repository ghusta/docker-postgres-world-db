# Init Example Database World on PostgreSQL
ARG POSTGRES_TAG=18.1
FROM postgres:$POSTGRES_TAG

ENV POSTGRES_USER=world
ENV POSTGRES_DB=world-db

# Copier les scripts SQL dans : 
COPY scripts/*.sql /docker-entrypoint-initdb.d/
COPY scripts/*.csv /docker-entrypoint-initdb.d/

# Copier les scripts d'init dans : 
#ADD scripts/*.sh /docker-entrypoint-initdb.d/

COPY docker-healthcheck /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-healthcheck

USER postgres

HEALTHCHECK CMD ["docker-healthcheck"]
