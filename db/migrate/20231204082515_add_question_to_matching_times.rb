class AddQuestionToMatchingTimes < ActiveRecord::Migration[7.0]
  def change
    add_reference :matching_times, :question, null: false, foreign_key: true
  end
end
