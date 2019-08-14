#!/usr/bin/env sh
#!/bin/bash

USAGE="Usage:\n${0##*/} --source=csv_file_name"
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
  echo "Executing command:"
  echo "bin/rails db:feature_name_match:match SOURCE=./csvs/${SOURCE}"
fi
if [ -z "${SOURCE}" ]
then
  echo "Source file is required"
  echo "${USAGE}"
  exit 1
else
  docker exec -it kmaps-docker_places_1 sh -c "mkdir -p csvs"
  docker cp "./csv_files/$USOURCE" kmaps-docker_places_1:/usr/src/app/csvs/
  docker exec -it kmaps-docker_places_1 sh -c "bin/rails -D feature_name_match:match"
  docker exec -it kmaps-docker_places_1 sh -c "bin/rake db:feature_name_match:match SOURCE=./csvs/${SOURCE} --trace"
  mkdir -p ./tmp
  docker cp kmaps-docker_places_1:/usr/src/app/tmp/matched_name_results.csv ./tmp/
  docker cp kmaps-docker_places_1:/usr/src/app/tmp/unmatched_name_results.csv ./tmp/
fi
