class CreateRoomsCards < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms_cards, id:false do |t|
      t.belongs_to :room, index: true
      t.belongs_to :card, index: true
    end
  end
end
