class Card < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :rooms, :join_table => :rooms_cards
    has_and_belongs_to_many :usage_histories, :join_table => :cards_histories
end
