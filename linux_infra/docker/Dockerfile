FROM ruby:2.3-slim
MAINTAINER subicura@subicura.com

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install
COPY . /usr/src/app

EXPOSE 4567

