class CreateUsageHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :usage_histories do |t|
      t.timestamp :when_used

      t.timestamps
    end
  end
end
