class LocationPriceEventMapping < ApplicationRecord
  belongs_to :event
  belongs_to :price
  belongs_to :location
end
