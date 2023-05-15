FROM ruby:3.0.0

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    postgresql-client

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
