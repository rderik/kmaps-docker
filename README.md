# Docker infrastructure to work importations locally

This repository depends on having a KMAPS application.

# Dependencies

* Docker - [Here is the link for macOS](https://docs.docker.com/docker-for-mac/install/)
* clone this repo inside `kmaps-docker` folder

1. Build all the DockerImages

```bash
$ docker-compose build
```

2. Initialize Geoserver

```bash
$ ./init_geoserver_copy_data.sh
```

3. Run only postgres, to Initialize the DB

```bash
$ docker-compose up postgres
```

4. when is completed, stop postgres

```bash
$ docker-compose stop postgres
```

That creates all the infrastructure. Now every time we want ot restart the
full system:

1. Start all the system 


```bash
$ docker-compose up 
```
2. Everytime we restart 

```bash
$ ./init_solr_core_creation.sh
```

Everytime we want to import put files inside `csv_files/` directory

```bash
$ ./import_places.sh
```

Everytime we restart the importation we want to clear the Database
the database backup is located in: files/postgres/places.backup 

```bash
./prepare_places_dev_db_for_import.sh
```
