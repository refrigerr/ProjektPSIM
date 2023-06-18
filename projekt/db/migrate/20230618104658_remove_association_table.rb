class RemoveAssociationTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :cards_histories
  end
end
