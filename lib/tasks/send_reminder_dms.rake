namespace :reminder do
  desc "dead"
  task send_reminder_dms: :environment do
    bot_token = 'ボットのトークン'
    bot = Discordrb::Bot.new token: bot_token

    Question.where('deadline < ?', Time.current).find_each do |question|
      send_dm_to_user(bot, question.user.discord_id, "締め切りが過ぎているタスクがあります: #{question.title}")
    end

    bot.run(:async) # ボットを非同期で動かす
  end

  def send_dm_to_user(bot, discord_id, message)
    user = bot.user(discord_id)
    user.dm(message)
  rescue Discordrb::Errors::UnknownError => e
    puts "Failed to send DM: #{e.message}"
  end
end

namespace :reminder do
  desc "Run Discord bot"
  task run_bot: :environment do
    require 'discordrb'
    
    bot = Discordrb::Bot.new(client_id: ENV['DISCORD_CLIENT_ID'], token: ENV['DISCORD_BOT_TOKEN'], intents: [:server_messages])

    bot.message(with_text: '!dm') do |event|
      user_id = event.user.id
      user = bot.user(user_id)
      user.dm('ここにDMの内容を入れる')
    end

    bot.run(:async) # 非同期でBotを実行
  end
end

namespace :question_state do
  desc 'publishedの中で、deadlineカラムが過去になっているものがあれば、ステータスをclosedに変更されるようにする'
  task update_question_state: :environment do
    Question.published.past_closed.find_each(&:closed!)
  end
end

# Question.publishedでstatusカラムがpublishedのオブジェクトが表示される
# past_closedメソッドでdeadlineカラムが現在時刻よりも前になってしまっているquestionオブジェクトを探す
# それのカラムのstateをclosedに変える