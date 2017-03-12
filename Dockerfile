FROM ruby:2.4.0

# Installing NodeJS for some Ruby gems needed by Rails
RUN apt-get update && apt-get install -y nodejs cron

ENV APP /app

RUN mkdir $APP
WORKDIR $APP

ENV BUNDLE_GEMFILE=$APP/Gemfile \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/bundle

# Copies Gemfile and Gemfile.lock
COPY Gemfile* $APP/

RUN bundle install --without development test

COPY . $APP

# Precompiling assets
RUN bundle exec rake assets:precompile

# Updating the crontab
RUN bundle exec whenever --update-crontab

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
