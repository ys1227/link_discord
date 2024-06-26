require 'json'
class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :vote_reservations, through: :votes, source: :reservation
  has_many :vote_questions, through: :vote_reservations, source: :question

  validates :email, uniqueness: true
  validates :name, presence: true
  validates :email, presence: true
  validates :uid, presence: true


  scope :past_hour_user_create, -> { where('created_at < ?', 1.hour.ago) }

  def self.find_or_create_from_auth_hash(auth_hash)
    user_params = user_params_from_auth_hash(auth_hash)
    if guild_member?(user_params[:uid]) == true
      user = User.find_by(uid: user_params[:uid])
      if user
        user.update(user_params)
      else
        user = User.create!(user_params) do |new_user|
          if new_user.image == nil
            new_user.image = Discordrb::API::User.default_avatar(auth_hash[:extra][:raw_info][:discriminator])
          end
        end
      end
      return user
    end
  end

  def is_guest?
    if is_guest == true
      true
    end
  end

  def self.user_params_from_auth_hash(auth_hash)
    {
      name: auth_hash.info.name,
      email: auth_hash.info.email,
      image: auth_hash.info.image,
      uid: auth_hash.uid
    }
  end

  # 指定のサーバーに入っているユーザーのみにログインを制限する
  def self.guild_member?(uid)
    if guild_objects = Discordrb::API::Server.resolve_member("Bot #{ENV['DISCORD_BOT_TOKEN']}",
                                                             ENV['DISCORD_SERVER_ID'], uid.to_i)
      true
    else
      false
    end
  rescue Discordrb::Errors::UnknownMember => e
    # Discordrb::Errors::UnknownMemberエラーが発生した場合の処理
    false
  end
end
