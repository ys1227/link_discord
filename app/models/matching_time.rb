class MatchingTime < ApplicationRecord
  belongs_to :reservation
  belongs_to :question
end
