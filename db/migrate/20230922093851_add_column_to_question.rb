class AddColumnToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :user, foreign_key: true
  end
end
