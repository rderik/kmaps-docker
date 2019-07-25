# vim: ft=dockerfile
FROM ruby:2.4.3-alpine3.7

ENV GEM_HOME /usr/src/bundler
ENV APP=/usr/src/app \
  BUNDLE_PATH=$GEM_HOME \
  BUNDLE_BIN=$GEM_HOME/bin \
  BUNDLE_APP_CONFIG=$GEM_HOME \
  PATH=$GEM_HOME/bin:$PATH

RUN apk add --update \
  build-base \
  postgresql-dev \
  tzdata \
  nodejs \
  && apk add git && rm -rf /var/cache/apk/*

RUN bundle config --global path "$GEM_HOME" \
	&& bundle config --global bin "$GEM_HOME/bin"

EXPOSE 3000
WORKDIR $APP
