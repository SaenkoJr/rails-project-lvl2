FROM ruby:3.0.1-alpine

ARG PROJECT_ROOT=/app
ARG PACKAGES="bash openssl-dev curl tzdata build-base postgresql-dev postgresql-client nodejs yarn"

RUN apk update \
      && apk upgrade \
      && apk add --update --no-cache $PACKAGES

ENV GEM_HOME=/bundle_cache
ENV GEM_PATH=/bundle_cache

RUN gem install bundler:2.2.17

RUN mkdir $PROJECT_ROOT
WORKDIR $PROJECT_ROOT

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

ADD . $PROJECT_ROOT
ENV PATH=$PROJECT_ROOT/bin:${PATH}

EXPOSE 5000
CMD ["make", "start"]
