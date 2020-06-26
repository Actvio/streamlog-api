
FROM ruby:2.5.1-alpine

RUN apk update && apk add build-base nodejs postgresql-dev bash nano
ENV EDITOR=nano

RUN mkdir -p /app
WORKDIR /app

# COPY Gemfile Gemfile.lock ./
COPY Gemfile Gemfile.lock ./

RUN bundle install --binstubs

COPY . .

CMD rails s