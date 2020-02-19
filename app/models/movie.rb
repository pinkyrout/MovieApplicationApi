class Movie < ApplicationRecord
  has_many :shows
  validates_presence_of :name

  scope :active_movies, -> { where(is_active: true) }
end
