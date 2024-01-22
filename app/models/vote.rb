class Vote < ApplicationRecord
  belongs_to :reservation
  belongs_to :user

  validate :count_vote_per_reservation
  validate :not_vote_question_owner

  def count_vote_per_reservation
    current_user_id = User.find(self.user_id)
    current_user_voted_reservations = Vote.where(user_id: current_user_id, reservation_id: self.reservation.id)
    if current_user_voted_reservations.count >= 1
      errors.add(:base, "１つの予約時間に対して１つしか投票できません")
    end
  end

  def not_vote_question_owner
    vote_reservation = Reservation.find(self.reservation_id)
    vote_question = vote_reservation.question
    if self.user == vote_question.user
      errors.add(:base, "このPostをした投稿主は投票できません")
    end
  end
end
