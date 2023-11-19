class Vote < ApplicationRecord
  belongs_to :reservation
  belongs_to :user

  validate :count_vote_per_reservation

  def count_vote_per_reservation
    current_user_id = User.find(self.user_id)
    current_user_voted_reservations = Vote.where(user_id:current_user_id, reservation_id:self.reservation.id)
    if  current_user_voted_reservations.count >= 1
      errors.add(:base, "１つの予約時間に対して１つしか投票できません")
    end
  end
end
