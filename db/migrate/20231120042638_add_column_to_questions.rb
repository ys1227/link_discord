class AddColumnToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :is_closed, :boolean, null:false, default: true
  end
end
