# Init Example Database World on PostgreSQL 9.5
FROM postgres:9.5

ENV POSTGRES_USER world
ENV POSTGRES_PASSWORD world123
ENV POSTGRES_DB world-db

# URL DL : http://pgfoundry.org/frs/download.php/527/world-1.0.tar.gz
ADD ./world-1.0.tar.gz /scripts/world/
#ADD scripts/*.sql /docker-entrypoint-initdb.d/

# Copier les scripts d'init dans : 
#ADD scripts/*.sh /docker-entrypoint-initdb.d/
RUN cp /scripts/world/dbsamples-0.1/world/*.sql /docker-entrypoint-initdb.d/
