class UsageHistory < ApplicationRecord
    belongs_to :card
    belongs_to :room
end
