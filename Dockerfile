FROM ruby:2.4.0

# Installing NodeJS for some Ruby gems needed by Rails
RUN apt-get update && apt-get install -y nodejs

ENV APP /app

RUN mkdir $APP
WORKDIR $APP

ENV BUNDLE_GEMFILE=$APP/Gemfile \
    BUNDLE_JOBS=2 \
    BUNDLE_PATH=/bundle

COPY . $APP

RUN bundle install
RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
