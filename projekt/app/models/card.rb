class Card < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :rooms, :join_table => :rooms_cards
    has_many :usage_histories, dependent: :destroy
end
