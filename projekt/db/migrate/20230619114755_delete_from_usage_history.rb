class DeleteFromUsageHistory < ActiveRecord::Migration[7.0]
  def change
    remove_column :usage_histories, :when_used
  end
end
