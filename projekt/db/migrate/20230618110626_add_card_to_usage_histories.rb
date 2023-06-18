class AddCardToUsageHistories < ActiveRecord::Migration[7.0]
  def change
    add_reference :usage_histories, :card, null: false, foreign_key: true
  end
end
