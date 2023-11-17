class User < ApplicationRecord
   has_many :questions, dependent: :destroy
   has_many :messages, dependent: :destroy
   has_many :votes, dependent: :destroy
 
   validates :email, uniqueness: true
 
   class << self
     def find_or_create_from_auth_hash(auth_hash)
       user_params = user_params_from_auth_hash(auth_hash)
       find_or_create_by(uid: user_params[:uid]) do |user|
         user.update(user_params)
       end
      end
 
   private
 
   def user_params_from_auth_hash(auth_hash)
     {
       name: auth_hash.info.name,
       email: auth_hash.info.email,
       image: auth_hash.info.image,
       uid: auth_hash.uid,
     }
   end
  end
end 
