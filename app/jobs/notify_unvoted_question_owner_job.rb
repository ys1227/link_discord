require 'json'
class NotifyUnvotedQuestionOwnerJob < ApplicationJob
  queue_as :default

  def perform(user)
    puts "質問者さんへ誰も投票しませんでした"
  end
  #   channel_objects = Discordrb::API::User.create_pm("Bot #{ENV['DISCORD_BOT_TOKEN']}", user.uid)
  #   parse_objects = JSON.parse(channel_objects) # parse_objectはhashになる
  #   channel_id = parse_objects["id"].to_i
  #   # DMチャンネルIDを使用してメッセージを送信する
  #   Discordrb::API::Channel.create_message(
  #     "Bot #{ENV['DISCORD_BOT_TOKEN']}",
  #     channel_id,
  #     '⚡️LinKDiscoアプリのお知らせBotです⚡️ あなた募集したテーマの締め切り時間がきたので結果をお知らせに来ました🤖',
  #     false, # tts
  #     [{
  #       title: '🚀あなたが投票した質問をクリックして見に行く🚀',
  #       description: "あなたが投票したテーマは投票人数が0人でした。応募する場合は質問を作成して募集してみてね！\n 
  #       質問の詳細を見るには上記のリンクにアクセスしてね。 \n 🪐Let`s GO !! 🪐"
  #     }]
  #   )
  # end
end
