# vim: ft=dockerfile
FROM postgres:9.6.6

RUN apt-get update \
  && apt-get install -y postgresql-9.6-postgis-2.4 \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /databases
COPY ./files/postgres/places.backup /databases/
RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./files/postgres/prepare_places_db_for_import.sh /docker-entrypoint-initdb.d/
RUN chmod u+x /docker-entrypoint-initdb.d/prepare_places_db_for_import.sh
RUN chown -R postgres:postgres /databases

EXPOSE 5432
