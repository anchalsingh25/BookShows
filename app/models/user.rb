class User < ApplicationRecord
  has_secure_password
  
  validates :email, uniqueness: true
  validates :password, presence: true, format: { with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}\z/, message: "must contain at least one digit, one lowercase letter, one uppercase letter, and be at least 8 characters long" }
  validates :username, :email, presence: true
  
  enum role: %i[user admin organizer]
  has_many :carts
end