FROM ruby:3.1.4

RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn postgresql-client


RUN apt-get update \
    && apt-get install -y libsqlite3-dev


# ファイル編集用のvimをインストール
RUN apt-get install -y vim


# Ruby-2.7以降だと`gem install bundler`がないとエラーが発生する
RUN gem install bundler -v 2.4.22

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY . /app

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "8080"]%
