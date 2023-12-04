require 'json'
class NotifySelectedMeetingTimeToQuestionOwnerJob < ApplicationJob
  queue_as :default

  def perform(reservation, user)
   puts "質問者さんへ投表時間が決まりました"
    user = reservation.question.user
    question_id = reservation.question.id
    channel_objects = Discordrb::API::User.create_pm("Bot #{ENV['DISCORD_BOT_TOKEN']}", user.uid)
    parse_objects = JSON.parse(channel_objects)
    channel_id = parse_objects["id"]
    # DMチャンネルIDを使用してメッセージを送信する
    Discordrb::API::Channel.create_message(
      "Bot #{ENV['DISCORD_BOT_TOKEN']}", 
      channel_id,
      '⚡️LinKDiscoアプリのお知らせBotです⚡️ あなたが募集したテーマの集合時間が決定したのでお知らせに来ました🤖',
      false, # tts
      [{
        title: '🚀あなたが募集した質問をクリックして見に行く🚀',
        description: "あなたが募集したテーマに対して集合時間が決まりました！\n 
        ⏰#{reservation.start_time.strftime('%m月%d日 %H時%M分')}からスタート⏰ \n 
        質問の詳細を見るには上記のリンクにアクセスしてね。 \n 🪐Let`s GO !! 🪐",
        url: "http://localhost:3000/questions/#{question_id}/reservations/index_vote"
      }]
    )
  end
end
