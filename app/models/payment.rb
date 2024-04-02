class Payment < ApplicationRecord
  belongs_to :event
  belongs_to :booking
  validates :price, presence: true
end
