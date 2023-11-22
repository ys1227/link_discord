#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
yarn build # jsファイルをesbuildでバンドルしているため
bundle exec rake assets:precompile # cssはsprocketsを使っているため
bundle exec rails db:migrate # migrateはridgepoleを使っているため（標準のmigrateを使うならbundle exec rails db:migrateで良いかと思います）
