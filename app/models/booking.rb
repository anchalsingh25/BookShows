class Booking < ApplicationRecord
  belongs_to :booking_item
  belongs_to :user

  
end
