FROM ruby:2.7.2
RUN apt-get update && apt-get install -y \
         build-essential \
         libpq-dev \
         nodejs \
         postgresql-client \
         yarn
WORKDIR /stop_sweets
COPY Gemfile Gemfile.lock /stop_sweets/
RUN bundle install
