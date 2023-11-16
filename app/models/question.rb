class Question < ApplicationRecord
  belongs_to :user
  has_many :messages
  has_many :reservations, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :role, presence: true
  #validate :start_check

  enum role: { inquiry:0, small_talk:10, job_serching:20, portfolio:30, others:40 }

  # def start_check
  #   errors.add(:deadline, "は現在の時間より遅い時間を選択してください") if self.deadline < Time.now
  # end
end
