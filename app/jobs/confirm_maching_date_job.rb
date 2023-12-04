class ConfirmMachingDateJob < ApplicationJob
  queue_as :confirm_date

  def perform(question)
    reservations = []
    question.reservations.each do |reservation|
      voted_count = reservation.votes.count
      rank_value = Reservation.ranks[reservation.rank]  # enumの値を数値に変換
      combined_value = [reservation.id, rank_value, reservation.start_time, voted_count]
      reservations << combined_value
    end
    sorted_reservations = reservations.sort_by { |id, rank, start_time, votes| [-votes, rank] }
    if sorted_reservations.all? { |reservation| reservation[3] == 0 }
      NotifyUnvotedQuestionOwnerJob.perform_later(question.user,question)
    else
      MatchingTime.create!(reservation_id:sorted_reservations[0][0],matching_data:sorted_reservations[0][2])
      reservation = Reservation.find(sorted_reservations[0][0])
      wait_time = 5
      reservation.votes.each do |vote|
        voted_user = vote.user
        NotifyMostVotedTimeParticipantsJob.set(wait: wait_time.seconds).perform_later(reservation,voted_user)
        wait_time += 5
      end
      NotifySelectedMeetingTimeToQuestionOwnerJob.set(wait: wait_time.seconds).perform_later(reservation,question.user)
    end
  end
end
