class Show < ApplicationRecord
  belongs_to :movie
  
  has_many   :seats
  has_many   :bookings

  scope :active_shows, -> { where('date >= ?', Date.today) }
end
