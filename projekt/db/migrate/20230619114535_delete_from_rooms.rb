class DeleteFromRooms < ActiveRecord::Migration[7.0]
  def change
    remove_column :rooms, :card_id
  end
end
