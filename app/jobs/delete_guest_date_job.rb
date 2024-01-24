class DeleteGuestDateJob < ApplicationJob
  queue_as :guest

  def perform(question)
    question.destroy
  end
end