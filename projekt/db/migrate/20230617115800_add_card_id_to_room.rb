class AddCardIdToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :rooms, :card_id, :integer
  end
end
