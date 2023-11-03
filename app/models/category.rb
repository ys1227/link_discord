class Category < ApplicationRecord
  belongs_to :question
  enum role: { question: 0, talk: 1 }

end
