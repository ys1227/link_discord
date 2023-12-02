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

  def matching_data_confirm
    reservations = []
    self.reservations.each do |reservation|
      voted_count = reservation.votes.count
      rank_value = Reservation.ranks[reservation.rank]  # enumの値を数値に変換
      combined_value = [reservation.id, rank_value, reservation.start_time, voted_count]
      reservations << combined_value
    end
    reservations.sort_by { |id, rank, start_time, votes| [-votes, rank] }
    if reservations.all? { |reservation| reservation[3] == 0 }
      self.user.send_dm_about_no_voted_user.set(wait: 30.second).perform_later
    else
      MatchingTime.create!(reservation_id:reservations[0][0],matching_data:reservations[0][2])
        Reservation.find(reservations[0][0]).votes.each do |vote|
          voted_user = vote.user
          voted_reservation = Reservation.find(reservations[0][0])
          voted_user.send_dm_to_most_voted_user(voted_reservation).set(wait: 30.second).perform_later
        end
      voted_reservation = Reservation.find(reservations[0][0])
      self.user.send_dm_to_question_user(voted_reservation).set(wait: 30.second).perform_later
    end
  end

end
