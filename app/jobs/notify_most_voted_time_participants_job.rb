require 'json'
class NotifyMostVotedTimeParticipantsJob < ApplicationJob
  queue_as :default

  def perform(reservation, user)
    begin
      question_id = reservation.question.id
      channel_objects = Discordrb::API::User.create_pm("Bot #{ENV['DISCORD_BOT_TOKEN']}", user.uid)
      parse_objects = JSON.parse(channel_objects)
      channel_id = parse_objects["id"]
      # DMチャンネルIDを使用してメッセージを送信する
      Discordrb::API::Channel.create_message(
        "Bot #{ENV['DISCORD_BOT_TOKEN']}",
        channel_id,
        '⚡️LinKDiscoアプリのお知らせBotです⚡️ あなたが投票したテーマの集合時間が決定したのでお知らせに来ました🤖',
        false, # tts
        [{
          title: '🚀あなたが投票した質問をクリックして見に行く🚀',
          description: "あなたが投票したテーマに対して集合時間が決まりました！\n
          ⏰#{reservation.start_time.strftime('%m月%d日 %H時%M分')}からスタート⏰ \n
          質問の詳細を見るには上記のリンクにアクセスしてね。 \n 🪐Let`s GO !! 🪐",
          url: "https://link-disco.onrender.com/questions/#{question_id}/matching_times"
        }]
      )
    rescue StandardError => e
      logger.error e
      raise e
    end
  end
end
