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
    
    # DMを定期実行で送るメソッド
    def send_dm_to_question_user(reservation)
      bot = Discordrb::Bot.new client_id: ENV['DISCORD_CLIENT_ID'], token: ENV['DISCORD_BOT_TOKEN'],intents: [:server_messages]
      begin
        # ユーザーのDiscord IDをもとにダイレクトメッセージ用のチャンネルを取得(pmメソッド)
        # userメソッドで引数にidをとってuserの情報を取得
        channel = bot.user(self.uid)&.pm
        if channel
          # メッセージを送信
          channel.send_message("あなたが募集した集合時間が決まりました。#{reservation.start_time}です！")
        else
          puts "Error: ダイレクトメッセージ用のチャンネルが見つかりませんでした。"
        end
      rescue Discordrb::Errors::NoPermission
        puts "Error: ダイレクトメッセージの送信権限がありません。"
      end
    end
  
    def send_dm_to_most_voted_user(reservation)
      bot = Discordrb::Bot.new client_id: ENV['DISCORD_CLIENT_ID'], token: ENV['DISCORD_BOT_TOKEN'],intents: [:server_messages]
      begin
        # ユーザーのDiscord IDをもとにダイレクトメッセージ用のチャンネルを取得(pmメソッド)
        # userメソッドで引数にidをとってuserの情報を取得
        channel = bot.user(self.uid)&.pm
        if channel
          # メッセージを送信
          channel.send_message("集合時間が決まりました。#{reservation.start_time}です！")
        else
          puts "Error: ダイレクトメッセージ用のチャンネルが見つかりませんでした。"
        end
      rescue Discordrb::Errors::NoPermission
        puts "Error: ダイレクトメッセージの送信権限がありません。"
      end
    end
  
    def send_dm_about_no_voted_user
      bot = Discordrb::Bot.new client_id: ENV['DISCORD_CLIENT_ID'], token: ENV['DISCORD_BOT_TOKEN'],intents: [:server_messages]
      begin
        # ユーザーのDiscord IDをもとにダイレクトメッセージ用のチャンネルを取得(pmメソッド)
        # userメソッドで引数にidをとってuserの情報を取得
        channel = bot.user(self.uid)&.pm
        if channel
          # メッセージを送信
          channel.send_message("誰も投票していませんでした。もう一度募集する場合は再度テーマを投稿してね。")
        else
          puts "Error: ダイレクトメッセージ用のチャンネルが見つかりませんでした。"
        end
      rescue Discordrb::Errors::NoPermission
        puts "Error: ダイレクトメッセージの送信権限がありません。"
      end
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

  # def vote(reservation)
  #   vote_reservations << reservation
  # end  
end 
