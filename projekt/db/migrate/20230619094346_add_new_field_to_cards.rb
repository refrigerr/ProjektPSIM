class AddNewFieldToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :lost, :boolean, null: true, default: false
  end
end
