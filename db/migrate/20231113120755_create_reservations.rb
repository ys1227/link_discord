class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.boolean :is_closed
      t.datetime :start_time, null:false
      t.integer :rank, null:false, default: 0
      t.references :question, null: false, foreign_key: true
      t.timestamps
    end
  end
end
