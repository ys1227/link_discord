class Question < ApplicationRecord
  belongs_to :user
  has_many :messages
  has_many :reservations, dependent: :destroy
  has_one :matching_time ,dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :role, presence: true
  enum role: { inquiry:0, small_talk:10, job_serching:20, portfolio:30, others:40 }
  enum state: { draft:0, published:10, closed:20 }

  scope :past_closed, -> { where('deadline <= ?', Time.current) }
end


# def matching_data_confirm
#   reservations = []
#   self.reservations.each do |reservation|
#     voted_count = reservation.votes.count
#     rank_value = Reservation.ranks[reservation.rank]  # enumの値を数値に変換
#     combined_value = [reservation.id, rank_value, reservation.start_time, voted_count]
#     reservations << combined_value
#   end
#   sorted_reservations = reservations.sort_by { |id, rank, start_time, votes| [-votes, rank] }
#   if sorted_reservations.all? { |reservation| reservation[3] == 0 }
#     self.user.NotifyUnvotedQuestionOwnerJob.set(wait: 30.seconds).perform_later
#   else
#     MatchingTime.create!(reservation_id:sorted_reservations[0][0], matching_data:sorted_reservations[0][2])
#     reservation = Reservation.find(sorted_reservations[0][0])
#     wait_time = 30
#     reservation.votes.each do |vote|
#       voted_user = vote.user
#       voted_user.NotifyMostVotedTimeParticipantsJob.set(wait: wait_time.seconds).perform_later(reservation)
#       wait_time += 30
#     end
#     self.user.NotifySelectedMeetingTimeToQuestionOwnerJob.set(wait: wait_time.seconds).perform_later(reservation)
#   end
# end


# 1人目のvoteの時: 30秒 2人目のvoteの時: 60秒 3人目のvoteの時: 90秒 4人目のvoteの時: 120秒 5人目のvoteの時: 150秒
# 最後のownerに知らせるJobのwait_timeは、5人目のvoteの後に実行されるから、150秒

