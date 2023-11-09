class ChangeNameToUsers < ActiveRecord::Migration[7.0]
  def up
    remove_column :users, :first_name
    remove_column :users, :last_name
    add_column(:users, :name, :string, null: true)
  end

  def down
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    remove_column :users, :name
  end
end
