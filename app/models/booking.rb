class Booking < ApplicationRecord
  
  belongs_to :user, optional: true
  belongs_to :show
  has_many   :seats
end
