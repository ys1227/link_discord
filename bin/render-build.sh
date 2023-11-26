#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
bundle exec rails assets:precompile  # cssはsprocketsを使っているため
bundle exec rails assets:clean 
bundle exec rails db:migrate
