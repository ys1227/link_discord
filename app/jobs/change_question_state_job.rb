class ChangeQuestionStateJob < ApplicationJob
  queue_as :default

  def perform
    update_question_state
  end

  def update_question_state
    reservations = []
    wait_time = 0
    puts DateTime.now
    Question.published.past_closed.find_each do |question|
    question.update!(state: "closed")
    ConfirmMachingDateJob.set(wait: wait_time.seconds).perform_later(question)
    wait_time += 240
    end
  end
end

