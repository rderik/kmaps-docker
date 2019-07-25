# vim: ft=dockerfile
FROM tomcat:7.0.82-jre8-alpine

RUN apk add --update \
  ttf-dejavu \
  postgresql-client \
  && apk add git && rm -rf /var/cache/apk/*
#
# Set GeoServer version and data directory
#
ENV GEOSERVER_VERSION=2.12.1

COPY ./files/geoserver/geoserver-${GEOSERVER_VERSION}.war /usr/local/tomcat/webapps/
COPY ./files/geoserver/geoserver_data /geoserver_data
COPY ./files/geoserver/fonts ${JAVA_HOME}/lib/fonts
COPY ./files/geoserver/tomcat-users.xml /usr/local/tomcat/conf/
RUN cd /usr/local/tomcat/webapps \
    && mkdir geoserver \
    && unzip -q geoserver-${GEOSERVER_VERSION}.war -d geoserver \
    && rm geoserver-${GEOSERVER_VERSION}.war

ENV GEOSERVER_DATA_DIR="/geoserver_data/"
