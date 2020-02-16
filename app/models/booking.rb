class Booking < ApplicationRecord
  
  belongs_to :user
  belongs_to :show
  has_many   :seats
end
