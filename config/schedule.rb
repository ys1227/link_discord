# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# 開発環境で試すとき
# これだと環境変数が全部出力される
set :output, 'log/execute.log'
set :environment, :development
ENV.each { |k, v| env(k, v) }

# 本番環境
# require File.expand_path(File.dirname(__FILE__) + "/environment")  # rootパス取得
# set :environment, :development  # 実行環境の指定
# set :output, "#{Rails.root}/log/cron.log"  # ログファイルの出力先
# set :runner_command, "rails runner"
