class AddRoomToUsageHistories < ActiveRecord::Migration[7.0]
  def change
    add_reference :usage_histories, :room, null: false, foreign_key: true
  end
end
