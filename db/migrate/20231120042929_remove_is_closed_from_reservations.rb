class RemoveIsClosedFromReservations < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :is_closed, :boolean
  end
end
