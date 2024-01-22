require 'json'
class NotifyUnvotedQuestionOwnerJob < ApplicationJob
  queue_as :default

  def perform(user, question)
    begin
      question_id = question.id
      channel_objects = Discordrb::API::User.create_pm("Bot #{ENV['DISCORD_BOT_TOKEN']}", user.uid)
      parse_objects = JSON.parse(channel_objects) # parse_objectはhashになる
      channel_id = parse_objects["id"].to_i
      # DMチャンネルIDを使用してメッセージを送信する
      Discordrb::API::Channel.create_message(
        "Bot #{ENV['DISCORD_BOT_TOKEN']}",
        channel_id,
        '⚡️LinKDiscoアプリのお知らせBotです⚡️ あなたが募集したテーマの締め切り時間がきたので結果をお知らせに来ました🤖',
        false, # tts
        [{
          title: '🚀あなたが募集した質問をクリックして見に行く🚀',
          description: "あなたが募集したテーマは投票人数が0人でした。応募する場合は質問をもう一度作成して募集してみてね！\n
          質問の詳細を見るには上記のリンクにアクセスしてね。 \n 🪐Let`s GO !! 🪐",
          url: "https://link-disco.onrender.com/questions/#{question_id}"
        }]
      )
    rescue StandardError => e
      logger.error e
      # リトライ処理にうつる
      raise e
    end
  end
end
