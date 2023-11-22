class Question < ApplicationRecord
  belongs_to :user
  has_many :messages
  has_many :reservations, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :role, presence: true
  enum role: { inquiry:0, small_talk:10, job_serching:20, portfolio:30, others:40 }
  enum state: { draft:0, published:10, closed:20 }

  scope :past_closed, -> { where('deadline <= ?', Time.current) }
end
