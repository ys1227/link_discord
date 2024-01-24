class AddIsdemoToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :is_demo, :boolean, default: false
  end
end
