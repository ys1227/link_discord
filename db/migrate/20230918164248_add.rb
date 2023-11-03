class Add < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :category, index: true
  end
end
