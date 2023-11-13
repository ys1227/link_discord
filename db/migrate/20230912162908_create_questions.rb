class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title, null:false
      t.text :content, null:false
      t.integer :role, default:0, null:false
      t.datetime :deadline, null:false
      t.timestamps
    end
  end
end
