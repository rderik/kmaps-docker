#!/usr/bin/env sh
docker cp backups/places.backup kmaps-docker_postgres_1:/databases/places.backup
docker exec -it -u postgres kmaps-docker_postgres_1 /docker-entrypoint-initdb.d/prepare_places_db_for_import.sh
