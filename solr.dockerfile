# vim: ft=dockerfile
FROM solr:7.2.1-alpine

COPY ./files/solr/solr-configset /opt/solr/solr-configset
RUN mkdir -p /opt/solr/solr-custom-scripts/
COPY --chown=solr:solr ./files/solr/create-kmterms-dev.sh /opt/solr/solr-custom-scripts/

