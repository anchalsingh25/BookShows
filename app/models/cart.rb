class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :price

  validates :quantity, presence: true
end
