class RemoveIsClosedFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :is_closed, :boolean
  end
end
