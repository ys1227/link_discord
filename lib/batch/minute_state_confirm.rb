class  Batch::MinuteStateConfirm
  def self.update_question_state
    Question.published.past_closed.find_each do |question|
    question.update!(state: "closed")
    end
  end
end

