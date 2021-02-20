FROM ruby:2.5.3
RUN apt-get update  -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    mysql-client \
    yarn

WORKDIR /ess 
COPY Gemfile Gemfile.lock /ess/
RUN bundle install
CMD [ "rails", "server", "-b", "0.0.0.0"]
