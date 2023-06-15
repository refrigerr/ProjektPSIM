class UsageHistory < ApplicationRecord
    has_and_belongs_to_many :cards, :join_table => :cards_histories
end
