class AddStateToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :state, :integer, null:false, default: 0
  end
end
