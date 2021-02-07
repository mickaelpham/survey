FROM ruby:3-alpine

ENV APP_PATH /var/app
ENV BUNDLE_VERSION 2.2.8

RUN apk add -U --no-cache \
g++ \
musl-dev \
make \
libstdc++ \
postgresql-dev

RUN gem install bundler -v "${BUNDLE_VERSION}"

WORKDIR $APP_PATH

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 20 --retry 5

COPY . .

CMD ["bundle", "exec", "rackup", "-p", "4567", "--host", "0.0.0.0"]
