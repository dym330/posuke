FROM ruby:2.5.7
# ベースにするイメージを指定

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-mysql-client vim
# RailsのインストールやMySQLへの接続に必要なパッケージをインストール

RUN mkdir /posuke
# コンテナ内にposukeディレクトリを作成

WORKDIR /posuke
# 作成したposukeディレクトリを作業用ディレクトリとして設定

COPY Gemfile /posuke/Gemfile
COPY Gemfile.lock /posuke/Gemfile.lock
# ローカルの Gemfile と Gemfile.lock をコンテナ内のposuke配下にコピー

RUN bundle install
# コンテナ内にコピーした Gemfile の bundle install

COPY . /posuke
# ローカルのposuke配下のファイルをコンテナ内のposuke配下にコピー