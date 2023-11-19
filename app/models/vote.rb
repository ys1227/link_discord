class Vote < ApplicationRecord
  belongs_to :reservation
  belongs_to :user
end
