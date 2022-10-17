FROM ruby:3.1.2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn postgresql-client

WORKDIR /cook_sharing

COPY Gemfile /cook_sharing/Gemfile
COPY Gemfile.lock /cook_sharing/Gemfile.lock

RUN gem install bundler
RUN yarn install
RUN bundle install

COPY . /cook_sharing

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]