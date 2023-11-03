class Question < ApplicationRecord
  belongs_to :user
  has_many :categories
  has_many :messages

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 500 }
end
