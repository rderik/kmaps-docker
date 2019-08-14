FROM uva-import-rails-base:latest

RUN git clone https://github.com/shanti-uva/places.git $APP
WORKDIR $APP
RUN git pull origin master
COPY ./files/rails/places/config/flare.yml ./config/
COPY ./files/rails/places/config/database.yml ./config/
COPY ./files/rails/places/config/development.rb ./config/environments/
COPY ./files/rails/places/config/places_engine.yml ./config/
RUN pwd
WORKDIR $APP
RUN bundle install --gemfile=./Gemfile
#RUN bundle exec rake tmp:clear
#RUN bundle exec rake assets:clean
#RUN bundle exec rake assets:precompile
#RUN bundle exec rails db:migrate

EXPOSE 3000

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]
