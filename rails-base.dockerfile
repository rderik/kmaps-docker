FROM ruby:2.6.3-alpine3.9

ENV GEM_HOME /usr/src/bundler
ENV APP=/usr/src/app \
  BUNDLE_PATH=$GEM_HOME \
  BUNDLE_BIN=$GEM_HOME/bin \
  PATH=$GEM_HOME/bin:$PATH \
  RAILS_ENV='development' \
  RACK_ENV='development' 

RUN apk add --update \
  build-base \
  postgresql-dev \
  tzdata \
  nodejs \
  yarn \
  icu-dev \
  && apk add git && rm -rf /var/cache/apk/*

RUN bundle config --global path "$GEM_HOME" \
	&& bundle config --global bin "$GEM_HOME/bin"
COPY ./files/rails/Gemfile-base ./Gemfile
RUN bundle install

CMD [ "sleep", "infinity" ]
