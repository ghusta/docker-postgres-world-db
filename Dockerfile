# Init Example Database World on PostgreSQL 9.6
FROM postgres:9.6

ENV POSTGRES_USER world
ENV POSTGRES_PASSWORD world123
ENV POSTGRES_DB world-db

ADD ./world-2.0.tar.gz /scripts/world/
#ADD scripts/*.sql /docker-entrypoint-initdb.d/

# Copier les scripts d'init dans : 
#ADD scripts/*.sh /docker-entrypoint-initdb.d/
RUN cp /scripts/world/*.sql /docker-entrypoint-initdb.d/
