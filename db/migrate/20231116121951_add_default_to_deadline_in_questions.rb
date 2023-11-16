class AddDefaultToDeadlineInQuestions < ActiveRecord::Migration[7.0]
  def change
    change_column_default :questions, :deadline, -> { 'NOW()' }
  end
end
