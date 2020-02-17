class Seat < ApplicationRecord
  belongs_to :show, optional: true
  belongs_to :booking, optional: true
end
