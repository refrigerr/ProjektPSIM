class CreateCardsHistory < ActiveRecord::Migration[7.0]
  def change
    create_table :cards_histories, id:false do |t|
      t.belongs_to :usage_history, index: true
      t.belongs_to :card, index: true
    end
  end
end
