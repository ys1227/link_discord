class User < ApplicationRecord
   has_many :questions, dependent: :destroy
   has_many :messages, dependent: :destroy
   has_many :votes, dependent: :destroy
   has_many :vote_reservations, through: :votes, source: :reservation

   validates :email, uniqueness: true

    def self.find_or_create_from_auth_hash(auth_hash)
       user_params = user_params_from_auth_hash(auth_hash)
       find_or_create_by(uid: user_params[:uid]) do |user|
         user.update(user_params)
       end
    end
  
    require 'json'
    def send_dm_to_question_user(reservation)
      user = reservation.question.user
      question_id = reservation.question.id
      # tokenを渡してOauth認証を行なっている.これでチャンネルのidのなどの情報が帰ってくる
      # https://discord.com/developers/docs/resources/user#create-dm
      # https://discord.com/developers/docs/resources/channel#channel-object chennelのオブジェクトをcrete_dmで返す
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
    
    def send_dm_to_most_voted_user(reservation)
      question_id = reservation.question.id
      # tokenを渡してOauth認証を行なっている.これでチャンネルのidのなどの情報が帰ってくる
      # https://discord.com/developers/docs/resources/user#create-dm
      # https://discord.com/developers/docs/resources/channel#channel-object chennelのオブジェクトをcrete_dmで返す
      channel_objects = Discordrb::API::User.create_pm("Bot #{ENV['DISCORD_BOT_TOKEN']}", self.uid)
      parse_objects = JSON.parse(channel_objects)
      channel_id = parse_objects["id"]
      # DMチャンネルIDを使用してメッセージを送信する
      Discordrb::API::Channel.create_message(
        "Bot #{ENV['DISCORD_BOT_TOKEN']}", 
        channel_id,
        '⚡️LinKDiscoアプリのお知らせBotです⚡️ あなた投票したテーマの集合時間が決定したのでお知らせに来ました🤖',
        false, # tts
        [{
          title: '🚀あなたが投票した質問をクリックして見に行く🚀',
          description: "あなたが投票したテーマに対して集合時間が決まりました！\n 
          ⏰#{reservation.start_time.strftime('%m月%d日 %H時%M分')}からスタート⏰ \n 
          質問の詳細を見るには上記のリンクにアクセスしてね。 \n 🪐Let`s GO !! 🪐",
          url: "http://localhost:3000/questions/#{question_id}/reservations/index_vote"
        }]
      )
    end
  
    def send_dm_about_no_voted_user
      # tokenを渡してOauth認証を行なっている.これでチャンネルのidのなどの情報が帰ってくる
      # https://discord.com/developers/docs/resources/user#create-dm
      # https://discord.com/developers/docs/resources/channel#channel-object chennelのオブジェクトをcrete_dmで返す
      channel_objects = Discordrb::API::User.create_pm("Bot #{ENV['DISCORD_BOT_TOKEN']}", self.uid)
      parse_objects = JSON.parse(channel_objects)
      channel_id = parse_objects["id"]
      # DMチャンネルIDを使用してメッセージを送信する
      Discordrb::API::Channel.create_message(
        "Bot #{ENV['DISCORD_BOT_TOKEN']}", 
        channel_id,
        '⚡️LinKDiscoアプリのお知らせBotです⚡️ あなた募集したテーマの締め切り時間がきたので結果をお知らせに来ました🤖',
        false, # tts
        [{
          title: '🚀あなたが投票した質問をクリックして見に行く🚀',
          description: "あなたが投票したテーマは投票人数が0人でした。応募する場合は質問を作成して募集してみてね！\n 
          質問の詳細を見るには上記のリンクにアクセスしてね。 \n 🪐Let`s GO !! 🪐",
          url: "http://localhost:3000/questions/#{question_id}/reservations/index_vote"
        }]
      )
    end
 
   private
 
   def self.user_params_from_auth_hash(auth_hash)
     {
       name: auth_hash.info.name,
       email: auth_hash.info.email,
       image: auth_hash.info.image,
       uid: auth_hash.uid,
     }
   end
end 
