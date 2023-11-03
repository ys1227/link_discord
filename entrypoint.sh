#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /sample-app/tmp/pids/server.pid

# 前者はコンパイル済みのアセットを削除、後者は新しくアセットをコンパイルする
# production環境の場合のみJSとCSSをビルド

if [ "$RAILS_ENV" = "production" ]; then
bundle exec rails assets:clobber
bundle exec rails assets:precompile
bundle exec rails db:migrate
fi


# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
