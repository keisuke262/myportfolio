FROM ruby:2.5.3
RUN apt-get update  -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs

WORKDIR /ess 
COPY Gemfile Gemfile.lock /ess/
RUN bundle install







