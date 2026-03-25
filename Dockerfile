FROM ruby:3.3

RUN apt-get update -qq && \
  apt-get install -y \
  build-essential \
  libpq-dev \
  libyaml-dev \
  nodejs \
  postgresql-client \
  wget \
  gnupg \
  curl \
  unzip \
  chromium \
  chromium-driver

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["bash"]
