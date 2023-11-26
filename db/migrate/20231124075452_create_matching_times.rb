class CreateMatchingTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :matching_times do |t|
      t.references :reservation, null: false, foreign_key: true
      t.datetime :matching_data, null: false
      t.timestamps
    end
  end
end
