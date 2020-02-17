class User < ApplicationRecord
  MIN_USERNAME_LENGTH = 4
  has_secure_password

  has_many  :bookings

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: MIN_USERNAME_LENGTH }
  validates :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
