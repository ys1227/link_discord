class SendDmJob < ApplicationJob
  queue_as :default

  def perform
    puts Time.now
    self.update_question_state
  end

  def update_question_state
    reservations = []
    puts DateTime.now
    Question.published.past_closed.find_each do |question|
    question.update!(state: "closed")
    question.matching_data_confirm
    end
  end
end
