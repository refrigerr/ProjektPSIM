class Room < ApplicationRecord
    has_and_belongs_to_many :cards, :join_table => :rooms_cards
end
