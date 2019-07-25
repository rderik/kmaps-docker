#!/usr/bin/env sh
#!/bin/bash

USAGE="Usage:\n${0##*/} --source=csv_file_name --task=task_code [--from=row_num] [--to=row_num] [--log_level=0..5]"
arguments=""
for i in "$@"
do
case $i in
    --help)
      echo "${USAGE}"
    ;;
    --source=*)
    USOURCE="${i#*=}"
    SOURCE=$(printf %q "${USOURCE}")
    shift # past argument=value
    ;;
    --task=*)
    TASK=$(printf %q "${i#*=}")
    arguments="${arguments} TASK=${TASK}"
    shift # past argument=value
    ;;
    --from=*)
    FROM="${i#*=}"
    arguments="${arguments} FROM=${FROM}"
    shift # past argument=value
    ;;
    --to=*)
    TO="${i#*=}"
    arguments="${arguments} TO=${TO}"
    shift # past argument with no value
    ;;
    --log_level=*)
    LOG_LEVEL="${i#*=}"
    arguments="${arguments} LOG_LEVEL=${LOG_LEVEL}"
    shift # past argument with no value
    ;;
    --debug)
    DEBUG=1
    shift # past argument with no value
    ;;
    *)
          # unknown option
    ;;
esac
done
if [ ! -z "${DEBUG}" ]
then
  echo "SOURCE    = ${SOURCE}"
  echo "TASK      = ${TASK}"
  echo "FROM      = ${FROM}"
  echo "TO        = ${TO}"
  echo "LOG_LEVEL = ${LOG_LEVEL}"
fi
if [ -z "${SOURCE}" ] | [ -z "${TASK}" ]
then
  echo "Source file and task name is required"
  echo "${USAGE}"
  exit 1
else
docker exec -it kmaps-docker_places_1 sh -c "mkdir -p csvs"
docker cp "./csv_files/$USOURCE" kmaps-docker_places_1:/usr/src/app/csvs/
#docker exec -it kmaps-docker_places_1 sh -c "ls -l csvs"
#docker exec -it kmaps-docker_places_1 sh -c "whoami"
#docker exec -it kmaps-docker_places_1 sh -c "ls -l"
echo "Executing command:"
echo "bin/rails db:import:features SOURCE=./csvs/${SOURCE} ${arguments}"
docker exec -it kmaps-docker_places_1 sh -c "bin/rails db:import:features SOURCE=./csvs/${SOURCE} ${arguments}"
fi
