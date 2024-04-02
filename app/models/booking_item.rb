class BookingItem < ApplicationRecord
  belongs_to :event
  belongs_to :location

  validates :quantity, presence: true
end
