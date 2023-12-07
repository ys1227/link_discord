require 'json'
class User < ApplicationRecord
   has_many :questions, dependent: :destroy
   has_many :messages, dependent: :destroy
   has_many :votes, dependent: :destroy
   has_many :vote_reservations, through: :votes, source: :reservation

   validates :email, uniqueness: true

    def self.find_or_create_from_auth_hash(auth_hash)
       user_params = user_params_from_auth_hash(auth_hash)
       if guild_member?(user_params[:uid]) == true
        find_or_create_by(uid: user_params[:uid]) do |user|
          user.update(user_params)
        end          
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

   # 指定のサーバーに入っているユーザーのみにログインを制限する
   def self.guild_member?(uid)
    # parse_objects = JSON.parse(guild_objects)
    # user_objects = parse_objects["user"]["id"]
    if guild_objects = Discordrb::API::Server.resolve_member("Bot #{ENV['DISCORD_BOT_TOKEN']}", ENV['DISCORD_SERVER_ID'],uid.to_i)
    return true
    else
      return false
    end
  end
end 
